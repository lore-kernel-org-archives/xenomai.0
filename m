Message-ID: <4E5B676F.60102@domain.hid>
Date: Mon, 29 Aug 2011 12:18:23 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OF2D9ACDF1.2A655563-ON882578F8.0070CB81-882578F8.007235BA@moog.com>
In-Reply-To: <OF2D9ACDF1.2A655563-ON882578F8.0070CB81-882578F8.007235BA@moog.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] milli-second overruns under heavy load on x86,
 running Xenomai 2.5.6
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: George Broz <GBroz@domain.hid>
Cc: xenomai@xenomai.org

On 2011-08-26 22:42, George Broz wrote:
> Hello,
> 
> I'm experiencing very large overruns in the neighborhood of 10 to 50 
> *milli-seconds* as reported by the Xenomai latency tool in user-task mode 
> whenever the Linux OS is heavily loaded. Under lighter loads these are in 
> the 30 to 70 micro-second (normal) range. 
> 
> My system is:
> - Linux 2.6.37.6 (32-bit), Ubuntu 10.10 distribution
> - Xenomai 2.5.6 using I-pipe patch adeos-ipipe-2.6.37.6-x86-2.9-02
> - Intel x86 Atom (dual-core) CPU D510 @ 1.66GHz 
> - Emb. dev board from Intel (ICH8M ctrlr, Ethernet h/w for e1000e)
> - Xenomai configured w&w/o --enable-smp --enable-x86-tsc options
> - gcc version 4.4.5
> 
> I've followed all of the recommendations for kernel configuration and have 
> disabled CPU sleep features in the BIOS such as SpeedStep and C-States. 
> Legacy USB has been disabled in the BIOS. Hyperthreading has also been 
> disabled, although I don't think it matters.
> 
> The heavy load was to compile a new Linux kernel while the latency test 
> ran.
> 
> I've captured several traces with the I-pipe tracer - here are some of the 
> milli-second overrun excerpts:
> 
> snippet:
>     Type   User Val. Time        Delay Function (Parent)
> :| +begin 0x80000001 -14384      0.551 __ipipe_handle_exception+0x3d3 
> (error_code+0x5f)
> :| +end   0x80000001 -14383! 14344.649 __ipipe_handle_exception+0x2d9 
> (error_code+0x5f)
> :| +begin 0xffffff02 -39         0.995 reschedule_interrupt+0x30 
> (<40116e89>)
> 
> snippet:
> :  +func             -17242      0.545 _raw_spin_lock+0x3 (ipc_lock+0x2e)
> :  +func             -17241! 17188.986 ipcperms+0x10 
> (sys_semtimedop+0x2f8)
> :| +begin 0xffffff09 -52         0.797 ipipe_ipi3+0x30 
> (sys_semtimedop+0x396)
> :| +func             -51         0.701 __ipipe_handle_irq+0xa 
> (ipipe_ipi3+0x37)
> 
> snippet:
> : #func              -39426      0.605 scheduler_tick+0xa 
> (update_process_times+0x5d)
> : #func              -39425      0.797 ktime_get+0xa 
> (sched_clock_tick+0x5a)
> : #func              -39424! 39377.690 acpi_pm_read+0x3 (ktime_get+0x6a)
> :| #begin 0xffffff09 -47         0.923 ipipe_ipi3+0x30 (acpi_pm_read+0xf)
> :| #func             -46         0.707 __ipipe_handle_irq+0xa 
> (ipipe_ipi3+0x37)

Specifically this last snippet suggests that your hardware has some
serious latency problems. There is nothing in that code path that allows
a software explanation of those 39 ms.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

