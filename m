Date: Mon, 24 Jan 2011 17:39:11 +0100 (CET)
From: Michel Rinaldi <automation.03@domain.hid>
Message-ID: <23405065.111295887148359.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <22536578.91295887083468.JavaMail.SYSTEM@PC-MRINALDI>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_9_431157.1295887148343"
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_9_431157.1295887148343
Content-Type: multipart/alternative; 
	boundary="----=_Part_10_32254135.1295887148343"

------=_Part_10_32254135.1295887148343
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


----- Messaggio originale -----=20
Da: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>=20
A: "Michel Rinaldi" <automation.03@domain.hid>=20
Cc: xenomai@xenomai.org
Inviato: Luned=C3=AC, 24 gennaio 2011 15:27:51 GMT +01:00 Amsterdam/Berlino=
/Berna/Roma/Stoccolma/Vienna=20
Oggetto: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join=
=20

.....=20

>You explanations are hard to follow and understand, and what is more,=20
>ambiguous. Send us a piece of code which allows us to reproduce this=20
>issue. Trying to make it as simple as possible. For instance seeing if=20
>registering the interrupt causes any difference (if it does not make any=
=20
>difference, then remove it, you get the idea).=20

My code is really big and complex to reduce, I'll try to simplify it in nex=
t days.=20

>As usual, we do not know what version of Xenomai, Adeos, Linux, etc...=20
>you are using. See:=20
>http://www.xenomai.org/index.php/Request_for_information=20

I post them into firts mail of this thread, anyway they are:=20
- Linux system with kernel 2.6.35.7=20
- Xenomai 2.5.5.2=20
- Adeos ipipe patch 2.7-04=20
GCC is on version 4.4.3.=20

.....=20

>That is bad. One more question: what happens when you run the "latency"=20
>test, do you get strange results? Also, I see that you have the SMI=20
>workaround enabled, does it detect your chipset?=20

Yes, as system log says, Xenomai detect SMI motherboard and disable them.=
=20
I run the latency test: without other loads onto system, I observe values l=
ike these:=20

RTT| 00:00:01 (periodic user-mode task, 100 us period, priority 99)=20
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat w=
orst=20
RTD| 6.680| 7.157| 12.187| 0| 0| 6.680| 12.187=20
RTD| 6.277| 6.980| 10.519| 0| 0| 6.277| 12.187=20
RTD| 1.175| 7.122| 9.315| 0| 0| 1.175| 12.187=20
RTD| 1.578| 7.112| 9.382| 0| 0| 1.175| 12.187=20
RTD| 1.635| 7.133| 10.307| 0| 0| 1.175| 12.187=20

also after long runnings.=20

But if I launch application contained into attached main_app.c file (that r=
epresents my simplified application)=20
what I observe into latency test is:=20

RTD| 1.635| 7.133| 10.307| 0| 0| 1.175| 12.187=20
RTD| 1.591| 20.101| 129847.817| 1298| 0| 1.175| 129847.817=20
RTD| 1.860| 7.133| 12.814| 1298| 0| 1.175| 129847.817=20

Then, if I CTRL+C my app:=20

RTD| 2.091| 7.468| 15.687| 1298| 0| 1.175| 129847.817=20
RTD| 1.861| 8.397| 8157.893| 1379| 0| 1.175| 129847.817=20
RTD| 6.282| 7.287| 15.007| 1379| 0| 1.175| 129847.817=20

In concomitance with first very high latency, I observe into dmesg the cloc=
ksource switch message.=20


In one case I observed an extremely bigger value for lat max: in facts, sys=
tem freezed for about 2 seconds.=20

RTD| 2.091| 7.468| 11.687| 0| 0| 1.133| 20.817=20
RTD| 1.436| 254.870|-1819173.554| 24758| 0| 1.133|-1819173.554=20
RTD| 1.768| 7.287| 12.007| 24758| 0| 1.133|-1819173.554=20

I also observed that during same latency test the first application start g=
enerates the longest time in comparison to other starts.=20

To run, my app needs kernel module contained into attached timer_module.c f=
ile, that signals a semaphore used by app every 1 ms.=20
I don't observe some strange variations in latency test values when inserti=
ng or removing this kernel module.=20

Thank you very much for your help, Gilles.=20
Regards=20
Mauro=20


------=_Part_10_32254135.1295887148343
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
><br>----- Messaggio originale -----<br>Da: "Gilles Chanteperdrix" &lt;gill=
es.chanteperdrix@domain.hid&gt;<br>A: "Michel Rinaldi" &lt;automation.03@domain.hid=
migroup.it&gt;<br>Cc: xenomai@xenomai.org<br>Inviato: Luned=C3=AC, 24 genn=
aio 2011 15:27:51 GMT +01:00 Amsterdam/Berlino/Berna/Roma/Stoccolma/Vienna<=
br>Oggetto: Re: [Xenomai-help] Problems with rt_task_create and rt_task_joi=
n<br><br>.....<br><br>&gt;You explanations are hard to follow and understan=
d, and what is more,<br>&gt;ambiguous. Send us a piece of code which allows=
 us to reproduce this<br>&gt;issue. Trying to make it as simple as possible=
. For instance seeing if<br>&gt;registering the interrupt causes any differ=
ence (if it does not make any<br>&gt;difference, then remove it, you get th=
e idea).<br><br>My code is really big and complex to reduce, I'll try to si=
mplify it in next days.<br><br>&gt;As usual, we do not know what version of=
 Xenomai, Adeos, Linux, etc...<br>&gt;you are using. See:<br>&gt;http://www=
.xenomai.org/index.php/Request_for_information<br><br>I post them into firt=
s mail of this thread, anyway they are:<br>- Linux system with kernel 2.6.3=
5.7<br>
- Xenomai 2.5.5.2<br>- Adeos ipipe patch 2.7-04<br>GCC is on version 4.4.3.=
<br><br>.....<br><br>&gt;That is bad. One more question: what happens when =
you run the "latency"<br>&gt;test, do you get strange results? Also, I see =
that you have the SMI<br>&gt;workaround enabled, does it detect your chipse=
t?<br><br>Yes, as system log says, Xenomai detect SMI motherboard and disab=
le them.<br>I run the latency test: without other loads onto system, I obse=
rve values like these:<br><br>RTT|&nbsp; 00:00:01&nbsp; (periodic user-mode=
 task, 100 us period, priority 99)<br>RTH|----lat min|----lat avg|----lat m=
ax|-overrun|---msw|---lat best|--lat worst<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 6.680|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.157|&nbsp;&nbsp;&nbsp;&nbsp; 1=
2.187|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 6.680|&nbsp;&nbsp;&nbsp;&nbsp; 12.187<br>RTD|&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.277|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.980|&nb=
sp;&nbsp;&nbsp;&nbsp; 10.519|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&=
nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6.277|&nbsp;&nbsp;&nbsp;=
&nbsp; 12.187<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.175|&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 7.122|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9.315|&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 1.175|&nbsp;&nbsp;&nbsp;&nbsp; 12.187<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 1.578|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.112|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 9.382|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0=
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.175|&nbsp;&nbsp;&nbsp;&nbsp; 12.187<br>RT=
D|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.635|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.133=
|&nbsp;&nbsp;&nbsp;&nbsp; 10.307|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nb=
sp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.175|&nbsp;&nbsp;&n=
bsp;&nbsp; 12.187<br><br>also after long runnings.<br><br>But if I launch a=
pplication contained into attached main_app.c file (that represents my simp=
lified application)<br>what I observe into latency test is:<br><br>RTD|&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 1.635|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.133|&nbsp=
;&nbsp;&nbsp;&nbsp; 10.307|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nb=
sp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.175|&nbsp;&nbsp;&nbsp;&n=
bsp; 12.187<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.591|&nbsp;&nbsp;&nbsp;&=
nbsp; 20.101| 129847.817|&nbsp;&nbsp;&nbsp; 1298|&nbsp;&nbsp;&nbsp;&nbsp; 0=
|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.175| 129847.817<br>RTD|&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 1.860|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.133|&nbsp;&nbsp;&nbsp;&=
nbsp; 12.814|&nbsp;&nbsp;&nbsp; 1298|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 1.175| 129847.817<br><br>Then, if I CTRL+C my app:<br><=
br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.091|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
7.468|&nbsp;&nbsp;&nbsp;&nbsp; 15.687|&nbsp;&nbsp;&nbsp; 1298|&nbsp;&nbsp;&=
nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.175| 129847.817<br>RTD|&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 1.861|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8.397|&nbsp;=
&nbsp; 8157.893|&nbsp;&nbsp;&nbsp; 1379|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 1.175| 129847.817<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 6.282|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.287|&nbsp;&nbsp;&nbsp;&nbsp; 15.=
007|&nbsp;&nbsp;&nbsp; 1379|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 1.175| 129847.817<br><br>In concomitance with first very high la=
tency, I observe into dmesg the clocksource switch message.<br><br><br>In o=
ne case I observed an extremely bigger value for lat max: in facts, system =
freezed for about 2 seconds.<br><br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.09=
1|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7.468|&nbsp;&nbsp;&nbsp;&nbsp; 11.687|&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 1.133|&nbsp;&nbsp;&nbsp;&nbsp; 20.817<br>RTD|&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 1.436|&nbsp;&nbsp;&nbsp; 254.870|-1819173.554|&nbsp;&nbs=
p; 24758|&nbsp;&nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.133|-1=
819173.554<br>RTD|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.768|&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 7.287|&nbsp;&nbsp;&nbsp;&nbsp; 12.007|&nbsp;&nbsp; 24758|&nbsp;&=
nbsp;&nbsp;&nbsp; 0|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1.133|-1819173.554<br><b=
r>I also observed that during same latency test the first application start=
 generates the longest time in comparison to other starts.<br><br>To run, m=
y app needs kernel module contained into attached timer_module.c file, that=
 signals a semaphore used by app every 1 ms.<br>I don't observe some strang=
e variations in latency test values when inserting or removing this kernel =
module.<br><br>Thank you very much for your help, Gilles.<br>Regards<br>Mau=
ro<br><br></div></body></html>
------=_Part_10_32254135.1295887148343--

------=_Part_9_431157.1295887148343
Content-Type: application/octet-stream; name=main_app.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=main_app.c

#include <native/task.h>
#include <native/timer.h>
#include <native/sem.h>
#include <native/heap.h>
#include <rtdk.h>

#include <signal.h>
#include <unistd.h>
#include <sys/io.h>
#include <sys/mman.h>
#include <bits/local_lim.h>

#define REQMGR_SHM_NAME             "R_ST_M"
#define REQMGR_STRUCT_SEM_NAME      "R_ST_S"

static unsigned char bBreakReqLoop = 0;
static unsigned char bBreakLoop = 0;

static RT_TASK tMainTask;
static RT_TASK tSchedTask;

static RT_SEM lpTimerSem;
static RT_HEAP main_heap;

typedef struct _tag_ReqStruct
{

   RT_SEM lpStartSem;

   /* .... */

}  ReqStruct;
ReqStruct* lpRequest;

static void SignalHandler ( int signal )
{
   rt_printf("sighandler called\n");
   bBreakReqLoop = 1;
}


void SchedThreadProc ( void *unused )
{
	rt_printf ( "Scheduler thread ready for execution\n" );

      while ( !bBreakLoop )
      {

         rt_sem_p ( &lpTimerSem, TM_INFINITE );

         /* do some work */

      }


   return;
}


int main ( void )
{
	int nRet = 0;

	mlockall ( MCL_CURRENT | MCL_FUTURE );
	
	rt_print_auto_init(1);

	if (rt_task_shadow(&tMainTask,"RTKER",0,0) == 0)
	{
		nRet = rt_sem_bind( &lpTimerSem, "SEMTIM", TM_NONBLOCK);
		if ( nRet == 0 )
		{  

			if (rt_heap_create(&main_heap,REQMGR_SHM_NAME,sizeof(ReqStruct),H_SHARED) == 0)
			{

				nRet = rt_heap_alloc(&main_heap,sizeof(ReqStruct),TM_NONBLOCK,(void **)&lpRequest);
				if ( nRet == 0)
				{

					if (rt_sem_create ( &lpRequest->lpStartSem, REQMGR_STRUCT_SEM_NAME, 0, S_FIFO ) == 0 )
					{

						rt_task_create(&tSchedTask, "SKER_T", 0, 99, T_JOINABLE);

						signal( SIGTERM , SignalHandler );
						signal( SIGINT, SignalHandler );

						rt_task_start(&tSchedTask, SchedThreadProc, NULL);

						rt_printf ( "Request management thread ready for execution\n" );

						while ( !bBreakReqLoop )
						{
							// check semaphore signalling (signalled
							nRet = rt_sem_p_until ( &lpRequest->lpStartSem , 1000000000 );
							if ( nRet == 0 )
							{

								/* work loop */

							}

							rt_task_sleep ( 10000000 );
						} /* end while */

						//Request scheduling thread to exit
						bBreakLoop = 1;

						rt_task_join(&tSchedTask);


						rt_sem_delete ( &lpRequest->lpStartSem );

						rt_heap_delete(&main_heap);

					}
					else
					{
						rt_printf("Semaphore creation error\n");
					}
					rt_heap_free(&main_heap,(void *)&lpRequest);
				}
				else
				{
					rt_printf("Heap alloc error %d\n",nRet);
				}
			}
			else
			{ 
				rt_printf("error creating heap\n");
			}
			rt_sem_unbind(&lpTimerSem);
		}
		else
		{
			rt_printf ("unable to find timer semaphore %d\n",nRet );
		}
	}
	else
	{
		rt_printf("error converting to Xenomai Task\n");
	}

	munlockall ( );
	rt_printf ( "END\n\n" );
	
	return 0;
}
------=_Part_9_431157.1295887148343
Content-Type: application/octet-stream; name=timer_module.c
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=timer_module.c

#include <linux/kernel.h>
#include <linux/module.h>

#include <native/sem.h>
#include <rtdm/rtdm_driver.h>


#define SEM_NAME  "SEMTIM"

#define TIMER_PERIOD_NSEC	1000000

#define PERIODIC_TASK_PRIO	RTDM_TASK_HIGHEST_PRIORITY
#define PERIODIC_TASK_NAME	"T_PER"
#define PERIODIC_STACK_SIZE	8192

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("Timer module");

static rtdm_task_t tPeriodicTask;

RT_SEM sSchedSem;

static void SwTimerHandler(void* dummy)
{
	
	printk(KERN_INFO "Starting %s\n", __FUNCTION__);
	
	while (1)
	{
	    if( rtdm_task_wait_period() == -ETIMEDOUT ) printk(KERN_WARNING "schedule overrun detected!\n");
		rt_sem_v(&sSchedSem);
	}
}


int init_module (void)
{
	int ErrCode;

	ErrCode = rt_sem_create(&sSchedSem, SEM_NAME, 0, S_FIFO);
	if ( ErrCode != 0)
	{
		printk(KERN_ERR "Error creating main semaphore %d!\n",ErrCode);
	}

	if (rtdm_task_init(&tPeriodicTask, PERIODIC_TASK_NAME, &SwTimerHandler, NULL, PERIODIC_TASK_PRIO, TIMER_PERIOD_NSEC) == 0)
	{
		printk(KERN_INFO "Periodic Thread created!");
	}

	return 0;
}

void cleanup_module (void)
{
	rtdm_task_destroy(&tPeriodicTask);

	rt_sem_delete(&sSchedSem);
	
	printk (KERN_INFO "Timer removed\n" );
}


------=_Part_9_431157.1295887148343--

