Message-ID: <45CCE9FC.50805@domain.hid>
Date: Fri, 09 Feb 2007 23:39:08 +0200
From: Maksym Veremeyenko <verem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Strange deadlock.
References: <45CCCD10.9000008@domain.hid> <1171054472.25642.10.camel@domain.hid>
In-Reply-To: <1171054472.25642.10.camel@domain.hid>
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Philippe Gerum =D0=C9=DB=C5=D4:

>> seems bus_monitor_proc[0] locked mutex and want to lock again but its=20
>> blocked.  (i still looking for stack corruption point, but no success.=
)=20
>> It have the same behavior on two configuration 2.6.17.4 + 2.2.4 and=20
>> 2.6.19.2 + 2.3.0 + 1.7-01
>> i checked with GDB - two task are wating for mutex.
>> All task perform switching to secondary mode.
>=20
> Could you strip your code to a bare minimum that still exhibits this bu=
g
> and post it here ? TIA,
unfortunately i can reproduce this situation only on working model with=20
serial controlled device in one of this threads.

>> 1. On program start after previous crash i unable to create named mute=
x,=20
>> because it [-EEXIST], after bind it's unable to operate with it becaus=
e=20
>> it locked by task from early died program, i have to restart computer.=
=20
>> Any suggestions?
>=20
> Something like this would do:
>=20
> if (rt_mutex_bind("...", &desc) =3D=3D 0)
> 	rt_mutex_delete(&desc);
>=20
> rt_mutex_create("...", &desc);
YES! this works fine for me.


________________________________________
Maksym Veremeyenko

