Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 May 2010 14:03:08 -0700
Message-ID: <2319761F7FA0D1479BA77EC2E0A8E7BCE8A603@domain.hid>
In-Reply-To: <1274047063.2972.1.camel@domain.hid>
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
	<1274047063.2972.1.camel@domain.hid>
From: "Abhijit Majumdar" <abhijit.majumdar@domain.hid>
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

Hi

I get similar problem the xenomai posix skin. I have the latest version
of Xenomai (2.5.3) and kernel 2.6.28.=20

I am using clock_nanosleep(CLOCK_REALTIME, ......) to wait for 1
millisecond. It freezes the system. However if I sleep for a second it
is fine.

Philippe, should your fix work in my case too? If so, can you please
send the fix.

thanks
Abhijit

-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid]
On Behalf Of Philippe Gerum
Sent: Sunday, May 16, 2010 2:58 PM
To: Steve Deiters
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC

On Fri, 2010-05-14 at 19:18 -0500, Steve Deiters wrote:
> I am running Xenomai 2.5.3, I-pipe version 2.9-00, with Linux 2.6.33.4
> on a PowerPC MPC5121.  With small values of sleep ticks passed to
> rt_task_sleep, I get various sorts of crashes.  Here is a simple
program
> using a delay loop that exhibits the behavior.

<snip>

>=20
> I'm not sure if I have something misconfigured or what.  I am
upgrading
> from Xenomai 2.4.10 on an older kernel and I did not have this same
> problem.
>=20

Bug confirmed here. Your setup is not involved, I'll send a fix asap.

> Thanks.
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.



_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

