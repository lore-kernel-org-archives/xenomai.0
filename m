Message-ID: <4B8D2F9D.3050500@domain.hid>
Date: Tue, 02 Mar 2010 16:32:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>	
	<8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid>	
	<4B759DF9.9040800@domain.hid>
	<4B759F35.3050704@domain.hid>	
	<8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid>	
	<4B770554.3080809@domain.hid>	
	<8b216e9e1002131225v16024e66p521d7eaad376441d@domain.hid>	
	<8b216e9e1002150919p250b5270tab0bf5f242e87a25@domain.hid>	
	<4B799016.2040305@domain.hid>	
	<8b216e9e1002151034n362f83afwfd6b9355ec071540@domain.hid>
	<8b216e9e1003020729t58db73fdv88d9927695baae75@domain.hid>
In-Reply-To: <8b216e9e1003020729t58db73fdv88d9927695baae75@domain.hid>
Content-Type: text/plain; charset=UTF-8
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
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: xenomai@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

Felipe Brand=C3=A3o Cavalcanti wrote:
> 2010/2/15 Felipe Brand=C3=A3o Cavalcanti <cavalkaf@domain.hid>
>=20
>>
>> 2010/2/15 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org=
m>
>>
>>   Felipe Brand=C3=A3o Cavalcanti wrote:
>>>> 2010/2/13 Felipe Brand=C3=A3o Cavalcanti <cavalkaf@domain.hid>
>>>>
>>>>> 2010/2/13 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>>>>
>>>>> Felipe Brand=C3=A3o Cavalcanti wrote:
>>>>>>> OK - I did apply the patch to 2.6.30.10, with some very minor
>>>>>> modifications
>>>>>>> in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn't=

>>>>>> defined).
>>>>>>> I also applied the latest Adeos Ipipe patch.
>>>>>>>
>>>>>>> However, the compiled kernel doesn't boot - it actually just sits=

>>> there,
>>>>>>> doing nothing:
>>>>>>>
>>>>>>> Bytes transferred =3D 2555616 (26fee0 hex)
>>>>>>> ## Booting kernel from Legacy Image at 80000000 ...
>>>>>>>    Image Name:   Linux-2.6.30.10
>>>>>>>    Image Type:   ARM Linux Kernel Image (uncompressed)
>>>>>>>    Data Size:    2555552 Bytes =3D  2.4 MB
>>>>>>>    Load Address: 80008000
>>>>>>>    Entry Point:  80008000
>>>>>>>    Verifying Checksum ... OK
>>>>>>>    Loading Kernel Image ... OK
>>>>>>> OK
>>>>>>>
>>>>>>> Starting kernel ...
>>>>>>>
>>>>>>> Uncompressing
>>>>>>>
>>> Linux................................................................=
=2E......................................................................=
=2E..........................
>>>>>>> done, booting the kernel.
>>>>>>>
>>>>>>> My guess is that Linux is simply not sending anything through my
>>> serial
>>>>>>> (i.e., debug) port. Should I attempt to port over the serial driv=
er,
>>> or
>>>>>> is
>>>>>>> this something else?
>>>>>>> I am also downloading kernel 2.6.32 to see if I can make it boot =
on
>>> my
>>>>>> IGEP.
>>>>>>
>>>>>> Do you pass the proper "console=3D" argument to the kernel? Is the=

>>> support
>>>>>> for serial driver enabled in the kernel?
>>>>>>
>>>>>> If yes, then apply trick #1 from the "Tips and tricks" section in =
the
>>>>>> "porting I-pipe to a new board" HOWTO on Xenomai website.
>>>>>>
>>>>>>
>>>>> Yeah, I called it with the console=3D argument, and support is enab=
led.
>>> Just
>>>>> tested 2.6.32 - working fine in my board!
>>>>>
>>>>> I will try 2.6.30 again, but this time with no I-pipe patch, as wel=
l as
>>>>> enabling the low-level debug options.
>>>>>
>>>>>
>>>> OK - so I compiled the kernel with a series of kernel debug options,=
 to
>>> find
>>>> out what was going on. However, the kernel is stuck in a very strang=
e
>>>> position - just after starting the network!
>>> The NET message is not really related to starting the network (it is
>>> only a network protocol which tells you that it suceeeded in register=
ing
>>> to the socket infrastructure), to know where the bug happens, you hav=
e
>>> to add printks to see what happens. The main difference between the
>>> latest I-pipe patch and previous releases is in the GPIO demux handli=
ng.
>>>
>>> Since I have an IGEPv2 on my office, would you mind letting me work o=
n
>>> this, say, next week, and give you a status when done?
>>
> So, any updates in this issue? I would love to get this working this
> month... do you have any tips on how to proceed to do the low-level
> debugging? I really have no clue on where the system is getting stuck.

No, will try and get a Xenomai-patched 2.6.30 running on IGEP real soon
now... However, ARM I-pipe patches for something more recent than 2.6.30
should come soon, so, will not try really hard.

--=20
					    Gilles.


