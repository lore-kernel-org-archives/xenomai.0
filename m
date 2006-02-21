Date: Tue, 21 Feb 2006 10:15:37 -0800
Subject: Re: [Xenomai-help] no-brainer issue found, but not solved
From: Steven Seeger <steve@domain.hid>
Message-ID: <C02098C9.24B1%steve@domain.hid>
In-Reply-To: <43FB546E.5090802@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
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

Here are the routines in question:

low priority:

for(;;) {
    /* regular rf watchdogs */
    outb(0x45, 0x????);
    outb(0x6a, 0x????);
    outb(0x7e, 0x????);
               
    outb(0, 0x????); //patient watchdog
    outb(0, 0x????); //fault led

    flip_reg_bits(WRFPC, 0x????); //flash yellow led
                
    ????_flip_spi_bits(HV_STATUS_CONTROL, HV_WDOG_STROBE_MONITOR);
                
    rt_task_wait_period();
}

high priority:

    for(;;) {
        if(motor_move) {
            syslog(LOG_INFO, "about to lock up");
            for(int i=0; i<100000000; i++);
            motor_move=0;
        }

        rt_task_wait_period();
    }

All function calls contain only inb or outb, no system calls. If I comment
out the syslog call in the high priority thread, the yellow LED stops
flashing completely. Otherwise, it flashes every second, with the
periodicity of the higher priority thread.

I have another problem, too:

Using the same yellow LED flashing thread, if I start up a LOWER priority
task like this, I can see jitter on my LED strobe line on the scope once a
second. Why would the lower priority thread making a system call affect the
higher priority one?

for(;;) {
    syslog(LOG_INFO, "sleeping 1");
    sleep(1);
}

Steven


