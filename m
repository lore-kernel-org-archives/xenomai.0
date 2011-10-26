Message-ID: <4EA86339.7000309@domain.hid>
Date: Wed, 26 Oct 2011 21:44:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <32d9b02a.29dd933a.4ea82693.8ffcf@domain.hid>
	<4EA828E2.1070400@domain.hid>
	<168a0ee9.3d0d6b71.4ea84aa9.11249@domain.hid>
In-Reply-To: <168a0ee9.3d0d6b71.4ea84aa9.11249@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] installing xenomai on pandaboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Robert <robert-km@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 10/26/2011 08:00 PM, Robert wrote:
>=20
>=20
>=20
> Dnia 26 pa=C5=BAdziernika 2011 17:36 Gilles Chanteperdrix <gilles.chant=
eperdrix@domain.hid> napisa=C5=82(a):
>=20
>> On 10/26/2011 05:26 PM, Robert wrote:
>>>
>>> Dnia 24 pa=C5=BAdziernika 2011 22:58 Gilles Chanteperdrix <gilles.cha=
nteperdrix@domain.hid> napisa=C5=82(a):
>>>
>>>> On 10/24/2011 01:11 PM, Robert wrote:
>>>>>
>>>>>
>>>>>
>>>>> Dnia 24 pa=C5=BAdziernika 2011 13:07 Gilles Chanteperdrix <gilles.c=
hanteperdrix@domain.hid> napisa=C5=82(a):
>>>>>
>>>>>> On 10/24/2011 12:59 PM, Robert wrote:
>>>>>>> Dnia 24 pa=C5=BAdziernika 2011 12:37 Gilles Chanteperdrix <gilles=
=2Echanteperdrix@domain.hid> napisa=C5=82(a):
>>>>>>
>>>>>>>> Ok. Try calling /usr/xenomai/bin/xeno-test instead of cding to t=
he
>>>>>>>> directory and runing ./xeno-test.
>>>>>>>
>>>>>>> No difference.
>>>>>>
>>>>>> I am unable to reproduce this issue, but I am using ash, not bash.=
 last
>>>>>> attempt: could you try adding /usr/xenomai/bin to the PATH variabl=
e?
>>>>>
>>>>> The same.
>>>>
>>>> Could you try the following patch?=20
>>>>
>>>> http://git.xenomai.org/?p=3Dxenomai-head.git;a=3Dcommitdiff;h=3D8f2f=
d0b49e51fb2547c4972f2cda9e32dfc5dca6;hp=3D82ab99a3a840dd78c3ed8e5a6555f42=
2420b7827
>>>>
>>>> The problem is due to dash, not bash, which is linked to /bin/sh by =

>>>> default on ubuntu.=20
>>>>
>>>
>>> I applied Yours patches, and now it compile and almost run:
>>>
>>> root@domain.hid:/# /usr/xenomai/bin/xeno-test                             =
=20
>>> Started child 1035: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper =
/usr/xenoma
>>> i/bin/xeno-test                                                      =
          =20
>>> ++ echo 0=20
>>>
>>> After that, board is dead.
>>>
>>> And I have to build xenomai sources using 'make CFLAGS+=3D-Wa,mimplic=
it-it=3Dthumb'.
>>> My gcc version 4.5.2-8ubuntu4
>>
>> Please send me your .config, but beware your mailer, it wraps long lin=
e,
>> which make the last .config you sent unusable. I have not tried buildi=
ng
>> for thumb, if that is what you are doing.
>>
>> You can try running the "latency" command alone, to see if it also
>> hangs. You should also redirect the kernel console to the serial port,=

>> and capture the serial port on another computer, in case the hang is a=

>> kernel oops.
>>
>> Find attached the .config I use, and which works here.
>=20
>=20
> Xenomai: incompatible feature set
> (userland requires "kuser_tsc fastsynch nosmp", kernel provides "sa1100=
 v6 e
> abi kuser_tsc fastsynch smp", missing=3D"nosmp").
>=20
> I still don't know how to boot pandaboard with smp support.
>=20
> My config is here: http://www.copypastecode.com/88653/

Enable SMP when compiling Xenomai user-space support, by passing
--enable-smp to the configure script.

>=20
>=20


--=20
                                                                Gilles.


