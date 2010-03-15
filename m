From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <alpine.DEB.1.10.1003151439040.27204@domain.hid>
References: <alpine.DEB.1.10.1003151439040.27204@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Mar 2010 15:30:24 +0100
Message-ID: <1268663424.27899.226.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem throwing a C++ Exception on Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

On Mon, 2010-03-15 at 15:00 +0100, Kolja Waschk wrote:
> Hi,
> 
> first I have to admit that my report is actually about a problem with a quite old Xenomai (Nucleus 2.4.7, I-pipe 1.10) in "stock" Blackfin uClinux kernel 2.6.28 as it comes in Blackfin uClinux-dist 2009R1-RC6.
> 
> Testing a newer code base would probably require some days of work to update a custom driver and bring up other problems, so I'm trying to find out whether it is worth the effort at this time. Maybe someone can (roughly) identify the problem's cause (from memory?) and help me to decide whether there is a simple solution, or an upgrade is necessary:
> 

No obvious answer to this. 2.6.28/bfin has problems, the whole exception
management on blackfin is a problem per se. 2.6.28/bfin + I-pipe has
even more problems. You may want to try 2.6.31.6, while keeping the rest
of your uClinux-dist base. Nasty issues were fixed in the 2.6.30
timeframe.

> A simple C++ program that creates a task, which does nothing but throws an exception, crashes my BF537. Currently, it results in
> 
> > Data access CPLB miss
> >  - Used by the MMU to signal a CPLB miss on a data access.
> ...
> >  RETS: <0x004b02be> [ /tmp/test + 0x302be ]
> >  PC  : <0x004aff88> [ /tmp/test + 0x2ff88 ]
> > DCPLB_FAULT_ADDR: <0xf1380095> /* kernel dynamic memory */
> > ICPLB_FAULT_ADDR: <0x004aff88> [ /tmp/test + 0x2ff88 ]
> 

Try enabling CONFIG_DEBUG_BFIN_HWTRACE_ON.

> /tmp/test + 0x2ff88 resolves to /usr/src/packages/BUILD/blackfin-toolchain-09r1/../gcc-4.1/gcc/unwind-dw2-fde.c:273
> 

Any disassembly of that spot?

> I stripped it down to the small remainder which still triggers the problem (error handling for example was there but I left it out for this post). It doesn't always happen on the first start, but certainly on the second.
> 
> The last line showing up if I step through the program is the 'throw "foo"' here in test.cc.
> 
> #include <native/task.h>
> void task_main(void* arg) {
>      try {
>          throw "foo";
>      }
>      catch (...) { }
> }
> 
> int main() {
>      RT_TASK task;
>      rt_task_create(&task, "task", 128*1024, 99, T_FPU|T_JOINABLE);
>      rt_task_start(&task, task_main, NULL);
> }
> 
> Any first ideas? I'm going to install more recent versions of kernel and Adeos/I-PIPE/Xenomai, but ideally I would like to keep as much as in the 2009R1 (or 2009R1.1) release version of Blacking uClinux-dist..
> 
> Many thanks for taking a look at my problem in advance!
> Kolja
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



