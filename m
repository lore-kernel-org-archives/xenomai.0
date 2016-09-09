Message-ID: <08AAAB36BFF54B11B600000E17F0C13F@itd206>
From: "Sureshvs" <sureshvs@datapatterns.co.in>
Date: Fri, 9 Sep 2016 18:31:41 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Reg:Linux 3.10.32 xenomai UART problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: sureshvsmca@gmail.com

Hi

ARCH=3DpowerPC
Processor: MPC8641
Linux Kernel : 3.10.32
Xenomai patch version: xenomai-2.6.3
ipipe : ipipe-core-3.10.32-powerpc-2.patch

We have ns16550 compatible two UART in our mpc8641 processor and 6 external=
 UART interface.

We have tested all 8 UARTS in linux without xenomai patch and it is working=
 fine.But with xenomai patched kernel when we test external UARTS system ha=
ngs after 10 to 15 minutes of testing.

kindly help us to sove the problem.


Regards
Suresh V.S

**************** CAUTION - Disclaimer *****************This email may conta=
in confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribu=
tion or disclosure by others is strictly prohibited. If you are not the int=
ended recipient (or authorized to receive for the recipient), please contac=
t the sender by reply email and delete all copies of this message. Also, em=
ail is susceptible to data corruption, interception, tampering, unauthorize=
d amendment and viruses. We only send and receive emails on the basis that =
we are not liable for any such corruption, interception, tampering, amendme=
nt or viruses or any consequence thereof.=20
*********** End of Disclaimer ***********DataPatterns ITS Group**********

