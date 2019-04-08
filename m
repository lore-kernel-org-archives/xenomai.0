MIME-Version: 1.0
References: <CA+K1mPFRVPqD_Gg2_7_PqcpegJ+ADJm3hea2AHxiHzwwBBG_iw@mail.gmail.com>
 <3d5044db-0b5c-fe4a-480c-b50943d440e5@siemens.com>
 <CA+K1mPEfLdrvGOqnX+1F6omFQq-CT75v2-5qTXF8Rj8NY=mHrQ@mail.gmail.com>
 <e557148a-392d-3c8e-615e-58c60c03e6e1@xenomai.org>
 <CA+K1mPENXX69Y+fF39dDXR1+pikeakcqKYkVfow-mD-QJcDJmw@mail.gmail.com>
 <056086d0-c53a-4494-7db5-224dcc325071@xenomai.org>
 <dee298b4-cd02-6cf5-0776-c8a92b80b2e5@xenomai.org>
In-Reply-To: <dee298b4-cd02-6cf5-0776-c8a92b80b2e5@xenomai.org>
From: C Smith <csmithquestions@gmail.com>
Date: Sun, 7 Apr 2019 23:31:26 -0700
Message-ID: <CA+K1mPEHZ+rCgd-QygJGcbicuZ-0n4bXvZZ1x1qei7x3fgJ=7Q@mail.gmail.com>
Subject: Re: Periodic timing varies across boots
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Sumitabh Ghosh via Xenomai <xenomai@xenomai.org>

Hi Philippe,

I did work on this last month and thought I would give you the final
results and analysis.

I did isolcpus in grub.cfg and recompiled my kernel with all the option
changes you folks recommended to prevent interference with my periodic
routine. That did not solve it, but it may be helping.

My main problem was that the CPU (and TSC) seemed to be running at slightly
different speeds every time I cold-boot the motherboard. So in order for my
Xenomai periodic routine to have a consistent period across boots, I needed
some objective clock to calibrate the TSC period.

I get counts with rt_timer_tsc(). Unfortunately, I found that the Xenomai
conversion from TSC ticks to nsec is not as accurate as the kernel TSC
calibration. I'm not sure what method Xenomai uses as its calibration
factor in rt_timer_tsc2ns().

So I hacked tsc.c in the kernel to do 2 things at boot time:
1. Calibrate for 4 seconds instead of 1 sec
2. Export the full resolution of its calibration to kernelspace (as Hz
instead of kHz), so now there is a new variable available to kernelspace
drivers: tsc_hz.

# cat /proc/kallsyms
c19a8928 D tsc_hz
c19a892c D tsc_khz

(I may try to submit this patch to the mainline kernel sources. If I needed
it, maybe someone else does...)

Now I can do my own conversion from TSC counts to seconds in my driver, by
multiplying TSC counts from rt_timer_tsc() by the period my new kernel
variable indicates (1.0/(double)tsc_hz).

The results of using this calibration to adjust my routines period routine
are much better: instead of a variation of up to +/-700nsec in the period
of my routine across boots, the deviation is about +/-50ns, measured on a
real-world frequency counter.

thanks,
C Smith

On Fri, Mar 1, 2019 at 12:09 AM Philippe Gerum <rpm@xenomai.org> wrote:

> On 3/1/19 9:05 AM, Philippe Gerum via Xenomai wrote:
> In order to mitigate this issue, you could try to isolate the
> > CPU used by the rt work loop using isolcpus, even if this can't block
> > any non-rt activity on that CPU,
> should read as: even if this can't fully block all non-rt activity on
> this CPU.
>
> --
> Philippe.
>
