Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 1 Aug 2006 17:27:51 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A668D1@domain.hid>
In-Reply-To: <200608011001.k71A1RPp024916@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
Subject: [Xenomai-help] mq_send /mq_receive problem
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

I have a low priority thread running in the kernel which receives to a me=
ssage queue and writes to the same message queue after it processes the m=
essage. The message queue is opened for reading and writing.
Without a delay (with nanosleep) between the reading (mq_receive) and wri=
ting (mq_send), the kernel hangs.
If I put in a small delay between the mq_send and mq_receive, the mechani=
sm works fine.
Why is this?
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

