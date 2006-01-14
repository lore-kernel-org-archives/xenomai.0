Message-ID: <43C8D37C.4070302@domain.hid>
Date: Sat, 14 Jan 2006 11:33:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.1-rc2
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
Cc: Philippe Gerum <philippe.gerum@domain.hid>


-rc2 has been released [1]. It looks like people have been rather busy with this
one; here is what's new since -rc1, in no particular order:

- The ARM port [Stelian]. This work has been co-sponsored by the Video Compression
and Networking group from Thomson Grass Valley [2], and Openwide.  This
initial port has been conducted on an Integrator/CP board featuring an ARM 1136 core.

- POSIX skin updates [Gilles].

- Allow building the kernel from within the Xenomai tree [Gilles]. This is for
those who dislike having to deal with compiling the kernel and user-space trees
separately.

- Major bug fix regarding the hybrid scheduling feature, i.e. the ability to make
transitions between kernel-based and user-space Xenomai threads [me, Heikki].
Basically all archs are concerned by this fix, but x86 which had no problem
regarding this issue. As Heikki put it once rather politely in the light of such a
mess, "A good test-suite seems like a must". Ahem, yeah...

- Provide support for 2.6.15/x86 [me]. Other archs will follow.

- Upgrade to the most recent I-pipe series for all archs, allowing to shorten the
interrupt path a bit [Dmitry].

- RTDM-based benchmark suite [Jan]. Our good ol' kernel-based latency test is up
and running again, along with a new timer-only benchmark. This code exploits the
I-pipe's new latency tracer for x86 [Jan].

And a slew of fixes and cleanups all over the map. See the ChangeLog for details
as usual.

As a sidenote, now that all archs have a reliable and complete I-pipe support, the
oldgen Adeos patches have been deprecated, and support for them has been dropped
from the codebase.

Next step is -rc3, hopefully the last one before final, scheduled for the first
week of February, which de facto postpones v2.1 final for a couple of weeks or so.

I'm going off-line from now to the end of January. Gilles will take the reins
during that period.

[1] http://download.gna.org/xenomai/testing/xenomai-2.1-rc2.tar.bz2
[2] http://www.thomsongrassvalley.com/products_vcn

-- 

Philippe.



