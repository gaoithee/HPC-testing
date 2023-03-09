
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


void initialize_parallel(const char* filename, unsigned char * process_world, long size, int pSize, int pRank){
    
    //for example if we have size=10 and pSize=3, the work (i.e. rows) subdivision would be 4-3-3
    long smaller_size = size%pSize < pRank? size/pSize +1 : size/pSize;

    //size = number of columns, 
    //smaller_size = number of rows that each process need to analyze
    //smaller_size+2 = overall number of rows that each process receive -> one extra row above, one below
   process_world = (unsigned char *)malloc(size*(smaller_size+2)*sizeof(unsigned char));

    //SUCH AS THE SERIAL VERSION:
    for(long long i=size; i<size*smaller_size; i++){
        
        int val = rand()%100;
        if(val>50){
            process_world[i]=0; //white = dead
        }else{
            process_world[i]=MAXVAL; //black = alive
        }
    }

    for(int k=0; k<size*size; k++){
        printf("%d ", process_world[k]);
        if(k%size==0){
            printf("\n");
        }
    }

    write_pgm_image(process_world, MAXVAL, size, size, filename);

    free(process_world);
}

void choose_initialization(const char * filename, long size, int * argc, char ** argv[]){
    int pRank, pSize; 
    MPI_Status status;
    MPI_Request req;

    MPI_Init(argc, argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &pRank);
    MPI_Comm_size(MPI_COMM_WORLD, &pSize);
    unsigned char * world;
    if(pSize > 1){
	printf("parallelo\n");
        initialize_parallel(filename, world, size, pSize, pRank);
    }else{
	printf("seriale\n");
        initialize_serial(filename, world, size);
  }

  MPI_Finalize();
  free(world);
}
