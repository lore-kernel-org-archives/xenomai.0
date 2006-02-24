Message-ID: <43FECB82.6040802@domain.hid>
Date: Fri, 24 Feb 2006 10:01:54 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] no-brainer issue found, but not solved
References: <C02098C9.24B1%steve@domain.hid> <43FB5DB1.2000703@domain.hid>
In-Reply-To: <43FB5DB1.2000703@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Steven Seeger wrote:
> 
>>Here are the routines in question:
>>
>>low priority:
>>
>>for(;;) {
>>    /* regular rf watchdogs */
>>    outb(0x45, 0x????);
>>    outb(0x6a, 0x????);
>>    outb(0x7e, 0x????);
>>               
>>    outb(0, 0x????); //patient watchdog
>>    outb(0, 0x????); //fault led
>>
>>    flip_reg_bits(WRFPC, 0x????); //flash yellow led
>>                
>>    ????_flip_spi_bits(HV_STATUS_CONTROL, HV_WDOG_STROBE_MONITOR);
>>                
>>    rt_task_wait_period();
>>}
>>
>>high priority:
>>
>>    for(;;) {
>>        if(motor_move) {
>>            syslog(LOG_INFO, "about to lock up");
>>            for(int i=0; i<100000000; i++);
> 
> 
> This loop is always executed in secondary mode. This means it /may/ run
> at the original high prio of that thread if syslog() did not trigger a
> Linux reschedule, and it will run at prio 0 if syslog did so.

To be precise, the Linux kernel as a whole will inherit the RT priority of the 
syslog caller until the latter suspends Linux-wise, which is quite possible due to 
the way syslog works.

  This
> depends on the arrival of Linux IRQs or the need of syslog to block on
> some other Linux process.
> 
> Again, if you want RT for sure after a Linux call, use explicit mode
> switching.
> 
> 
>>            motor_move=0;
>>        }
>>
>>        rt_task_wait_period();
>>    }
>>
>>All function calls contain only inb or outb, no system calls. If I comment
>>out the syslog call in the high priority thread, the yellow LED stops
>>flashing completely. Otherwise, it flashes every second, with the
>>periodicity of the higher priority thread.
>>
>>I have another problem, too:
>>
>>Using the same yellow LED flashing thread, if I start up a LOWER priority
>>task like this, I can see jitter on my LED strobe line on the scope once a
> 
> 
> Also as rt-thread?
> 
> 
>>second. Why would the lower priority thread making a system call affect the
>>higher priority one?
>>
>>for(;;) {
>>    syslog(LOG_INFO, "sleeping 1");
>>    sleep(1);
>>}
> 
> 
> Something seems to be broken, but it is hard to analyse remotely if in
> the test setup or the system.
> 
> Please replace your LED thread in this scenario with the latency test
> tool, running at the same frequency. Collect the worst-case data. If
> they show quirks as well, consider applying the tracer patch and catch
> the abnormal jitters via "latency -f". You can tune the number if
> backtrace_points in /proc/ipipe/tracer until you get a significant time
> interval into the trace.
> 
> Jan
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 

Philippe.

