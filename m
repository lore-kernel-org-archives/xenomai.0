Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 May 2008 14:02:44 +0200
Message-ID: <A3B06EAFE0D9C14096681C935E0B300802142F7B@zue-s-15.zue.zwick.de>
In-Reply-To: <482A831C.6000801@domain.hid>
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid>	<A3B06EAFE0D9C14096681C935E0B300802110F22@domain.hid>
	<4829A948.6080806@domain.hid> <482A831C.6000801@domain.hid>
From: "Kaeppeler, Oliver" <Oliver.Kaeppeler@domain.hid>
Subject: Re: [Xenomai-help] gdb + multi-threaded application + Intel dual
	core	processor + Xenomai => frozen system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Hello Jan,

thanks for testing. We fixed the problem now.

The problem was that we used the daily snapshot of trunk =
(http://svn.gna.org/daily/xenomai-snapshot.tar.gz - the bottom most link =
on https://gna.org/svn/?group=3Dxenomai named "Sourcecode Daily =
Snapshot"), which does not contain the fix.
Now we patched it manually based on the patch given in =
"[Xenomai-core][PATCH] avoid deadlock-prone sighand_lock in =
do_schedule_event" and everything runs fine.

So obviously http://svn.gna.org/daily/xenomai-snapshot.tar.gz doesn't =
really contain the current trunk.

Regards,
Oliver.
=20

-----Urspr=FCngliche Nachricht-----
Von: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Gesendet: Mittwoch, 14. Mai 2008 08:14
An: Kaeppeler, Oliver
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] gdb + multi-threaded application + Intel =
dual core processor + Xenomai =3D> frozen system

Jan Kiszka wrote:
> Kaeppeler, Oliver wrote:
>> Hello Jan,
>>
>> thanks for your answer. We had used Xenomai 2.4.3 in our tests. Now, =
I also tried the daily snapshot version, but the problem remains.
>>
>> The problem should be reproducable by the sample program, we attached =
in our last message...
>=20
> OK, will give this a try later today.

Done, but so far without success, even with your .config. Are you sure =
that you booted the right kernel after the update (and that the update =
actually contained the fix)?

Jan


