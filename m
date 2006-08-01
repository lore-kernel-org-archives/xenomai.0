Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] mq_send /mq_receive problem
Date: Tue, 1 Aug 2006 18:00:28 +0300
Message-ID: <02AA386EB831044F8537A696BA785C78A668D3@domain.hid>
In-Reply-To: <17615.26137.595343.554692@domain.hid>
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

//*********************************************************
// The following is a snippet from the kernel module:
// (If the delay is put in, it works fine.)
//**********************************************************

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
			status =3D mq_send (link_rq_mq_out, (char *)&linkr, sizeof (linkr), 0)=
;
		}
	}
	return 0;
}

//******************************************************************
// Here's the user code that activates the above:
//*****************************************************************
int CLinkState::GetLinkState (void)
{
	struct link_request linkr;
	linkr.request_type =3D get_link_state;
	int status;
	pthread_mutex_lock (&mutex);
	status =3D mq_send (link_rq, (char *)&linkr, sizeof (linkr), 0);
	DPRINT( ("GetLinkState: mq_send returned %08x\n", status) );
	mq_receive (link_rq, (char *)&linkr, sizeof (linkr), 0);
	DPRINT( ("GetLinkState: mq_receive returned %08x, link up =3D %08x\n", s=
tatus, linkr.link_on) );
	pthread_mutex_unlock (&mutex);
	return linkr.link_on;
}
				=09
-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
Sent: Tuesday, August 01, 2006 5:33 PM
To: Landau, Bracha
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] mq_send /mq_receive problem


Landau, Bracha wrote:
 > I have a low priority thread running in the kernel which receives to a=
 message queue and writes to the same message queue after it processes th=
e message. The message queue is opened for reading and writing.
 > Without a delay (with nanosleep) between the reading (mq_receive) and =
writing (mq_send), the kernel hangs.
 > If I put in a small delay between the mq_send and mq_receive, the mech=
anism works fine.
 > Why is this?

You probably found a bug, could you send us a small example allowing us
to reproduce this bug ?

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

