References: <20160812113057.1eed5e0e@md1em3qc>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <81acad55-ac3f-2916-10b7-d0a04f0d7ced@xenomai.org>
Date: Mon, 5 Sep 2016 12:11:44 +0200
MIME-Version: 1.0
In-Reply-To: <20160812113057.1eed5e0e@md1em3qc>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] dealing with non-synchronized TSCs in Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>, Xenomai@xenomai.org, "KISZKA, JAN" <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles@click-hack.org>
Cc: Vincent Berenz <vberenz@tuebingen.mpg.de>

On 08/12/2016 11:30 AM, Henning Schild wrote:
> TSCs are the only clocksource that Xenomai is able to use at the moment
> and it relies on them to be synchronized across cores. Unfortunately
> that is not always the case and the offsets can be substantial. [1]
> 
> Linux does test for that on bootup and whenever a CPU is hotplugged and
> it will fall back to HPET if TSCs don't turn out to be in sync. That
> test result should also tell the user that the system in question is
> not fit to be used with Xenomai. I already have a patch that will
> actually return an error from the init of the Xenomai module.
> 
> But that reaction is pretty drastic, especially since it potentially
> disables Xenomai on systems that are already running on a Xenomai stack
> "just fine". So the idea was to relax the TSC sync test in Linux and
> allow a few hundred ns offset via a kernel parameter. Systems i have
> seen TSC async on are sometimes off by something like 2000 cycles, but
> most of the time the TSCs are in sync at boottime.
> 
> But i have also seen the ocassional 10s of thousands and i have seen
> machines where the TSCs seem to always be off, sometimes 100s of
> thousands of cycles. I am not sure whether one could just blame the
> BIOS or the hardware for that, and actually blaming a component you can
> not control does not help solve the problem.
> 
> Fact is, we need to get these counters in relatively close sync or we
> need another clocksource like the HPET.
> 
> TSCs can be synched with MSR 0x10, given the potential for SMIs that is
> not trivial but hopefully possible. And here i am hoping/assuming that
> once synched they will not start drifting. Modern CPUs have monotonic
> TSCs and tell about it via CPUID.
> 
> Linux used to have syncing code but that was dropped in 2007. [2]
> At the time it did not work well enough, probably also because of power
> management and changing frequencies. But today a TSC is stable across
> power states and synching is hopefully feasible again.
> 
> To conclude i basically see two ways to approach that problem:
> 
> 1. rely on Linux to test the TSCs and refuse Xenomai service
>  - patch Linux to sync the TSCs again
>  - maybe patch Linux to slightly relax the sync test, once we are close
>    enough
> 
> 2. rely on Linux to test the TSCs and fall back to another clock, which
>    needs to be implemented and wont be as fast
> 
> I certainly prefer option 1. because it seems like less effort and it
> will maintain a high performance clocksource. And it - if we get the
> patches mainline - has the potential to improve Linux and not get these
> changes into the ipipe-patch. I am not sure how "bad" it would be
> performance-wise to use HPET in Xenomai.
> 
> We should include the Linux TSC experts in this discussion at some
> point. But right now i am curious to hear opinions, thoughts, and
> expertise from the Xenomai community! 
> 
> Henning
> 
> [1]
> http://www.xenomai.org/pipermail/xenomai/2016-August/036615.html
> [2]
> https://github.com/torvalds/linux/commit/95492e4646e5de8b43d9a7908d6177fb737b61f0
> 
> 

Xenomai cannot use the HPET as a clocksource because we don't have the
support code for reading from the MMIO-based HPET_COUNTER register from
userland. So far, cobalt_read_tsc() over x86 only knows about reading
the per-CPU tsc. So, at any rate, enabling the HPET for Xenomai as a
clocksource would require to extend this.

Actually, the only sane way to address this issue would be for Xenomai
to reuse the regular clock_gettime() interface directly from the vDSO,
making it generally suitable for getting the monotonic time from any
pipeline stages, instead of reimplementing our own wheel. That would
make the support for fast tsc<->ns conversion helpers (written in
assembly code) useless, implicitly enable ntp correction, simplify the
integration of high precision timers in the mainline code by rebasing
time values on nanosecs instead of raw timestamps, and the notion of
CLOCK_HOST_REALTIME would match CLOCK_REALTIME eventually. Gilles was
precisely working on this for ARM [2], for the new "dovetail" [3]
architecture of the pipeline. For several reasons, this is not an effort
than can be completed overnight, and certainly not aimed at the current
pipeline architecture Xenomai uses.

Bottom line is that HPET is not suitable for real-time usage; it's slow
to read the time from [1]. For that reason, I don't think that teaching
Xenomai how to read that counter from userland would be worth the effort.

Unsynced TSC area a problem only when time references obtained from
Xenomai are shared between CPUs, so I tend to favor option #1 too.

People who insist on sharing time references between CPUs with unsynced
CPUs should disable the check with tsc=reliable provided the offset is
bearable. If not, the hardware would not be suitable for real-time usage
anyway, since falling back to HPET would not a suitable option either.

[1] https://patchwork.kernel.org/patch/8814521/
[2]
http://git.xenomai.org/ipipe-gch.git/commit/?h=symbiote-mmio-clocksource&id=a25f72010194a1d6c0e601934cd01816c73642a6
[3] I know that I need to clarify the goal and purpose of that
"dovetail" thing which have popped up in some e-mails here and there
over the past months, along with several other important issues. This is
brewing.

-- 
Philippe.

