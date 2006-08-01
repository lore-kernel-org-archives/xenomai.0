Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] mq_send /mq_receive problem - code sample
	correction
Date: Tue, 1 Aug 2006 18:05:08 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A668D4@domain.hid>
In-Reply-To: <1154442862.4963.24.camel@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

In the code sample I sent, the following should be the kernel snippet:
*********************************************

static void *LinkThread (struct net_device *dev)
{
	int status;
	link_request linkr;
struct timespec ttt,xxx;
ttt.tv_sec =3D 2;
ttt.tv_nsec =3D 0;

	while (1)
	{
		if ((status=3Dmq_receive (link_rq_mq, (char *)&linkr, sizeof (linkr), 0=
)) > 0)
		{
//nanosleep (&ttt, &xxx);
			status =3D mq_send (link_rq_mq, (char *)&linkr, sizeof (linkr), 0);
		}
		else
		{
			printk ("linkthread:mq_receive returned %08x, errno=3D%08x\n", status,=
 errno);
			break;
		}
	}
	return 0;
}
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

