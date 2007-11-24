Message-ID: <fd6a47a90711240524o2565a833g943d9382a5b7be76@domain.hid>
Date: Sat, 24 Nov 2007 14:24:13 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_16295_25402661.1195910653463"
Subject: [Xenomai-help] Waiting for a terminating RTDM thread in module_exit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_16295_25402661.1195910653463
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I want to create an RTDM driver that uses a thread (rtdm_task_t) to perform
a cyclic job. Although it's possible to start this thread (using
rtdm_task_init) from the module_init code, I'm unsure of how I should
terminate this thread.

I seem to have several options:

1. Just kill the thread with rtdm_task_destroy. This means that the thread
should never block, except on rtdm_task_wait_period, or else it might be
terminated on the blocking instruction and leave the hardware in an unknown
state.

2. Use a stop variable, along with a semaphore to ensure that the thread has
stopped. E.g.:

volatile int stop_requested = 0;
rtdm_sem_t sem;

void the_thread(void *cookie)
{
   while (!stop_requested) {
      /* Blocking may occur, due to calls to e.g. rtdm_read */
      rtdm_task_wait_period();
   }
   do_some_cleaning_up();
   rtdm_sem_up(&sem); /* Release the pending module_exit */
}

void __exit module_exit()
{
   stop_requested = 1;
   rtdm sem_down(&sem);
   rtdm_sem_destroy(&sem);
   rtdm_task_destroy(&task);
   rtdm_unregister();
}

However, this means I would issue a blocking call in Linux kernel context.
To me, it seems that the whole Linux thread would be suspended, but I just
tried this and it fails (segfault on sem_down and unusable system). Another
question is if I still need to clean up (destroy) a task that has run to
completion ?

3. Unload the module, set a variable as the one above (stop_requested) and
leave the unregistering to the exiting thread. This seems ugly to me, and I
also think that it would crash, as the Linux kernel will remove the program
(including the thread code) from memory.


So, in short, how do I wait in the module_exit ?


Jeroen.

------=_Part_16295_25402661.1195910653463
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I want to create an RTDM driver that uses a thread (rtdm_task_t) to perform a cyclic job. Although it&#39;s possible to start this thread (using rtdm_task_init) from the module_init code, I&#39;m unsure of how I should terminate this thread.
</div>
<div>&nbsp;</div>
<div>I seem to have&nbsp;several options:</div>
<div>&nbsp;</div>
<div>1. Just kill the thread with rtdm_task_destroy. This means that the thread should never block, except on rtdm_task_wait_period, or else it might be terminated on the blocking instruction and leave the hardware in an unknown state.
</div>
<div>&nbsp;</div>
<div>2. Use a stop variable, along with a semaphore to ensure that the thread has stopped. E.g.:</div>
<div>&nbsp;</div>
<div>volatile int stop_requested = 0;</div>
<div>rtdm_sem_t sem;</div>
<div>&nbsp;</div>
<div>void the_thread(void *cookie)</div>
<div>{</div>
<div>&nbsp;&nbsp; while (!stop_requested) {</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Blocking may occur, due to calls to e.g. rtdm_read&nbsp;*/</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_task_wait_period();</div>
<div>&nbsp;&nbsp; }</div>
<div>&nbsp;&nbsp; do_some_cleaning_up();</div>
<div>&nbsp;&nbsp; rtdm_sem_up(&amp;sem); /* Release the pending module_exit */</div>
<div>}</div>
<div>&nbsp;</div>
<div>void __exit module_exit()</div>
<div>{</div>
<div>&nbsp;&nbsp; stop_requested = 1;</div>
<div>&nbsp;&nbsp; rtdm sem_down(&amp;sem);</div>
<div>&nbsp;&nbsp; rtdm_sem_destroy(&amp;sem);</div>
<div>&nbsp;&nbsp; rtdm_task_destroy(&amp;task);</div>
<div>&nbsp;&nbsp; rtdm_unregister();</div>
<div>}</div>
<div>&nbsp;</div>
<div>However, this means I would issue a blocking call in Linux kernel context. To me, it seems that the whole Linux thread would be suspended, but&nbsp;I just tried this and it fails (segfault on sem_down and unusable system). Another question is if I still need to clean up (destroy) a task that has run to completion ?
</div>
<div>&nbsp;</div>
<div>3. Unload the module, set a variable as the one above (stop_requested) and leave the unregistering to the exiting thread. This seems ugly to me, and I also&nbsp;think that it would crash, as the Linux kernel will remove the program (including the thread code) from memory.
</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>So, in short, how do I wait in the module_exit ?</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>

------=_Part_16295_25402661.1195910653463--

