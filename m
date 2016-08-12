Date: Fri, 12 Aug 2016 11:30:57 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20160812113057.1eed5e0e@md1em3qc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] dealing with non-synchronized TSCs in Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>, "KISZKA, JAN" <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles@click-hack.org>
Cc: Vincent Berenz <vberenz@tuebingen.mpg.de>

TSCs are the only clocksource that Xenomai is able to use at the moment
and it relies on them to be synchronized across cores. Unfortunately
that is not always the case and the offsets can be substantial. [1]

Linux does test for that on bootup and whenever a CPU is hotplugged and
it will fall back to HPET if TSCs don't turn out to be in sync. That
test result should also tell the user that the system in question is
not fit to be used with Xenomai. I already have a patch that will
actually return an error from the init of the Xenomai module.

But that reaction is pretty drastic, especially since it potentially
disables Xenomai on systems that are already running on a Xenomai stack
"just fine". So the idea was to relax the TSC sync test in Linux and
allow a few hundred ns offset via a kernel parameter. Systems i have
seen TSC async on are sometimes off by something like 2000 cycles, but
most of the time the TSCs are in sync at boottime.

But i have also seen the ocassional 10s of thousands and i have seen
machines where the TSCs seem to always be off, sometimes 100s of
thousands of cycles. I am not sure whether one could just blame the
BIOS or the hardware for that, and actually blaming a component you can
not control does not help solve the problem.

Fact is, we need to get these counters in relatively close sync or we
need another clocksource like the HPET.

TSCs can be synched with MSR 0x10, given the potential for SMIs that is
not trivial but hopefully possible. And here i am hoping/assuming that
once synched they will not start drifting. Modern CPUs have monotonic
TSCs and tell about it via CPUID.

Linux used to have syncing code but that was dropped in 2007. [2]
At the time it did not work well enough, probably also because of power
management and changing frequencies. But today a TSC is stable across
power states and synching is hopefully feasible again.

To conclude i basically see two ways to approach that problem:

1. rely on Linux to test the TSCs and refuse Xenomai service
 - patch Linux to sync the TSCs again
 - maybe patch Linux to slightly relax the sync test, once we are close
   enough

2. rely on Linux to test the TSCs and fall back to another clock, which
   needs to be implemented and wont be as fast

I certainly prefer option 1. because it seems like less effort and it
will maintain a high performance clocksource. And it - if we get the
patches mainline - has the potential to improve Linux and not get these
changes into the ipipe-patch. I am not sure how "bad" it would be
performance-wise to use HPET in Xenomai.

We should include the Linux TSC experts in this discussion at some
point. But right now i am curious to hear opinions, thoughts, and
expertise from the Xenomai community! 

Henning

[1]
http://www.xenomai.org/pipermail/xenomai/2016-August/036615.html
[2]
https://github.com/torvalds/linux/commit/95492e4646e5de8b43d9a7908d6177fb737b61f0


