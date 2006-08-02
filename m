Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] mq_send /mq_receive problem
Date: Wed, 2 Aug 2006 09:47:16 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A668D6@domain.hid>
In-Reply-To: <17615.48165.184151.82875@domain.hid>
From: "Landau, Bracha" <BLandau@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks. I did have a printf call in my "producer" function between the se=
nd and receive.=20
Is this a bug?
Using two separate message queues does fix the problem, though I would ex=
pect that, as long as there is a mutex around the use in the "producer" f=
unction, one message queue should suffice.


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Tuesday, August 01, 2006 11:40 PM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai-help] mq_send /mq_receive problem


Landau, Bracha wrote:
 > The queue is opened with O_CREAT | O_RDWR.
 > Please note that I sent an updated version of the code that causes the=
 crash - the queue in both the mq_send and mq_receive is "link_rq_mq".

Merging your sample with the code of the satch example, I arrived to the
attached test that work as expected as long as:
- the task priorities are correctly set
- there is no printf call between the mq_send and mq_receive in the
  "producer" function. It looks like such a printf suspends the
  GetLinkState thread out of mq_receive, so that when the LinkThread
  send a message, it is able to immediately receive it.

This state of affair is a bit fragile, in order to do something more
robust, you should probably use one message queue for each direction.

--=20


					    Gilles Chanteperdrix.

*** NDS UK IT scanned this email for malicious content ***
*** IMPORTANT: Do not open attachments from unrecognized senders  ***
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

