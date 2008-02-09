MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18349.43717.622653.136257@domain.hid>
Date: Sat, 9 Feb 2008 14:29:41 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376AB6@domain.hid>
References: <51CAD0CE1504444DBE77CBBE51A0135D376AB6@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
 > I found the source of my fpu issue. A single kernel module with two
 > tasks was also active. I noticed the failure occurred whenever sound
 > would play. (This is one of the tasks.) It seems the problem is that the
 > sound task doesn't use the FPU, so I didn't turn on T_FPU. The tone task
 > (not in use at that time) does, so it has T_FPU. When I turned on T_FPU
 > for the sound task, I never saw the problem again. With it off, if I
 > played sound while running the program, I'd regularly see the
 > corruption.
 > 
 >  
 > 
 > Here is the task code:
 > 
 >  
 > 
 > static void sound_func(void *data)
 > 
 > {       
 > 
 >     for (;;) //go until suspended or thread deletion
 > 
 >     { 
 > 
 >         if (play==stop) //time to stop if this happens
 > 
 >         {
 > 
 >             unsigned long evt = 0;
 > 
 >             
 > 
 >             play=stop=0; // just in case
 > 
 >             rt_event_clear(&sound_event, SOUND, 0);
 > 
 >             rt_task_set_periodic(&sound_task, TM_NOW, TM_INFINITE); /*
 > disable periodic mode */
 > 
 >             rt_event_wait(&sound_event, SOUND, &evt, EV_ALL,
 > TM_INFINITE);
 > 
 >             rt_task_set_periodic(&sound_task, TM_NOW,
 > rt_timer_ns2ticks(ST_AUDIO_PERIOD));
 > 
 >         }
 > 
 >         
 > 
 > #if BUFSIZE != 65536
 > 
 >         if (play==BUFSIZE) play=0;
 > 
 > #endif
 > 
 >         
 > 
 >         if(rt_task_wait_period(0)) rt_task_wait_period(0); //wait for
 > next tick and ignore overruns (do the best we can)
 > 
 >         // Since the index is incrementd subtract 2 from the size before
 > comparing the index
 > 
 >         
 > 
 >         outb(buf[play++], DAC_ADDRESS); //send the next byte to the dac
 > 
 >     }
 > 
 > }
 > 
 >  
 > 
 > The buffer is filled with a linux userland process and an appropriate
 > wait queue. This same code worked fine in RTAI without the FPU flag.
 > 
 >  
 > 
 > I've tested this for several minutes.
 > 
 >  
 > 
 > Any idea?

An idea is to disassemble the kernel task code and the function it calls
to see if FPU is really never used.

If this task really never calls any function using FPU, it would be nice
if you could (as we always ask, you may have noticed) reduce your test
case to a simple code where only FPU operations and every thing which
causes task switches (blocking calls, and calls waking up other tasks)
is kept.

-- 


					    Gilles Chanteperdrix.

