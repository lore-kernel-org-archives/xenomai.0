From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4DC96142.7020008@domain.hid>
References: <4DC96142.7020008@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 May 2011 18:41:47 +0200
Message-ID: <1305045707.2151.52.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] SWITCH TASK TO SECONDARY MODE DURING GDB SESSION
 DOESN'T WORK
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2011-05-10 at 18:01 +0200, Roberto Bielli wrote:
> Hi,
> 
> i try the next C code in a gdb session on a ARM target with brakpoints 
> and i found a strange behaviour.
> I expected that the task 'tsk1' never execute instead if i put a 
> breakpoint on the instruction 'varInt += 1;' i see that it's executed.
> I sospect that there is this behavior:
> 
> 1. i start gdb with application. The application is not running.
> 2. i enable the breakpoint on the instruction 'err = 
> rt_task_start(&tsk1, &test_tsk1, NULL );'
> 3. i enable the breakpoint on the instruction 'varInt += 1;' in tsk1
> 4. run the application that stop on the instruction 'err = 
> rt_task_start(&tsk1, &test_tsk1, NULL );'
> so the task is in secondary mode for the breakpoint hit if i understand 
> correctly .
> 5. i make a single step and do the rt_task_start in main, so i see that 
> i break in the task on the instruction 'varInt += 1;' in tsk1
> this is strange because main has shadow and has a priority equal o 99, 
> instead  tsk1 has a priority equal to 49.
> 6, the program execute the instruction  'varInt += 1;' and then return 
> to main.
> 7 then the main has always the control.
> 
> The question is:
> Why the priority is not respected ? I think this. Maybe the main is in 
> secondary mode for the breakpoint and when make a rt_task_create the new 
> task is in primary
> mode for the initial instruction. Then receive the signal ( verified 
> with rt_task_set_mode(0, T_WARNSW, NULL); ) and switch to secondary mode 
> but initially the task tsk is in primary mode and execute before main.
> 
> Is a known problem ?
> 

This is a known restriction imposed on us by the dual kernel design.

- gdb means ptrace(), ptrace() means lost of linux signals
- receiving a linux signal in primary mode causes a switch to secondary,
so that we can handle it safely from a sane linux context
- receiving a linux signal in secondary mode prevents the root priority
to be boosted (no PIP), so that lengthy kernel code handling lethal
signals is not stealing the CPU away from lively real-time tasks.

In short, gdb will surely break the expected priority order because it
depends on ptrace(), and ptrace() is making heavy use of linux signals.
Only explicit synchronization between threads (sems, mutexes, whatever)
can still guarantee proper serialization in this context.


> Best Regards
> 
> 
> 
> CODE---------------------------------
> 
> 
> int varInt = 0;
> RT_TASK tsk1, tskMain;
> 
> int main (int argc, char *argv[])
> {
>      int err;
>      mlockall(MCL_CURRENT|MCL_FUTURE);
> 
>      rt_task_shadow(&tskMain, "main", 99, 0);
> 
>      err  = rt_task_create( &tsk1, "tsk1", 0, 49, T_FPU );
>      err = rt_task_start(&tsk1, &test_tsk1, NULL );
> 
>      for (;;)
>      {
>          if( varInt > 1 )
>              break;
>      }
> 
> 
>      printf("Task started\n");
> 
>      return 0;
> }
> 
> void test_tsk1( void * args )
> {
> 
>      for( ;;)
>      {
>          varInt += 1;
>          rt_task_sleep( 100000000 );
>      }
> }
> 

-- 
Philippe.



