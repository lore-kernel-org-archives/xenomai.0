Message-ID: <2ff1a98a0805060213r771b1dfbya40a4836d77f9d97@domain.hid>
Date: Tue, 6 May 2008 11:13:10 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <48201296.50905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <48201296.50905@domain.hid>
Subject: Re: [Xenomai-core] Timing Issues on x86_32 SMP
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Benjamin ZORES <benjamin.zores@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, May 6, 2008 at 10:11 AM, Benjamin ZORES
<benjamin.zores@domain.hid> wrote:
> Hi,
>
>  I'm currently running an x86_32 SMP system and facing some issues with
>  periodic tasks.
>  I'd like to get a bit more information on a few assumptions I've made.
>
>  Quick sum-up of my setup:
>  - adeos-ipipe-2.6.23-i386-1.12-03
>  - xenomai-2.4.3.patch
>  - Core 2 Duo x86_32 running in SMP

Why not x86_64 ?

>  - Linux 2.6.23.17
>  - Timer frequency: 1000 Hz
>  - Tick-less mode activated (CONFIG_NO_HZ)
>  - Xenomai Periodic Timing enabled (CONFIG_XENO_OPT_TIMING_PERIODIC)
>  - tasks are kernel-based.
>
>  I'm trying to schedule a periodic task each 8ms and I'm running into
>  period miss
>  (loosing from 5 up to 75, which is quite A LOT). The problem however
>  doesn't appear
>  on UP system (or at least when booting the kernel with maxcpus=1 ).

Have you run the latency test to know if you have no hardware issue ?

-- 
 Gilles

