Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Feb 2009 15:17:17 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F7048AD@ukmail.uk.wirelessworld.airvananet.com>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: [Xenomai-help] 2.4.6.1 blackfin patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

Does anyone have a working Adeos patch for the top of the Blackfin =
2008R1 non-SMP branch to get up to 2.4.6.1?  The patch supplied with =
Xenomai doesn't cleanly apply, and after massaging would not compile:

  CC      arch/blackfin/kernel/asm-offsets.s
In file included from include/asm/mach/blackfin.h:47,
                 from include/asm/blackfin.h:89,
                 from include/asm/system.h:404,
                 from include/asm/bitops.h:10,
                 from include/linux/bitops.h:9,
                 from include/linux/thread_info.h:33,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:47,
                 from include/linux/sched.h:46,
                 from arch/blackfin/kernel/asm-offsets.c:31:
include/asm/mach/cdefBF534.h: In function =E2bfin_write_PLL_CTL=E2:
include/asm/mach/cdefBF534.h:55: warning: implicit declaration of =
function =E2__ipipe_test_and_stall_root=E2
In file included from include/linux/ipipe_base.h:29,
                 from include/linux/preempt.h:11,
                 from include/linux/spinlock.h:49,
                 from include/linux/capability.h:47,
                 from include/linux/sched.h:46,
                 from arch/blackfin/kernel/asm-offsets.c:31:
include/asm/ipipe_base.h: At top level:
include/asm/ipipe_base.h:62: error: conflicting types for =
=E2__ipipe_test_and_stall_root=E2
include/asm/mach/cdefBF534.h:55: error: previous implicit declaration of =
=E2__ipipe_test_and_stall_root=E2 was here
make[2]: *** [arch/blackfin/kernel/asm-offsets.s] Error 1

Adding some #include's produced yet more errors of a similar nature.

[The Blackfin branch is located at: =
svn://firewall-sources.blackfin.uclinux.org:80/svn/linux-kernel/branches/=
2008R1]

Regards,

Mike

