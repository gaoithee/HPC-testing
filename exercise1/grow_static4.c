#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>
#include <string.h>
#include <omp.h>

#ifndef RW_PGM
#define RW_PGM
void read_pgm_image( unsigned char  **image, int *maxval, int *xsize, int *ysize, const char *image_name);
void write_pgm_image( unsigned char *image, int maxval, int xsize, int ysize, const char *image_name);
#endif



#define MAXVAL 255

#define CPU_TIME (clock_gettime( CLOCK_MONOTONIC, &ts ), (double)ts.tv_sec +	\
		  (double)ts.tv_nsec * 1e-9)

void evaluate_world(unsigned char* world, unsigned char* new_world, long size){ 
    int SUM;

    for(long k=0; k<size*size; k++){

        long row = k/size;
      long col = k%size;

        SUM = 0;

       SUM = world[(size+row-1)%size*size + (size+col-1)%size] 
            + world[(size+row+0)%size*size + (size+col-1)%size] 
            + world[(size+row+1)%size*size + (size+col-1)%size] 
            + world[(size+row-1)%size*size + (size+col+0)%size] 
            + world[(size+row+1)%size*size + (size+col+0)%size] 
            + world[(size+row-1)%size*size + (size+col+1)%size] 
            + world[(size+row+0)%size*size + (size+col+1)%size] 
            + world[(size+row+1)%size*size + (size+col+1)%size];


        SUM = SUM/MAXVAL; //number of (dead) elements that surround the selected cell
//        printf("%d ", SUM);

        //dead if 1 or 0 cells alive in its neighbours (due to undercrowding) or if 
        //more than 3 cells alive in its neighbours (due to overcrowding)
        new_world[k] = MAXVAL;

        //alive (encoded as 255) if 2 or 3 cells in its neighbours (made of 8 cells) are alive
        if(SUM==5 || SUM==6){
            new_world[k] = 0;
        }

//        printf("%d\n", new_world[k]);

    }

}

void grw_serial_static(unsigned char* world, long size, int times, int snap){
    unsigned char* new_world = (unsigned char *)malloc(size*size*sizeof(unsigned char));

    for(int i=0; i<size*size; i++){
        new_world[i] = world[i];
//        printf("%d", new_world[i]);
    }

    for(int i=0; i<times; i++){
        if(i%2==0){
            evaluate_world(world, new_world, size); 
        }else{
            evaluate_world(new_world, world, size);
        }

        if(i%snap==0){
            char * fname = (char*)malloc(60);
            sprintf(fname, "snap/image_STATIC_%03d",i);

        //we print ONLY these images
	        write_pgm_image(world, MAXVAL, size, size, fname);
            free(fname);
        }

    }
}


void grw_parallel_static(unsigned char* world, int size, int pSize, int pRank, int* scounts, int* displs, int times, int snap){
    unsigned char* new_world = (unsigned char *)malloc(scounts[pRank]*sizeof(unsigned char));
	unsigned char* temp_new_world = (unsigned char *)malloc(scounts[pRank]*sizeof(unsigned char));
    MPI_Scatterv(world, scounts, displs, MPI_UNSIGNED_CHAR, new_world, scounts[pRank], MPI_UNSIGNED_CHAR, 0, MPI_COMM_WORLD);

printf("questo arriva al processo %d \n", pRank);
	for(int k=0; k<scounts[pRank]; k++){
		printf("%d ", new_world[k]);
	}
printf("\n");
 for(int i=0; i<times; i++){
       if(i%2==0){
           evaluate_world(new_world, temp_new_world, size); 
        }else{
           evaluate_world(temp_new_world, new_world, size);
        }

       if(i%snap==0){
		printf("QUA devo tornare al processo 0\n");
   //         char * fname = (char*)malloc(60);
   //         sprintf(fname, "snap/image_STATIC_%03d",i);

        //we print ONLY these images
     //           write_pgm_image(world, MAXVAL, size, size, fname);
//            free(fname);
     }

   }
}


void run_static(char * filename, int times, int dump, int * argc, char ** argv[]){

unsigned char* world;
int size=0;
int maxval=0;
//int snap=0;

int pRank, pSize;
MPI_Status status;
MPI_Init(argc, argv);
MPI_Comm_rank(MPI_COMM_WORLD, &pRank);
MPI_Comm_size(MPI_COMM_WORLD, &pSize);  
 
  
  //first of all, i need to read the previous world state
//  printf("tutto bene \n");
  //printf("controllino: %p, %p, %p, %d, %s \n", &world, &maxval, &size, size, filename);



  //lettura in seriale:
  read_pgm_image(&world, &maxval, &size, &size, filename);
for(int k=0; k<size*size; k++){
printf("%d ", world[k]);
}

    int* displs = (int *)malloc(pSize*sizeof(int)); 
    int* scounts = (int *)malloc(pSize*sizeof(int)); 

//mondo temporaneo che contiene anche le due righe di contorno
  unsigned char* temp_world = (unsigned char *)malloc(size*(size+2)*sizeof(unsigned char));

  for(int i=0; i<size*(size+2); i++){
    if(i>= size & i<size*(size+1)){
        temp_world[i] = world[i-size];
    }else if(i<size){
	temp_world[i]=world[size*(size-1)+i];
        //temp_world[i] = world[size*(size-1)+i];
    }else{
	//temp_world[i] = 8;
	temp_world[i]=world[i-size*(size+1)];
    }
    //printf("%d\n", temp_world[i]);
  }
//printf("guarda qua\n");
int smaller_size;
int cumulative=0;




if(pRank==0){
printf("matrice generata:\n");
for(int k=0; k<size*(size+2); k++){  
        printf("%d ", temp_world[k]);
}
printf("\n");

	for(int i=0; i<pSize; i++){
		smaller_size = size%pSize <= i? size/pSize: size/pSize+1;
		scounts[i]=(smaller_size+2)*size;
		displs[i]=cumulative;
		cumulative = cumulative+(scounts[i]-2*size);
		printf("%d, %d\n", scounts[i], displs[i]);				
	}
	printf("%d %d\n", size*(size+2), cumulative);
}

MPI_Bcast(scounts, pSize, MPI_INT,0, MPI_COMM_WORLD);
MPI_Bcast(displs, pSize, MPI_INT, 0, MPI_COMM_WORLD);


if(pSize > 1){
//	printf("parallelo\n");
	for(int i=0; i<pSize; i++){
//        printf("processo %d ha %d come rcounts\n", pRank, scounts[i]);
	grw_parallel_static(temp_world, size, pSize, pRank, scounts, displs, times, dump);
    }
    
    //initialize_parallel(filename, world, size, pSize, pRank, rcounts, displs);
    //printf("processo %d è arrivato con %d elementi\n", pRank, rcounts[pRank]);
    //MPI_Barrier(MPI_COMM_WORLD);
	
    //if(pRank==0){
//		write_pgm_image(world, MAXVAL, size, size, filename);
//	}
    
}else{
	printf("seriale\n");
  grw_serial_static(world, size, times, dump);

}

free(temp_world);


    
//printf("ciao, sono %d\n", pRank);

//if(pRank==0){

	//for(int i=0; i<pSize; i++){
		//numero di righe che ogni processo dovrà gestirsi
		//smaller_size = size%pSize <= i? size/pSize: size/pSize+1;

		//numero di elementi che ogni processo dovrà gestirsi + riga sopra + riga sotto, già trasmesse
		//rcounts[i] = smaller_size*size;

		//indice del primo elemento che l'i-esimo processo deve inizializzare
		//displs[i] = cumulative;
		
		//aggiorno cumulative, che mi dice da quale elemento dovrà partire il processo successivo
		//cumulative = cumulative+rcounts[i];
		//printf("prima del broadcast, il processo 0 ha %d, %d\n", rcounts[i], displs[i]);
	//}
    
//printf("%d %d\n", size*size, cumulative);

//}



  //printf("ancora tutto bene \n");

  //printf("controllino #2: %p, %d, %d, %d\n", &world, size, times, dump);

//  if(pSize>1){
//    printf("here we go parallel");
//  }else{
 //   grw_serial_static(world, size, times, dump);
//  }
 
  
//  printf("\neccoci \n");
//MPI_Finalize();
free(world);
MPI_Finalize();
}



