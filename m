Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Nov 2005 15:46:43 +0200
Message-ID: <02AA386EB831044F8537A696BA785C78076485@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
Subject: [Xenomai-help] using mq_receive and mq_send
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org.

I am using Xenomai on the MPC8272ADS board with kernel 2.6.14.3.

I've created an application that uses posix message queuing from xenomai.=


When I call mq_open, mq_close, mq_setattr, mq_getattr, mq_unlink - the ca=
lls succeed.

When I call mq_receive or mq_send, the call fails (returns -1) and errno =
is set to 1 (Operation not permited).

I put some debugging printk's into the xenomai code and it seems it doesn=
't even get to the call to __mq_receive or __mq_send from syscall.c (it d=
oes get to printk's that I put in  the other __mq_* functions).

Can anyone help?

Thanks,
Bracha

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

