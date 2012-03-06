Message-ID: <4F55C306.8020307@domain.hid>
Date: Tue, 06 Mar 2012 08:55:50 +0100
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid>
In-Reply-To: <4F50A422.50208@domain.hid>
Content-Type: multipart/mixed; boundary="------------070005080603050401080801"
Subject: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------070005080603050401080801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

it seems that i have a big problem with preemption.  (kernel 2.6.31, arm 
freescale imx25, xenomai 2.5.6 )
I send a simple application that doesn't work.

The task with name 'task2ms' has higher priority than 'taskPrintf', but 
'taskPrintf' stop the task 'task2ms' until sleeps.

I think i have a problem with ipipe porting.

Any idea ?

-- 
+------------------------------------------------------------------------------------------------+
							
Roberto Bielli
Sviluppo Software					
Axel S.r.l.					
							
Via Del Cannino, 3 				
21020 Crosio Della Valle			
Varese - Italy					
							
Telefono: +39 0332 949600			
Fax:      +39 0332 969315			
							
E-mail:   roberto.bielli@domain.hid	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@domain.hid

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


--------------070005080603050401080801
Content-Type: text/plain;
 name="axc25xendriverCANtest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="axc25xendriverCANtest.c"

#include <stdio.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <string.h>

#include <stdlib.h>
#include <stdio.h>
#include <sys/mman.h>	/* for MCL_CURRENT and MCL_FUTURE */
#include <rtdm/rtdm.h>
#include <native/task.h>

#define RTXENDRIVER_TYPE                RTDM_CLASS_TESTING
#define RTXENDRIVER_SUBCLASS            0
#define DEVICE_NAME						"axc25xendriverCAN"

/*---------------------------PRIVATE DATA---------------------------------*/

#define GPIO6_ON 		*Gpio2ValAddr |= 1 << 6
#define GPIO6_OFF		*Gpio2ValAddr &= ~(1 << 6);

static RT_TASK rt_task_desc;

typedef unsigned int canid_t;

struct can_frame {
	canid_t can_id;  /* 32 bit CAN_ID + EFF/RTR/ERR flags */
	unsigned char    can_dlc; /* data length code: 0 .. 8 */
	unsigned char    data[8] __attribute__((aligned(8)));
};

/* valid bits in CAN ID for frame formats */
#define CAN_SFF_MASK 0x000007FFU /* standard frame format (SFF) */
#define CAN_EFF_MASK 0x1FFFFFFFU /* extended frame format (EFF) */
#define CAN_ERR_MASK 0x1FFFFFFFU /* omit EFF, RTR, ERR flags */

/* special address description flags for the CAN_ID */
#define CAN_EFF_FLAG 0x80000000U /* EFF/SFF is set in the MSB */
#define CAN_RTR_FLAG 0x40000000U /* remote transmission request */
#define CAN_ERR_FLAG 0x20000000U /* error frame */



int device;
	//dati per la gestione memoria mappata
static unsigned long * Gpio2ValAddr = NULL;

/*---------------------------PUBLIC FUNCTIONS------------------------------*/
RT_TASK tskDesc;
RT_TASK tskCan;
RT_TASK tskDesc1;

int read_index =0;
int write_index =0;
#define SIZE_BUFFER 64

struct can_frame globCanFrameBuffer[SIZE_BUFFER];

volatile int x;
volatile int y;

/*void taskCan( void * params )
{
	struct can_frame frame;
	int nbytes;
		
	for(;;)
	{
		nbytes = rt_dev_read( device, &frame, sizeof( frame ));
	}
}*/

void task2ms( void * params )
{
	struct can_frame frame;
	int nbytes;
		
	for(;;)
	{
		GPIO6_ON;
		rt_task_sleep( 2000000 );
		GPIO6_OFF;
	}
}

void taskPrintf( void * params )
{
	for(;;)
	{
		for( x=0; x < 1000000; x++ );
		for( x=0; x < 1000000; x++ );
		rt_task_sleep( 10000000 ); 
	}
}



/*void taskRead( void * params )
{
	struct can_frame frame;
	int i;


	while (1 )
	{
		//rt_task_sleep( 10000000 );
		int nbytes;
		GPIO6_ON;
		nbytes = rt_dev_read( device, &frame, sizeof( frame ));
		GPIO6_OFF;
		//for( x=0; x < 1000000; x++ );
		//for( x=0; x < 1000000; x++ );
		
		

		if( nbytes != sizeof( frame ) )
		{
			printf( "Incomplete rtr CAN frame\n" );
			return;
		}
		else
		{
			//rt_mutex_acquire( &mutex );
			globCanFrameBuffer[ write_index++ ] = frame;
			if( write_index == SIZE_BUFFER )
			{
				write_index = 0;
				//printf("Rec %d\n", SIZE_BUFFER  );
			}

			/*printf( "REC %03X, LEN %d, %02X %02X %02X %02X %02X %02X %02X %02X\n", frame.can_id, frame.can_dlc, 
						frame.data[0],
					frame.data[1],
					frame.data[2],
					frame.data[3],
					frame.data[4],
					frame.data[5],
					frame.data[6],
					frame.data[7]);
		//rt_mutex_release( &mutex );
		}
		
	}
}*/

/*void taskPrint( void * params )
{
	int localReadIndex;
	int i;

	while (1 )
	{
		rt_task_sleep( 10000000 );
		for( y=0; y < 1000000; y++ );
		for( y=0; y < 1000000; y++ );

		//rt_mutex_acquire( &mutex );
		/*if( write_index != read_index )
		{
			localReadIndex = read_index;
			read_index++;
			if( read_index == SIZE_BUFFER )
				read_index = 0;

			//rt_mutex_release( &mutex );

			printf( "RX: %04d - ", localReadIndex );
			printf( "Len: %1d - ",globCanFrameBuffer[localReadIndex].can_dlc  );
			printf( "ID: %08X - ",globCanFrameBuffer[localReadIndex].can_id  );
			for( i=0; i < globCanFrameBuffer[localReadIndex].can_dlc; i++ )
				printf( "%02X ", globCanFrameBuffer[localReadIndex].data[i]  );
			printf("\n");

		}

		else
			rt_mutex_release( &mutex );
	}
}*/

//#define QUANTUMTIMEMS 	  2
//#define QUANTUMTIMENS	  ( QUANTUMTIMEMS * 1000000 )

int main(int argc, char *argv[])
{
	int ret;
	char key;
	int nbytes;
	struct can_frame frame;
	int fd;
	
	//fprintf(stderr, "AXC25 CAN driver\n");

	// no memory-swapping for this programm
	ret = mlockall(MCL_CURRENT | MCL_FUTURE);
	if( ret )
	{
		perror("ERROR : mlockall has failled");
		exit(1);
	}

	//fd = open( "/dev/mem", O_RDWR | O_SYNC );
	//Gpio2ValAddr = (unsigned long  *)mmap(  NULL, 0x1000, PROT_READ | PROT_WRITE,  MAP_SHARED, fd, 0x53FD0000 );

	//rt_timer_set_mode( QUANTUMTIMENS );

    //rt_mutex_create( 	&mutex, "mutexWrite" );
	
	//
	// Turn the current task into a RT-task.
	// The task has no name to allow multiple program instances to be run
	// at the same time.
	//
	/*ret = rt_task_shadow(&rt_task_desc, NULL, 1, 0);
	if( ret != 0 )
	{
		fprintf(stderr, "ERROR : rt_task_shadow: %s\n", strerror(-ret));
		exit( 1 );
	}*/
	
	//open the device
	/*fprintf(stderr, "CAN open\n");*/
	/*device = rt_dev_open( DEVICE_NAME, 0 );
	if( device < 0 )
	{
		printf( "ERROR : can't open device %s (%s)\n", DEVICE_NAME, strerror( -device ));
		exit( 1 );
	}*/

		//partenza lettura
	//rt_task_spawn( &tskDesc, "taskRead", 0, 71, T_JOINABLE, taskRead, NULL );
		//partenza stampa
	//rt_task_spawn( &tskDesc1, "taskPrint", 0, 72, T_JOINABLE, taskPrint, NULL );

	//rt_task_spawn( &tskCan, "taskCan", 0, 99, T_JOINABLE, taskCan, NULL );
	rt_task_spawn( &tskDesc, "task2ms", 0, 99, T_JOINABLE, task2ms, NULL );
	rt_task_spawn( &tskDesc1, "taskPrintf", 0, 90, T_JOINABLE, taskPrintf, NULL );


	for(;;)
	{
		//rt_task_sleep(1000000000);
		sleep( 1 );
	}

	/*for(;;)
	{
		key = getchar();

		if( key == 'd' )
		{
			frame.can_id = 1;
			nbytes = rt_dev_write( device, &frame, sizeof( frame ));
			printf("end write\n");
		}
		else if( key == 'e' )
		{
			break;
		}
		else if( key == 's' )
		{
			frame.can_id  = 0x602;
			frame.can_id &= CAN_SFF_MASK;
			frame.can_dlc = 8;
			frame.data[ 0 ] = 0x40;
			frame.data[ 1 ] = 0x00;
			frame.data[ 2 ] = 0x10;
			frame.data[ 3 ] = 0x00;
			frame.data[ 4 ] = 0x00;
			frame.data[ 5 ] = 0x00;
			frame.data[ 6 ] = 0x00;
			frame.data[ 7 ] = 0x00;
			nbytes = rt_dev_write( device, &frame, sizeof( frame ));
			if( nbytes != sizeof( frame ) )
			{
				printf( "Incomplete trs CAN frame\n" );
			}
			else
			{
				printf( "CAN frame has been sent\n" );
			}
		}
		else if( key == 'r' )
		{
			frame.can_id  = 0x702;
			frame.can_id &= CAN_SFF_MASK;
			frame.can_id |= CAN_RTR_FLAG;
			frame.can_dlc = 1;
			frame.data[ 0 ] = 0x00;
			frame.data[ 1 ] = 0x00;
			frame.data[ 2 ] = 0x00;
			frame.data[ 3 ] = 0x00;
			frame.data[ 4 ] = 0x00;
			frame.data[ 5 ] = 0x00;
			frame.data[ 6 ] = 0x00;
			frame.data[ 7 ] = 0x00;
			nbytes = rt_dev_write( device, &frame, sizeof( frame ));
			if( nbytes != sizeof( frame ) )
			{
				printf( "Incomplete rtr CAN frame\n" );
			}
			else
			{
				printf( "CAN rtr frame has been sent\n" );
			}
		}
	}*/

	//rt_task_delete( &tskDesc );
	//rt_task_join( &tskDesc );

	//close the device
	//fprintf(stderr, "CAN close\n");
	/*ret = rt_dev_close( device );
	if( ret < 0 )
	{
		printf( "ERROR : can't close device %s (%s)\n", DEVICE_NAME, strerror( -ret ));
		exit( 1 );
	}*/

	return 0;
}

--------------070005080603050401080801--

