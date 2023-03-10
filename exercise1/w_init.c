
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>
#include <omp.h>

//write function:
void write_pgm_image( void *image, int maxval, int xsize, int ysize, const char *image_name);

#define MAXVAL 255


void initialize_serial(const char* filename, unsigned char * world, long size){
    
    //size = number of elements in a row or in a column (a square matrix is used)
    world = (unsigned char *)malloc(size*size*sizeof(unsigned char));

    for(long long i=0; i<size*size; i++){
        
        int val = rand()%100;
        if(val>50){
            world[i]=0; //white = dead
        }else{
            world[i]=MAXVAL; //black = alive
        }
    }

    write_pgm_image(world, MAXVAL, size, size, filename);

    free(world);
}


void initialize_parallel(const char* filename, unsigned char * world, long size, int pSize, int pRank, int* rcounts, int* displs){
    
    //for example if we have size=10 and pSize=3, the work (i.e. rows) subdivision would be 4-3-3
    //long smaller_size = size%pSize <= pRank? (long)(size/pSize) : (long)(size/pSize) +1;

    //size = number of columns, 
    //smaller_size = number of rows that each process need to analyze
    //smaller_size+2 = overall number of rows that each process receive -> one extra row above, one below
   unsigned char * process_world = (unsigned char *)malloc(rcounts[pRank]*sizeof(unsigned char));


    //SUCH AS THE SERIAL VERSION:
    for(long long i=0; i<rcounts[pRank]; i++){
        
        int val = rand()%100;
        if(val>50){
            process_world[i]=0; //white = dead
        }else{
            process_world[i]=MAXVAL; //black = alive
        }
    }

    //for(int k=0; k<size*size; k++){
       // printf("%d ", process_world[k]);
       // if(k%size==0){
         //   printf("\n");
        //}
    //}
//printf("\n");

printf("qua dovrei scrivere\n");
//MPI_Gatherv(process_world, rcounts[pRank], MPI_UNSIGNED_CHAR, world, rcounts, displs,MPI_UNSIGNED_CHAR, 0, MPI_COMM_WORLD);

    free(process_world);
}

void choose_initialization(const char * filename, long size, int * argc, char ** argv[]){
    int pRank, pSize; 
    MPI_Status status;
    MPI_Request req;
unsigned char* world = (unsigned char)malloc(size*size);

    MPI_Init(argc, argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &pRank);
    MPI_Comm_size(MPI_COMM_WORLD, &pSize);
printf("ciao, sono %d\n", pRank);

//here the determination of rcounts and displs:
    long* displs = (int *)malloc(pSize*sizeof(long)); 
    long* rcounts = (int *)malloc(pSize*sizeof(long)); 

int smaller_size;
int cumulative=0;

if(pRank==0){

	for(int i=0; i<pSize; i++){
		smaller_size = size%pSize <= i? size/pSize: size/pSize+1;
		rcounts[i] = smaller_size*size*size;
		displs[i] = cumulative;
		cumulative = cumulative+smaller_size*size*size;
		printf("%d, %d\n", rcounts[i], displs[i]);
	}
}

printf("[proc %d]; prima del broadcast, ho %d e %d\n", pRank, *rcounts, *displs);

MPI_Bcast(rcounts, pSize, MPI_LONG, 0, MPI_COMM_WORLD);
MPI_Bcast(displs, pSize, MPI_LONG, 0, MPI_COMM_WORLD);

printf("[proc %d]: dopo il broadcast, ho %d e %d\n", pRank, *rcounts, *displs);

//l'idea qua è di fare calcolare a un solo processo tutte ste cose in modo da evitare comunicazioni tra processi
//perché qua pRank è diverso per ogni processo

//quindi tocca che il singolo processo si calcoli tutto!

//int cumul = 0;
//for(int i=0; i < pSize; i++){
    //int smaller_size = size%pSize <= pRank ? size/pSize +1 : size/pSize;
    //cumul += smaller_size*size;
//qua arrivano in vario ordine: 3-2-3-2, per esempio
//for(int i =0; i<pSize; i++){
//int smaller_size;
//	if(i!=pRank){
//		smaller_size= size%pSize < i ? size/pSize : size/ pSize+1;
//	}else{
//		smaller_size=size%pSize <= pRank ? size/pSize : size/pSize+1;
		//printf("%d\n", smaller_size);
//	}
//		rcounts[i] = smaller_size*size;
//		printf("%d, %d\n", i, rcounts[i]);
//}


//}

if(pSize > 1){
	printf("parallelo\n");
//        initialize_parallel(filename, world, size, pSize, pRank, rcounts, displs);
//	if(pRank==0){
//		MPI_Barrier(MPI_COMM_WORLD);
//		write_pgm_image(world, MAXVAL, size, size, filename);
//	}
}else{
	printf("seriale\n");
//        initialize_serial(filename, world, size);
  }

  MPI_Finalize();
  free(world);
}
