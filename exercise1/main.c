#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <omp.h>
#include <getopt.h>
#include <mpi.h>

//functions:
void write_pgm_image( void *image, int maxval, int xsize, int ysize, const char *image_name);
//void initialize_serial(char* filename, unsigned char * world, long size);
void choose_initialization(const char * filename, long size, int * argc, char ** argv[]);
void run_static(char * filename, int times, int snap, int * argc, char ** argv[]);
void run_ordered(char * filename, int times, int snap , int * argc, char ** argv[]);


#define SIZE 10

//number that identifies the dead elements
#define MAXVAL 255

//initialize the playground
#define INIT 1

//run the playground
#define RUN 2

//default playground size
#define K_DFLT 100

//default number of iterations
#define N_DFLT 50

//default number of iterations between each snap
#define SNAP_DFLT 5

//evolution types
#define ORDERED 0
#define STATIC  1




int main(int argc, char * argv[]){

    //we initialize options with default values:

    //default playground size
    int k = K_DFLT;

    //default evolution type
    int e = ORDERED;

    //default number of steps to be calculated
    int n = N_DFLT;

    //by default, every how many steps a dump of the system is saved on a file
    int snap = SNAP_DFLT;

    //by default, name of the file to be read/written
    char *filename = "init";

    //by default, do not initialize the playground
    int action = 0;


    char *optstring = "irk:e:f:n:s:";
//    long size = SIZE;


    int c;

    unsigned char* world;
    

    while ((c = getopt(argc, argv, optstring)) != -1) {
        switch(c) {
      
        case 'i':
            action = INIT; break;
      
        case 'r':
            action = RUN; break;
      
        case 'k':
            k = atoi(optarg); break;

        case 'e':
            e = atoi(optarg); break;

        case 'f':
            filename = (char*)malloc( sizeof(optarg)+1 );
            sprintf(filename, "%s", optarg);
            break;

        case 'n':
            n = atoi(optarg); break;

        case 's':
            snap = atoi(optarg); break;

        default :
        printf("argument -%c not known\n", c ); break;
        }
    }


    //asked: if snap=0, just print the playground at the end of the game
    if(snap == 0){
        snap = 500000;
    }

    //just to check:
    printf("You have chosen %d as the playground size, %d as evolution model\n", k, e);
    printf("%s as name of file to be read, \n%d as the number of steps to evaluate, %d as snaps step\n", filename, n, snap);


    //if -i is passed:
    if(action == INIT){
        printf("Initialize matrix\n");
        printf("Overall number of elements = %ld\n", k*k);
	printf("qua ci sono\n");
        choose_initialization(filename, k, &argc, &argv);
    }


    //if -r and -e0 are passed:
    if(action == RUN & e == ORDERED){
        printf("Run ordered\n");
        run_ordered(filename, n, snap, &argc, &argv);
    }
  
    //if -r and -e1 are passed:
    if(action == RUN & e == STATIC){
        printf("Run static\n");
        run_static(filename, n, snap, &argc, &argv);
    }
  

  return 0;
    
}

