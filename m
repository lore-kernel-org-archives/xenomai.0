Subject: Re: POSIX clock_gettime value is incorrect
References: <CAPMj8MucOL7MPXCGj5PVvZJsXaOC9zBYbcd8aQx6KQ5yAn=qZQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0ca26c39-a1bb-3a4d-4726-6e782855c531@siemens.com>
Date: Fri, 5 Feb 2021 15:35:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAPMj8MucOL7MPXCGj5PVvZJsXaOC9zBYbcd8aQx6KQ5yAn=qZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sam Daniel <daniel.jacob.samuel@gmail.com>, xenomai@xenomai.org, Greg Gallagher <greg@embeddedgreg.com>

On 05.02.21 07:23, Sam Daniel via Xenomai wrote:
> This is my test program, compiled/linked against the POSIX skin.
> #include <stdio.h>
> #include <stdlib.h>
> #include <time.h>
> int main(int argc, char* argv[]) {
>     timespec time;
>     clock_gettime(CLOCK_REALTIME, &time);
>     fprintf(stdout, "%lu\n", time.tv_sec);
>     return 0;
> }
> 
> When I run it on my Xenomai system, this is its output:
> $ ./clock
> 413
> 
> This appears to be roughly the number of seconds since boot:
> $ uptime
> 04:40:44 up 7 min,  1 user,  load average: 0.36, 0.31, 0.16
> 

Yes, the Xenomai CLOCK_REALTIME is decoupled from the Linux realtime
clock, at least so far. Will change in future Xenomai versions.

> Compiling without POSIX skin and running it has expected results:
> $ ./clock
> 1612500006
> 
> Running date from my bash shell has expected results:
> $ date
> Fri Feb  5 04:38:10 UTC 2021
> 
> I ran the clocktest tool:
> $ clocktest
> == Testing built-in CLOCK_REALTIME (0)
> CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
> --- -------------------- ---------------- ---------- --------------
>   0  -1612499588990078.2           -0.046          0            0.0
>   1  -1612499588990077.8            0.061          0            0.0
>   2  -1612499588990077.8            0.004          0            0.0
>   3  -1612499588990077.8            0.022          0            0.0
> 
> I do not understand its output, but to my eye it does not appear to be
> "correct"...
> 
> After searching through the mailing list, I tried this:
> $ clocktest -C CLOCK_HOST_REALTIME
> clock_gettime failed for clock id 32
> clock_gettime failed for clock id 32
> XNVDSO_FEAT_HOST_REALTIME not available
> clock_gettime failed for clock id 32
> XNVDSO_FEAT_HOST_REALTIME not available
> 
> Which led me to this thread:
> https://www.mail-archive.com/xenomai@xenomai.org/msg15904.html. I, too,
> could not set CONFIG_XENO_OPT_HOSTRT or CONFIG_IPIPE_HAVE_HOSTRT
> 
> 
> So I made this patch:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 124398ef7336..28afa4b4b091 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -149,6 +149,7 @@ config ARM64
>         select HAVE_KRETPROBES
>         select HAVE_IPIPE_SUPPORT
>         select HAVE_IPIPE_TRACER_SUPPORT
> +       select IPIPE_HAVE_HOSTRT if IPIPE
>         select IOMMU_DMA if IOMMU_SUPPORT
>         select IRQ_DOMAIN
>         select IRQ_FORCED_THREADING
> 
> CONFIG_XENO_OPT_HOSTRT and CONFIG_IPIPE_HAVE_HOSTRT were now both set
> to y. Recompiled
> and re-ran with this patch:
> $  clocktest -C CLOCK_HOST_REALTIME
> clock_gettime failed for clock id 32
> clock_gettime failed for clock id 32
> clock_gettime failed for clock id 32
> hostrt data area is not live
> hostrt data area is not live
> 
> I tried the extension flag as well:
> $ clocktest -E -C CLOCK_HOST_REALTIME
> clocktest: bad extension clock name 'CLOCK_HOST_REALTIME': Invalid argument
> 
> I am using Cobalt v3.1 with ipipe-core-4.19.55-arm64-4.patch. Is my kernel
> building configured incorrectly? Am I missing some config parameter?
> 

That patch isn't sufficient. ARM64 lacks the architectural support for
that. I do not recall the reasons, though, maybe Greg can explain.

Also note that CLOCK_HOST_REALTIME will serve for reading time only, not
for scheduling events on it. That is only possible for CLOCK_REALTIME
and CLOCK_MONOTONIC. The purpose of that clock is to permit timestamping
of events in the RT domain.

Again, a limitation to be lifted in future versions.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

