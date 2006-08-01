Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] mq_send /mq_receive problem
Date: Tue, 1 Aug 2006 18:13:22 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A668D5@domain.hid>
In-Reply-To: <17615.28311.703965.598653@domain.hid>
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

The queue is opened with O_CREAT | O_RDWR.
Please note that I sent an updated version of the code that causes the cr=
ash - the queue in both the mq_send and mq_receive is "link_rq_mq".


-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Tuesday, August 01, 2006 6:09 PM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: RE: [Xenomai-help] mq_send /mq_receive problem


Landau, Bracha wrote:
 > //*********************************************************
 > // The following is a snippet from the kernel module:
 > // (If the delay is put in, it works fine.)
 > //**********************************************************
 >=20
 > static void *LinkThread (struct net_device *dev)
 > {
 > 	int status;
 > 	link_request linkr;
 > struct timespec ttt,xxx;
 > ttt.tv_sec =3D 2;
 > ttt.tv_nsec =3D 0;
 >=20
 > 	while (1)
 > 	{
 > 		if ((status=3Dmq_receive (link_rq_mq, (char *)&linkr, sizeof (linkr)=
, 0)) > 0)
 > 		{
 > //nanosleep (&ttt, &xxx);
 > 			status =3D mq_send (link_rq_mq_out, (char *)&linkr, sizeof (linkr),=
 0);
 > 		}
 > 	}
 > 	return 0;
 > }

What are the flags passed to mq_open ? If for example O_NONBLOCK is set,
then the behaviour you observe is normal.

--=20


					    Gilles Chanteperdrix.
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

