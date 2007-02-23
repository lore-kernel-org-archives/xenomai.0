From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1170205077.21219.67.camel@domain.hid>
References: <1170205077.21219.67.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 17:18:28 +0100
Message-Id: <1172247508.26738.67.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: Heads up: Xenomai port over x86_64 has started
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org
Cc: adeos-main@gna.org

On Wed, 2007-01-31 at 01:58 +0100, Philippe Gerum wrote:
> Ok, no more distant rumblings about x86_64: a Xenomai port to this
> architecture has officially started. A preliminary version of the I-pipe
> for x86_64 is now available, which I'm going to use to port the Xenomai
> core.

Here we are. The following revised I-pipe patch is stable enough to run
the Xenomai trunk/ on a 4-way Opteron, and on qemu-x86_64 0.8.2 too:
http://download.gna.org/adeos/patches/v2.6/x86_64/adeos-ipipe-2.6.19-x86_64-1.0-02.patch

The status of the Xenomai/x86_64 port is as follows:

- real-time support in user-space is mostly ok, except the FPU
management over the Xenomai domain which is broken beyond all
recognition. Gilles, as already discussed, I won't resist to let you
bang your head on this wall instead of mine, because 1) this will allow
me to switch to the pending issues people have raised on the lists so
far, 2) I'm fundamentally evil, 3) the fact that you once did dare
rewriting the FPU support for Xenomai/x86 clearly shows that you do have
some masochistic tendencies anyway.
- real-time support in kernel space is ok (except if you plan to use the
FPU in real-time context over kernel modules, that is).
- the I-pipe tracer is available. I used it as my preferred tool for
debugging when the bugs did not involve switching power off. There might
be issues I did not notice regarding the information reported by the
tracing sub-system, so please Jan, have a look at the beast.

To sum up, the testsuite passes properly, except switchtest ATM, since
the FPU is heavily involved there.

General note: this is _preliminary_ support, don't ever think about
using this in production right now. This said, things looks promising,
and I eventually learnt to like this port. If anyone as some results to
share with us after having tried this preliminary work, he will be most
welcome.

-- 
Philippe.



