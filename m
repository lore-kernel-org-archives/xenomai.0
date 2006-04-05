Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 5 Apr 2006 17:33:57 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A664EF@ILEX5.IL.NDS.COM>
From: "Landau, Bracha" <BLandau@domain.hid>
Subject: [Xenomai-help] problems building xenomai 2.1 for ppc
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

I'm trying to build xenomai 2.1 for an 8272 architecture using kernel 2.6=
=2E14.
I've successfully put in the adeos patch.
Here are the problems I've encountered.

1) When doing ./scripts/prepare-kernel.sh I get an error that it can't fi=
nd the file /include/asm-powerpc/ipipe.h.
I copied the file ipipe.h from /include/asm-ppc and reran prepare-kernel.=
sh with no errors.

2) After doing the above and configuring the "prepared" kernel for runnin=
g with xenomai, I tried to build the kernel. I got link errors doing it. =
An example of such a link error is:

kernel/built-in.o: In function 'rthal_init':
:undefined reference to 'rthal_arch_init'


(The list is much longer - many undefined references of this sort.)

Any ideas what the problem may be?

*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

