Message-ID: <437CB8BA.8040902@domain.hid>
Date: Thu, 17 Nov 2005 18:07:06 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] v2.1 status
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org


Here is an update regarding the way things progress on the v2.1 branch:

o The build system has been deeply revamped, so that we now fully leave the burden of 
building Xenomai's kernel support to Linux. To this end, the code tree has been 
reorganized in two major sections, the first one contains the kernel-related sources 
(ksrc/), the other is hosting the user-space support (src/). Since the user-space portion 
does not need to know about the kernel sources anymore, several issues have been solved in 
the same move. All in all, things are way simpler than before, which seems to indicate 
that we are heading to the right direction. The documentation for the installation process 
needs to be updated though.

o Also as a matter of build system (and a bit more), v2.1 has been backported to Linux 
2.4, starting with the ppc32 support. We rely on Denx's 2_4-devel tree as our 2.4 kernel 
of reference for this port [1]. A second backport to 2.4/x86 will happen when this combo 
is I-pipe ready. We are ahead of schedule regarding this backport, since it was initially 
planned for Q12006, but since we are going to add more supported architectures in the next 
months, it's better to have a stable build system for that.

o PowerPC-wise (again), we should be close to ready for 2.6.15, since Heikki merged both 
the 32 and 64-bit trees in a single one.

All other tasks planned are undergoing. For my part, I'm going to fiddle now with ADI's 
Blackfin for which we already have the required Adeos support, and create the Xenomai port 
for it. Since this one is uClinux based, we should be able to check that the new build 
system is ok to host any kind of port sanely.

[1] http://www.denx.de/en/Software/CVS/

-- 

Philippe.

