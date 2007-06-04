Message-ID: <46641F17.9070900@domain.hid>
Date: Mon, 04 Jun 2007 16:17:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050301020702030306050104"
Subject: [Xenomai-core] New I-pipe patch for ARM needs testing.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------050301020702030306050104
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


Hi,

in Xenomai repository (trunk and v2.3.x branch), you will find
adeos-ipipe-2.6.20-arm-1.7-03.patch, the latest version of the I-pipe
patch for ARM. In addition to merging support for two new boards (ixp4xx
and at91sam926x), this patch adds a few important features:
- the at91 patch now applies after the I-pipe patch with no reject ;
- it is now possible for Xenomai to preempt Linux during the mm switch,
which should improve Xenomai scheduling latency significantly;
- Xenomai is now able to access directly I-pipe tsc emulation in
user-space, providing a low overhead timing facility to user-space
applications.

Before including this patch in a new release, and because I could only
test the patch on at91rm9200, we would like people to test the patch on
their hardware and give us feedback about the stability and performance.
In order to adequately stress-test Linux mm context switch, please use
something along the lines of the attached test_switch.c.

As for tsc emulation in user-space, I only implemented it for machines
with a free-running counter, hoping that someone (maybe Sebastian or
Stelian ?) with hardware whose tsc is based on a decrementer could do
the work. This tsc emulation in user-space also required to rework a bit
Xenomai configure script: it is now necessary to pass a
--enable-arm-mach option to configure, and to pass the option
--enable-arm-tsc to enable the tsc.

Thanks in advance.

-- 
                                                 Gilles Chanteperdrix

--------------050301020702030306050104
Content-Type: text/x-csrc;
 name="test_switch.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test_switch.c"

#include <stdio.h>
#include <stdlib.h>

#include <sys/types.h>
#include <unistd.h>
#include <sched.h>


int main(void)
{
	pid_t child = fork();

	if (child < 0) {
		perror("fork");
		exit(EXIT_FAILURE);
	}

	for (;;)
		sched_yield();
}

--------------050301020702030306050104--

