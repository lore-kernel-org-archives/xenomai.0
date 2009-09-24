Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2009 18:10:41 -0500
Message-ID: <181804936ABC2349BE503168465576460C3AE9C1@domain.hid>
References: <181804936ABC2349BE503168465576460C3AE7CB@exchserver.basler.com>
	<4ABBCD13.2000209@domain.hid>
From: "Steve Deiters" <SteveDeiters@domain.hid>
Subject: Re: [Xenomai-help] Printf stops working after receiving signal.
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

I upgraded to Xenomai 2.4.9.1 and get the same behavior.  Any other
ideas as to what may be causing this?

Thanks.



-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Thursday, September 24, 2009 2:49 PM
To: Steve Deiters
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Printf stops working after receiving signal.

Steve Deiters wrote:
> I have a simple little test program, attached below.  When I hit CTL-C

> to break the program, not all of the "finished" lines will print.  If=20
> I remove either the rt_task_shadow call or the sigwait at the end, it=20
> will then print all of them.  Adding a fflush(stdout) to the end does=20
> nothing to help it.
>=20
> I'm not sure if there's some interaction with the Xenomai domain I am=20
> just missing which is causing the print statements to be dropped.
>=20
> This is running on a PowerPC kernel 2.6.24 with Xenoami 2.4.9.

Xenomai 2.4.9 has no I-pipe patch for Linux 2.6.24 for PowerPC. And you
should be using Xenomai 2.4.9.1 and one of the patches it contains.
Earlier patches and earlier revisions are buggy.


--=20
					    Gilles.

