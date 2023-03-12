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



void evaluate_world_serial(unsigned char* world, unsigned char* new_world, long sizex, long sizey){ 
    //funzione che usa world solo tramite lettura, per stabilire se aggiornare o meno new_world
    

    int SUM;

    for(long k=0; k<sizex*sizey; k++){

        //solo per controllo
	    printf("%d\n", world[k]);

        //determiniamo il numero di riga e di colonna in cui siamo
        long row = k/sizex;
        long col = k%sizey;

        SUM = 0;

        //contiamo il numero di vive e di morte nelle circostanze
        SUM = world[(sizex+row-1)%sizex*sizex + (sizey+col-1)%sizey] 
            + world[(sizex+row+0)%sizex*sizex + (sizey+col-1)%sizey] 
            + world[(sizex+row+1)%sizex*sizex + (sizey+col-1)%sizey] 
            + world[(sizex+row-1)%sizex*sizex + (sizey+col+0)%sizey] 
            + world[(sizex+row+1)%sizex*sizex + (sizey+col+0)%sizey] 
            + world[(sizex+row-1)%sizex*sizex + (sizey+col+1)%sizey] 
            + world[(sizex+row+0)%sizex*sizex + (sizey+col+1)%sizey] 
            + world[(sizex+row+1)%sizex*sizex + (sizey+col+1)%sizey];


        //dividendo per il valore (MAXVAL=255) che rappresenta le celle morte
        //otteniamo il numero di morti che circondano la cella in posizione (row, col)
        SUM = SUM/MAXVAL;

        //di default, la facciamo morire
        new_world[k] = MAXVAL;

        //ma se per caso è circondata da 2 o 3 celle vive sulle 8 vicine,
        //che è analogo a dire che è circondata da 5 o 6 celle morte, allora vive
        if(SUM==5 || SUM==6){
            new_world[k] = 0;
        }
    }
}


void evaluate_world(unsigned char* world, unsigned char* new_world, long sizex, long sizey, int times, int pRank, int pSize, MPI_Status* status, MPI_Request* req){ 
    //funzione che usa world solo tramite lettura, per stabilire se aggiornare o meno new_world

    int SUM;

    for(long k=0; k<sizex*sizey; k++){

        //solo per controllo
	    printf("%d\n", world[k]);

        //determiniamo il numero di riga e di colonna in cui siamo
        long row = k/sizex;
        long col = k%sizey;

        SUM = 0;

        //contiamo il numero di vive e di morte nelle circostanze
        SUM = world[(sizex+row-1)%sizex*sizex + (sizey+col-1)%sizey] 
            + world[(sizex+row+0)%sizex*sizex + (sizey+col-1)%sizey] 
            + world[(sizex+row+1)%sizex*sizex + (sizey+col-1)%sizey] 
            + world[(sizex+row-1)%sizex*sizex + (sizey+col+0)%sizey] 
            + world[(sizex+row+1)%sizex*sizex + (sizey+col+0)%sizey] 
            + world[(sizex+row-1)%sizex*sizex + (sizey+col+1)%sizey] 
            + world[(sizex+row+0)%sizex*sizex + (sizey+col+1)%sizey] 
            + world[(sizex+row+1)%sizex*sizex + (sizey+col+1)%sizey];


        //dividendo per il valore (MAXVAL=255) che rappresenta le celle morte
        //otteniamo il numero di morti che circondano la cella in posizione (row, col)
        SUM = SUM/MAXVAL;

        //di default, la facciamo morire
        new_world[k] = MAXVAL;

        //ma se per caso è circondata da 2 o 3 celle vive sulle 8 vicine,
        //che è analogo a dire che è circondata da 5 o 6 celle morte, allora vive
        if(SUM==5 || SUM==6){
            new_world[k] = 0;
        }
    }


    //ora inviamo
    int tag_odd = 2*times;
    int tag_even = 2*times+1;

    //each process send his fist and last row to respectively the process with rank-1 and rank + 1.
    //Process 0 send his fist line to process size -1 
    //Process size-1 send his last row to process 0

    if(pRank == pSize-1){

    //cosa manda, quanti elementi, tipo elementi, processo a cui inviare, tag del messaggio, ...
      MPI_Isend(&new_world[(sizey-2)*sizex], sizex, MPI_UNSIGNED_CHAR, 0, tag_even, MPI_COMM_WORLD, req);
      MPI_Isend(&new_world[sizex], sizex, MPI_UNSIGNED_CHAR, pRank-1, tag_odd, MPI_COMM_WORLD, req);
      
      MPI_Recv(new_world, sizex, MPI_UNSIGNED_CHAR, pRank-1, tag_even, MPI_COMM_WORLD, status);
      MPI_Recv(&new_world[(sizey-1)*sizex], sizex, MPI_UNSIGNED_CHAR, 0, tag_odd, MPI_COMM_WORLD, status);
    }


    if(pRank == 0){
    
    //cosa manda, quanti elementi, tipo elementi, processo a cui inviare, tag del messaggio, ...
      MPI_Isend(&new_world[(sizey-2)*sizex], sizex, MPI_UNSIGNED_CHAR, 1, tag_even, MPI_COMM_WORLD, req);
      MPI_Isend(&new_world[sizex], sizex, MPI_UNSIGNED_CHAR, pSize-1, tag_odd, MPI_COMM_WORLD, req);

    //cosa riceve, quanti elementi, tipo elementi, processo da cui riceve, tag del messaggio, ... 
      MPI_Recv(new_world, sizex, MPI_UNSIGNED_CHAR, pSize-1, tag_even, MPI_COMM_WORLD, status);
      MPI_Recv(&new_world[(sizey-1)*sizex], sizex, MPI_UNSIGNED_CHAR, 1, tag_odd, MPI_COMM_WORLD, status);
    }

    if(pRank != 0 & pRank != pSize-1){

      MPI_Isend(&new_world[(sizey-2)*sizex], sizex, MPI_UNSIGNED_CHAR, pRank+1, tag_even, MPI_COMM_WORLD, req);
      MPI_Isend(&new_world[sizex], sizex, MPI_UNSIGNED_CHAR, pRank-1, tag_odd, MPI_COMM_WORLD, req);

      MPI_Recv(&new_world[(sizey-1)*sizex], sizex, MPI_UNSIGNED_CHAR, pRank+1, tag_odd, MPI_COMM_WORLD, status);
      MPI_Recv(new_world, sizex, MPI_UNSIGNED_CHAR, pRank-1, tag_even, MPI_COMM_WORLD, status);
    }
}

void grw_serial_static(unsigned char* world, long size, int snap, int times){

    //mondo ausiliario per fare lo switch tra lettura e scrittura
    unsigned char* new_world = (unsigned char *)malloc(size*size*sizeof(unsigned char));


    //secondo me non serve, ma controllare che non impazzisca se non abbiamo 
    //inizializzato new_world in qualche modo
    for(int i=0; i<size*size; i++){
        new_world[i] = world[i];
    }


    for(int i=0; i<times; i++){
        //OTTIMIZZABILE: usare puntatori ai mondi: 2 puntatori, si chiama una sola volta evaluate_world
            if(i%2==0){
                evaluate_world_serial(world, new_world, size, size); 
            }else{
                evaluate_world_serial(new_world, world, size, size);
            }

            if(i%snap==0){
                char * fname = (char*)malloc(60);
                sprintf(fname, "snap/image_STATIC_%03d",i);
	            write_pgm_image(world, MAXVAL, size, size, fname);
                free(fname);
            }
    }

    free(new_world);
}


void grw_parallel_static(unsigned char* world, int size, int pSize, int pRank, int* scounts, int* displs, int* rcounts_g, int* displs_g, int snap, int times){
    MPI_Status status;
    MPI_Request req;

    //mondi locali, ausiliari, di ogni processo
    //new_world raccoglie l'esito di Scatterv, temp_new_world è il mondo che ci permette di fare lo switch come in seriale
    unsigned char* new_world = (unsigned char *)malloc(scounts[pRank]*sizeof(unsigned char));
	unsigned char* temp_new_world = (unsigned char *)malloc(scounts[pRank]*sizeof(unsigned char));

    MPI_Scatterv(world, scounts, displs, MPI_UNSIGNED_CHAR, new_world, scounts[pRank], MPI_UNSIGNED_CHAR, 0, MPI_COMM_WORLD);

    
    //solo per fare un check
    printf("questo arriva al processo %d \n", pRank);
	
    for(int k=0; k<scounts[pRank]; k++){
		printf("%d ", new_world[k]);
	}

    printf("\n");


    for(int i=0; i<times; i++){

        //OTTIMIZZABILE tramite puntatori
        if(i%2==0){
           evaluate_world(new_world, temp_new_world, size, (long)scounts[pRank]/size, times, pRank, pSize, &status, &req); 
        }else{
           evaluate_world(temp_new_world, new_world, size, (long)scounts[pRank]/size, times, pRank, pSize, &status, &req);
        }

       if(i%snap==0){
		printf("QUA devo tornare al processo 0\n");
        
        //voglio che invii solo le righe utili, cioè scounts[pRank]-2 
        //quindi creo un contenitore che per ogni processo travasa solo le righe utili
        //poi uso un Gatherv
        unsigned char* process_world = (unsigned char *)malloc((scounts[pRank]-2*size)*sizeof(unsigned char));
        if(i%2==0){
           for(int k=size; k<scounts[pRank]-size; k++){
            process_world[k-size] = temp_new_world[k]; 
           }
        }else{
            for(int k=size; k<scounts[pRank]-size; k++){
              process_world[k-size] = new_world[k]; 
            }
        }


        MPI_Gatherv(process_world, rcounts_g[pRank], MPI_UNSIGNED_CHAR, world, rcounts_g, displs_g, MPI_UNSIGNED_CHAR, 0, MPI_COMM_WORLD);
        printf("il processo %d ha inviato %d elementi al processo 0\n", pRank, rcounts_g[pRank]);
        free(process_world); 


        if(pRank==0){
            unsigned char* world = (unsigned char *)malloc(size*size*sizeof(unsigned char));
            char * fname = (char*)malloc(60);
            sprintf(fname, "snap/image_STATIC_%03d",i);
	        write_pgm_image(world, MAXVAL, size, size, fname);
            free(fname);
        }

        }
    }

free(new_world);
free(temp_new_world);
}





void run_static(char * filename, int times, int dump, int * argc, char ** argv[]){

unsigned char* world;
int size=0;
int maxval=0;
//int snap=0;

int pRank, pSize;
MPI_Init(argc, argv);
MPI_Comm_rank(MPI_COMM_WORLD, &pRank);
MPI_Comm_size(MPI_COMM_WORLD, &pSize);  


//lettura in seriale:
read_pgm_image(&world, &maxval, &size, &size, filename);

//check per la lettura effettivamente avvenuta
for(int k=0; k<size*size; k++){
    printf("%d ", world[k]);
}


//mondo temporaneo che contiene anche le due righe di contorno: solo per caso parallelo
unsigned char* temp_world = (unsigned char *)malloc(size*(size+2)*sizeof(unsigned char));

//riempiamo il mondo in parallelo: si riempiono già la prima e l'ultima riga con ciò che vogliamo avere 
for(int i=0; i<size*(size+2); i++){
    
    if(i>= size & i<size*(size+1)){
            temp_world[i] = world[i-size];
    
    }else if(i<size){
	    temp_world[i]=world[size*(size-1)+i];
        
    }else{

	    temp_world[i]=world[i-size*(size+1)];
    }
    
  }

//vettori ausiliari a Scatterv
int* displs = (int *)malloc(pSize*sizeof(int)); 
int* scounts = (int *)malloc(pSize*sizeof(int)); 

//devo riempire i due vettori ausiliari
int smaller_size;
int cumulative=0;


//vettori ausiliari a Gatherv
int* displs_g = (int *)malloc(pSize*sizeof(int)); 
int* rcounts_g = (int *)malloc(pSize*sizeof(int)); 

//devo riempire anche qua i due vettori ausiliari
int smaller_size_g;
int cumulative_g=0;


//lo facciamo fare ad un solo processo, per evitare di fare girare inutilmente codice
if(pRank==0){

    printf("matrice generata:\n");
    //stampa per sicurezza/check
    for(int k=0; k<size*(size+2); k++){  
        printf("%d ", temp_world[k]);
    }
    printf("\n");

    //riempio i due vettori ausiliari per Scatterv:
    //scounts contiene il numero di elementi da assegnare ad ogni processo
    //mentre displs contiene l'indice dell'elemento da cui ogni processo parte a valutare
	for(int i=0; i<pSize; i++){
		
        //numero di righe che ogni processo si piglia
        smaller_size = size%pSize <= i? size/pSize: size/pSize+1;

		scounts[i]=(smaller_size+2)*size;
		displs[i]=cumulative;

        //incremento poi
		cumulative = cumulative+(scounts[i]-2*size);

        //solo per check
		printf("%d, %d\n", scounts[i], displs[i]);				
	}


    //riempio i due vettori ausiliari per Gatherv:
    //rcounts_g contiene il numero di elementi da assegnare ad ogni processo
    //mentre displs_g contiene l'indice dell'elemento da cui ogni processo parte a valutare
	for(int i=0; i<pSize; i++){
		
        //numero di righe che ogni processo si piglia
        smaller_size_g = size%pSize <= i? size/pSize: size/pSize+1;

		rcounts_g[i]=smaller_size_g*size;
		displs_g[i]=cumulative_g;

        //incremento poi
		cumulative_g = cumulative_g+rcounts_g[i];

        //solo per check
		printf("%d, %d\n", rcounts_g[i], displs_g[i]);				
	}

}


//rendiamo noto a tutti i processi qual è il contenuto dei due vettori ausiliari per Scatterv
MPI_Bcast(scounts, pSize, MPI_INT,0, MPI_COMM_WORLD);
MPI_Bcast(displs, pSize, MPI_INT, 0, MPI_COMM_WORLD);


//rendiamo noto a tutti i processi qual è il contenuto dei due vettori ausiliari per Gatherv
MPI_Bcast(rcounts_g, pSize, MPI_INT,0, MPI_COMM_WORLD);
MPI_Bcast(displs_g, pSize, MPI_INT, 0, MPI_COMM_WORLD);


if(pSize > 1){
	grw_parallel_static(temp_world, size, pSize, pRank, scounts, displs, rcounts_g, displs_g, dump, times); 
    
}else{
    grw_serial_static(world, size, dump, times);
}


free(temp_world);

free(world);
MPI_Finalize();
}
