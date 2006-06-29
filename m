Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jun 2006 18:36:02 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A6676A@ILEX5.IL.NDS.COM>
From: "Landau, Bracha" <BLandau@domain.hid>
Subject: [Xenomai-help] pthread_mutex_destroy in 2.2 rc2
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

I'm using Xenomai 2.2 rc2 on an MPC8247 board.
When I try to destroy a mutex I get error x10 (EBUSY).
The mutex is not locked. When I run the same code with the regular pthrea=
ds library the function does not return an error.
Is this a Xenomai bug?


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

