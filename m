Message-ID: <454931B9.3070304@domain.hid>
Date: Wed, 01 Nov 2006 17:46:01 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] POSIX headers and PTHREAD_IPROPAGATE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

If I attempt to use PTHREAD_IPROPAGATE in my userspace POSIX skin Xenomai p=
rogram, I get the following:

irqtest.c: In function =91main=92:
irqtest.c:278: error: =91XN_ISR_PROPAGATE=92 undeclared (first use in this =
function)irqtest.c:278: error: (Each undeclared identifier is reported only=
 once
irqtest.c:278: error: for each function it appears in.)

Including <nucleus/intr.h> fixes the problem.  I assume there should be a #=
include in one of the POSIX header files.

-Jeff


