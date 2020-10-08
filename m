Date: Thu, 8 Oct 2020 10:41:57 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: Cycle duration peaks due to non-real-time processes
Message-ID: <20201008024156.GA18707@linux.intel.com>
References: <774839f147524c299dd2d207b9e3942f@itk-engineering.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <774839f147524c299dd2d207b9e3942f@itk-engineering.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steffen Diehl <Steffen.Diehl@itk-engineering.de>
Cc: xenomai@xenomai.org

On Wed, Oct 07, 2020 at 01:24:35PM +0000, Steffen Diehl via Xenomai wrote:
> Dear all,
> 
> for a medical device we have a real time application which runs at cpu cores 1,2,3 (they are isolated and used only by the application as shown in Dynamic Boot Parameters).
> A cyclic and high prioritized xenomai thread of the application runs at cpu core 1. The cycle duration of the thread is monitored by the SW itself and can be saved to disk for later analysis.
> 
> If there is no extra load, the cycle duration is about 0.55...0.6 ms, but if a ssh login, a scp from/to the system is executed or a file copy on disk (e.g. via dd) happens, the cycle duration increases sharply, as shown in the figure bellow.
> A high cpu load like "sha1sum /dev/zero" produces no peak of the cycle duration.
> 
> [cid:image002.jpg@01D69CBD.F5939450]
> 
> Do you know the reasons for these strong increases in cycle duration? Is there a way to limit the influence of these non-real-time processes on our real-time application?
> 
> System configuration:
> 
>   *   Main Processor architekture:
>      *   Linux 4.14.89-xenomai-3.0.8-cobalt #1 SMP PREEMPT x86_64 x86_64 x86_64 GNU/Linux
>   *   Kernel:
>      *   4.14.89-xenomai-3.0.8-cobalt
>   *   Config knobs:
>      *   Build args: --prefix=/usr/xenomai-3.0.8-cobalt --with-core=cobalt --enable-pshared --enable-smp
>   *   I-pipe core release number:
>      *   2
>   *   OS:
>      *   Ubuntu 18.04 LTS bionic
>   *   CPU:
>      *   CPU Intel(R) Core(TM) i7-6820EQ CPU @ 2.80GHz (4 physical cores, hyper threading deactivated)
>   *   Dynamic Boot Parameters:
>      *   BOOT_IMAGE=/boot/vmlinuz-4.14.89-xenomai-3.0.8-cobalt root=UUID=e50978cf-72c7-11e8-ba28-000babbcd619 ro xenomai.allowed_group=1005 isolcpus=1,2,3 xenomai.sysheap_size=1024
> 
> Best regards and thank you very much for your help,
> 
> Steffen Diehl
> 

hi Steffen,

we don't observe higher avg/max latency on our test machine when doing
ssh, scp or dd,

u may try our config:

BIOS: disable hyperthreading; disable C-State; let [SA GV] to
high/disable if u can find [SA GV] in the BIOS, it's the dynamic freq of
fabric; 

kernel cmdline: (maybe irqaffinity affect this case)

nosmt processor.max_cstate=0 intel.max_cstate=0 processor_idle.max_cstate=0 intel_idle.max_cstate=0 intel_pstate=disable i915.enable_dc=0 i915.disable_power_well=0 clocksource=tsc tsc=reliable rcu_nocb_poll rcu_nocbs=1-3 nohz_full=1-3 idle=poll nohalt nmi_watchdog=0 nosoftlockup nosmap audit=0 noefi xenomai.allowed_group=1234 xenomai.sysheap_size=256 xenomai.state=enabled xenomai.smi=detect xenomai.smi_mask=1 irqaffinity=0 isolcpus=1-3 console=tty1 console=ttyS0,115200

BR fino

> --
> Steffen Diehl, M.Sc.
> Medical Systems Engineering
> 
> ITK Engineering GmbH
> Im Speyerer Tal 6
> 76761 Rülzheim
> 
> Tel.: +49 7272 7703-764
> Fax: +49 7272 7703-100
> 
> mailto:steffen.diehl@itk-engineering.de
> _____________________________________________________________
> ITK Engineering GmbH  Im Speyerer Tal 6  76761 Rülzheim
> Tel.: +49 7272 7703-0   Fax: +49 7272 7703-100
> mailto:info@itk-engineering.de   http://www.itk-engineering.de<http://www.itk-engineering.de/>
> 
> Vorsitzender des Aufsichtsrats/Chairman of the Supervisory Board:
> Dr. Rudolf Maier
> Geschäftsführung/Executive Board:
> Michael Englert (Vorsitzender/Chairman), Bernd Gohlicke
> Sitz der Gesellschaft/Registered Office: 76761 Rülzheim
> Registergericht/Registered Court: Amtsgericht Landau, HRB 32046
> USt.-ID-Nr./VAT-ID-No. DE 813165046
> 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: image002.jpg
> Type: image/jpeg
> Size: 46487 bytes
> Desc: image002.jpg
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20201007/7ee92a21/attachment.jpg>

