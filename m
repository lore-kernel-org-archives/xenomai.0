Content-Type: text/plain; charset="us-ascii"
Date: Thu, 22 Mar 2007 22:57:07 +0100
From: "Viktor Stark" <abraar@domain.hid>
Message-ID: <20070322215707.232970@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] [RT_PIPE] - User space read() not waking up
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

I'm having a little issue with RT pipes and I was wondering if anyone could give me some pointers.

I wrote a RT kernel module for a DAQ card. The DAQ card gets interrupts every 200 us (5 kHz) and I've got a RT interrupt handler which wakes up a RT function (by sending an event to it). Inside that function I use rt_pripe_write to send some data (about 300 bytes) down to user space.

On the user space side, I've got a real small executable which basically opens the pipe via the Xenomai registry and then reads data from it in a tight loop. Inside that loop I read the TSC after each write and I compute a minimum / maximum for a 10 seconds cycle. The problem is that I get a maximum of about 395 us (which is 2 times 200 us approximately). On the kernel side I also do timings and I am 100% sure that my function using rt_pipe_write() is woken up every 200 us (+- 10 us jitter), that is no interrupts are missed.

After further reasearch I realised that I get a maximum value every 10000 cycles, that is every two seconds. I don't have anything in my system (to my knowledge) that has such a period so I'm really confused about what could be causing this.

I tried to have a look at pipe.c in src/nucleus and saw that the user space side is supposed to get woken up on each xnpipe_send() but I admit that I didn't quite catch all the details.

So basically, my question is:
If I have rt_pipe_write() writing to a pipe from a kernel module with a 200 us period and I have a read() in a tight loop reading from that same pipe is user space, what could be the origin of the fact that sometimes my read() doesn't get woken up?

It's worth to mention too, that I'm not losing any data. That is, after the read which eats up 2 cycles, the next read finishes nearly instantaneously (within 5 us) as if only the second rt_pipe_write() woke up the user space read().
Timing illustration (time between read()'s in us): 195 | 200 | 205 | 395 | 5 | 195 | 200 | 200

My setup:
Xenomai 2.2-rc3
Kernel 2.6.17 (with Xenomai compiled in - ie. not compiled as modules)
P4 3GHz - 1Gb RAM
No APM/ACPI/CpuFreq - SMI workaround enabled.
Tried with 2.6.19 / Xenomai 2.3 - same results.

Thanks in advance for any pointers.

Keep up the good work! Xenomai just *rocks*.

Viktor STARK 
-- 
"Feel free" - 5 GB Mailbox, 50 FreeSMS/Monat ...
Jetzt GMX ProMail testen: www.gmx.net/de/go/mailfooter/promail-out

