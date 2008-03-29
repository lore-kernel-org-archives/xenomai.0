Message-ID: <47ED9D05.7060707@domain.hid>
Date: Fri, 28 Mar 2008 21:36:05 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47ED5DE3.60202@domain.hid>	<18413.32341.751841.753799@domain.hid>
	<18413.34914.638951.575098@domain.hid>
In-Reply-To: <18413.34914.638951.575098@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Gilles,

thanks for looking at it. Your analysis is correct, I don't indeed have 
CONFIG_PREEMPT_RT kernel, but only CONFIG_PREEMPT, sorry for the confusion.

I've put the kernel config, sources, and binary on the web, so that you 
can be sure you're really looking on the kernel that is crashing, 
http://www.cs.purdue.edu/homes/tkaliber/crash

Thanks,

Tomas

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>  > Tomas Kalibera wrote:
>  >  > 
>  >  > Hi,
>  >  > 
>  >  > I'm getting kernel crashes with my native skin user-space Xenomai 
>  >  > application. It looks like the crash happens after clone/fork. I'm using 
>  >  > kernel 2.6.24.3, SMP, RT_PREEMPT (settings like  2.6.22-14-rt from 
>  >  > Ubuntu 7.10). Xenomai 2.4.2.
>  >  > 
>  >  > The thread causing the crash is a Xenomai task, running most of the time 
>  >  > in the Linux domain. The application is very huge, getting a short 
>  >  > example leading to the bug is unfortunatelly not realistic.
>  >  > 
>  >  > The crash happens when running on real hardware (x86_64 with 32 bit 
>  >  > kernel and applications).  The system is unusable after it happens, can 
>  >  > only be rebooted, the dump is from serial console.
>  >  > In VMWare on another x86_64 machine, it does not crash.
>  >  > 
>  >  > Anyone getting a similar error ? Any ideas where to look for the problem ?
>  > 
>  > Looking at the kernel code, it seems that only one page may be mapped at
>  > a time with kmap_atomic using KM_USER0. So what probably happens is that
>  > for other invocations of cow_user_page than the one taking place in
>  > fork, a lock of some kind prevents concurrent invocation of
>  > cow_user_page. In our use of cow_user_page, we probably do not hold that
>  > lock. I look at the code, I see that copy_pte_range holds a spinlock,
>  > which should disable preemption on a classical kernel. But who knows
>  > what happens with RT_PREEMPT enabled...
>
> There is something strange... Normally, when compiling with
> CONFIG_PREEMPT_RT, kmap_atomic_prot is replaced with kmap and the real
> kmap_atomic_prot is renamd __kmap_atomic_prot. Since cow_user_page uses
> kmap_atomic_prot, kmap is in fact called and kmap_atomic_prot BUG_ON
> condition should in fact never occur.
>
>   


