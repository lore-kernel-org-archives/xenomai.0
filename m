Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] premetion
Date: Thu, 14 Sep 2006 17:55:26 +0530
Message-ID: <9D98C51005D80D43A19A3DF329A61D69515631@domain.hid>
From: "Nilanjan Roychowdhury" <Nilanjan.Roychowdhury@domain.hid>
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

I am confused. Do you mean any thread created in user space with
rt_task_create is a secondary mode thread even if it never makes any
Linux calls.
-Nilanjan

-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org
Sent: Thursday, September 14, 2006 5:48 PM
To: Nilanjan Roychowdhury
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] premetion

On Thu, 2006-09-14 at 17:37 +0530, Nilanjan Roychowdhury wrote:
> Can a normal Linux thread ( pthread with priority 90) can preempt any
> user space XENOMAI thread with priority (85). If the XENOMAI thread is
> running in primary domain ???

No, only if the latter runs in secondary mode.
https://mail.gna.org/public/xenomai-help/2006-08/msg00196.html


>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



