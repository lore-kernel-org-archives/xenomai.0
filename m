Message-ID: <4757C166.6080704@domain.hid>
Date: Thu, 06 Dec 2007 10:31:18 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Revision 3132 breaks build for Linux 2.4 on PPC
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hello,

I just realized that the patch

http://svn.gna.org/viewcvs/xenomai/branches/v2.3.x/ksrc/arch/powerpc/hal.c?rev=3132&r1=2616&r2=3132

breaks compilation of the Linux 2.4 kernel for PPC:

hal.c: In function `rthal_set_local_cpu_timer':
hal.c:95: warning: implicit declaration of function `per_cpu'
hal.c: In function `rthal_set_cpu_timers_unsafe':
hal.c:128: error: invalid lvalue in assignment
hal.c:131: error: invalid lvalue in assignment

Wolfgang.


