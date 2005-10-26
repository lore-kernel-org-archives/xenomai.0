Message-ID: <435F9469.9060701@domain.hid>
Date: Wed, 26 Oct 2005 16:36:25 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Spawn Task from a Task -vxworks-skin
References: <10692.1130336592@domain.hid> <31499.1130337090@domain.hid>
In-Reply-To: <31499.1130337090@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: "j.p.schulz" <j.p.schulz@domain.hid>
Cc: xenomai@xenomai.org

j.p.schulz wrote:
>>--- Urspr=FCngliche Nachricht ---
>>Von: Philippe Gerum <rpm@xenomai.org>
>>An: "j.p.schulz" <j.p.schulz@domain.hid>
>>Kopie: xenomai@xenomai.org
>>Betreff: Re: [Xenomai-help] Spawn Task from a Task -vxworks-skin
>>Datum: Wed, 26 Oct 2005 15:54:24 +0200
>>
>>j.p.schulz wrote:
>>
>>>>--- Urspr=FCngliche Nachricht ---
>>>>Von: Philippe Gerum <rpm@xenomai.org>
>>>>An: "j.p.schulz" <j.p.schulz@domain.hid>
>>>>Kopie: xenomai@xenomai.org
>>>>Betreff: Re: [Xenomai-help] Spawn Task from a Task -vxworks-skin
>>>>Datum: Wed, 26 Oct 2005 10:09:19 +0200
>>>>
>>>>j.p.schulz wrote:
>>>>
>>>>
>>>>>Hello
>>>>>I have Problems spawning a Task from a Task under the vxworks skin!
>>>>>If I spawn my Tasks from a Funktion - it works!
>>>>>If I spawn my Tasks from a Task     - system crashes!
>>>>
>>>>Make sure to use an Adeos patch >=3D 1.0-07. v0.9.1 ships with 1.0-02=
, so
>>>>you=20
>>>>likely want to upgrade and try again. Recent Adeos patches for x86 ca=
n
>>
>>be
>>
>>>>found=20
>>>>here: http://download.gna.org/adeos/patches/v2.6/adeos/i386/
>>>>
>>>
>>>
>>>I installed the latest Fusion 9.1 patch - no changes
>>
>>Which _Adeos_ patch version, exactely?
>=20
>=20
> First I tried adeos-ipipe-2.6.13-i386-1.0-07.patch=20
> and now       adeos-ipipe-2.6.13-i386-1.0-08.patch
>=20
>=20
>>>Do I make a mistake when I am spawning the tasks?
>>>
>>>Second Problem ist that the uvm module has to be started twice. The
>>
>>first
>>
>>>attempt returns: -1 Function not implemented=20
>>>The second attempt works!=20
>>>
>>
>>Does dmesg say something after the first attempt?
>=20
> =20
> No, but why does it work after the second attempt?

If only I knew it, I would not ask for more information.

  It is possible that the
> task spawn problem is caused by the uvm module?=20

I have no clue right now. Ok, issue logged.

> Ups - there is something: dmesg says RTAI: starting the UVM services
>=20
> Thanks=20
> Jan-Peter
>=20


--=20

Philippe.

