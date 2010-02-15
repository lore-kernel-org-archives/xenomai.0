Message-ID: <4B799016.2040305@domain.hid>
Date: Mon, 15 Feb 2010 19:19:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<4B746FFE.20204@domain.hid>
	<8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid>
	<4B750157.6080000@domain.hid>
	<8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid>
	<4B759DF9.9040800@domain.hid> <4B759F35.3050704@domain.hid>
	<8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid>
	<4B770554.3080809@domain.hid>
	<8b216e9e1002131225v16024e66p521d7eaad376441d@domain.hid>
	<8b216e9e1002150919p250b5270tab0bf5f242e87a25@domain.hid>
In-Reply-To: <8b216e9e1002150919p250b5270tab0bf5f242e87a25@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Cc: xenomai@xenomai.org

Felipe Brand=E3o Cavalcanti wrote:
> 2010/2/13 Felipe Brand=E3o Cavalcanti <cavalkaf@domain.hid>
>=20
>>
>> 2010/2/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>> Felipe Brand=E3o Cavalcanti wrote:
>>>> OK - I did apply the patch to 2.6.30.10, with some very minor
>>> modifications
>>>> in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn't
>>> defined).
>>>> I also applied the latest Adeos Ipipe patch.
>>>>
>>>> However, the compiled kernel doesn't boot - it actually just sits th=
ere,
>>>> doing nothing:
>>>>
>>>> Bytes transferred =3D 2555616 (26fee0 hex)
>>>> ## Booting kernel from Legacy Image at 80000000 ...
>>>>    Image Name:   Linux-2.6.30.10
>>>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>>>    Data Size:    2555552 Bytes =3D  2.4 MB
>>>>    Load Address: 80008000
>>>>    Entry Point:  80008000
>>>>    Verifying Checksum ... OK
>>>>    Loading Kernel Image ... OK
>>>> OK
>>>>
>>>> Starting kernel ...
>>>>
>>>> Uncompressing
>>>>
>>> Linux................................................................=
.........................................................................=
.........................
>>>> done, booting the kernel.
>>>>
>>>> My guess is that Linux is simply not sending anything through my ser=
ial
>>>> (i.e., debug) port. Should I attempt to port over the serial driver,=
 or
>>> is
>>>> this something else?
>>>> I am also downloading kernel 2.6.32 to see if I can make it boot on =
my
>>> IGEP.
>>>
>>> Do you pass the proper "console=3D" argument to the kernel? Is the su=
pport
>>> for serial driver enabled in the kernel?
>>>
>>> If yes, then apply trick #1 from the "Tips and tricks" section in the
>>> "porting I-pipe to a new board" HOWTO on Xenomai website.
>>>
>>>
>> Yeah, I called it with the console=3D argument, and support is enabled=
. Just
>> tested 2.6.32 - working fine in my board!
>>
>> I will try 2.6.30 again, but this time with no I-pipe patch, as well a=
s
>> enabling the low-level debug options.
>>
>>
>=20
> OK - so I compiled the kernel with a series of kernel debug options, to=
 find
> out what was going on. However, the kernel is stuck in a very strange
> position - just after starting the network!

The NET message is not really related to starting the network (it is
only a network protocol which tells you that it suceeeded in registering
to the socket infrastructure), to know where the bug happens, you have
to add printks to see what happens. The main difference between the
latest I-pipe patch and previous releases is in the GPIO demux handling.

Since I have an IGEPv2 on my office, would you mind letting me work on
this, say, next week, and give you a status when done?

--=20
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

