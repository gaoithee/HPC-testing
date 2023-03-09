#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//#include <mpi.h>
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
        printf("%d ", SUM);

        //dead if 1 or 0 cells alive in its neighbours (due to undercrowding) or if 
        //more than 3 cells alive in its neighbours (due to overcrowding)
        new_world[k] = MAXVAL;

        //alive (encoded as 255) if 2 or 3 cells in its neighbours (made of 8 cells) are alive
        if(SUM==5 || SUM==6){
            new_world[k] = 0;
        }

        printf("%d\n", new_world[k]);

    }

}

void grw_serial_static(unsigned char* world, long size, int times, int snap){
    unsigned char* new_world = (unsigned char *)malloc(size*size*sizeof(unsigned char));

    for(int i=0; i<size*size; i++){
        new_world[i] = world[i];
        printf("%d", new_world[i]);
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

void run_static(char * filename, int times, int dump, int * argc, char ** argv[]){
  

  unsigned char * world;
  int size = 0;
  int maxval = 0; 
  
  //first of all, i need to read the previous world state
  printf("tutto bene \n");
  printf("controllino: %p, %p, %p, %d, %s \n", &world, &maxval, &size, size, filename);
  read_pgm_image(&world, &maxval, &size, &size, filename);

  printf("ancora tutto bene \n");

  printf("controllino #2: %p, %d, %d, %d\n", &world, size, times, dump);
  int temp=0;
  //for(int i=0; i<size*size; i++){
  //  printf("%d\n",  world[i]);
  //}
  
  grw_serial_static(world, size, times, dump);
  
  printf("\neccoci \n");



  free(world);
}



