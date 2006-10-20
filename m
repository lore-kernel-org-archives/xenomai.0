Date: Fri, 20 Oct 2006 16:00:41 -0600
From: Sunny Bhuller <sbhuller@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_read switch to secondary mode
Message-id: <20db7b520dafb8.20dafb820db7b5@domain.hid>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7bit
Content-disposition: inline
Reply-To: sbhuller@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi Philippe,
  I am including some code below that will produce the problem I am seeing.  I must be missing something because if remove the force to primary mode in the function task_procedure the signal will not be caught.  This tells me that without the rt_task_set_mode the task is starting off in secondary mode.  

//------ Start

#include <signal.h>
#include <sys/mman.h>
#include <inttypes.h>
#include <native/task.h>
#include <native/queue.h>


typedef struct {
	uint8_t data[1024]; 
} __attribute__((packed)) some_data;


void task_procedure(void *arg)
{
	RT_QUEUE *msq_q = (RT_QUEUE *)arg;
	rt_task_set_mode(0, T_PRIMARY | T_WARNSW, NULL);

	some_data data;

	rt_queue_read( msq_q, &data, sizeof ( some_data ), TM_NONBLOCK);	
	
}

void signal_handler(int sig)
{
	if (sig == SIGXCPU)
		printf("---!! uh oh, switched to secondary mode !!--\n");
}


int main(int argc, char *argv[])
{
	RT_QUEUE msg_q;
	RT_TASK msg_task;

    	mlockall(MCL_CURRENT | MCL_FUTURE);

	rt_task_set_mode(0, T_PRIMARY | T_WARNSW, NULL);

	signal(SIGXCPU, signal_handler);

	rt_queue_create( &msg_q, "phil_test", sizeof(some_data), Q_UNLIMITED, Q_FIFO | Q_SHARED );

        rt_task_create(&msg_task, NULL, 0, 5, T_FPU | T_JOINABLE);
	rt_task_start(&msg_task, &task_procedure, &msg_q );

	rt_task_join( &msg_task );
	rt_task_delete( &msg_task );
	rt_queue_delete( &msg_q );

	return 0;
}


//-------- END


----- Original Message -----
From: Philippe Gerum <rpm@xenomai.org>
Date: Friday, October 20, 2006 2:59 pm
Subject: Re: [Xenomai-help] rt_queue_read switch to secondary mode

> On Fri, 2006-10-20 at 14:50 -0600, Sunny Bhuller wrote:
> > Hello,
> >   I am new to xenomai and was having a problem with the 
> rt_queue_read call.  I am creating a new RT_TASK from my main 
> program with:
> > 
> > rt_task_create(&task, NULL, 0 /* default stack size */, 5 /* 
> priority */, T_FPU | T_JOINABLE);
> > 
> > Once the task has started I switch it to primary mode with:
> > 
> > rt_task_set_mode(0, T_PRIMARY | T_WARNSW, NULL);
> 
> Forcing to primary is useless, every real-time task starts in primary
> mode, regardless of the relevant skin.
> 
> > 
> > Now if I call the rt_queue_read I catch the signal that 
> specifies the system has switched to secondary mode.  Is there 
> something fundamentally wrong with what I am doing?  I can post a 
> more detailed explanation if required, thanks!
> > 
> 
> There is no reason for rt_queue_read() to move the thread to secondary
> mode. You should try running the app over GDB, and inspect the 
> backtracewhen the signal is received; you might discover that some 
> other code
> does cause this, or you might discover that we indeed have a bug 
> hidingsomewhere. Posting a simple but complete test code that 
> reproduces the
> issue unambiguously would help too.
> 
> > -- Sunny
> > 
> > 
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> -- 
> Philippe.
> 
> 
> 


