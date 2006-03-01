Message-ID: <44055555.5050501@domain.hid>
Date: Wed, 01 Mar 2006 09:03:33 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW:
	AW:[Xenomai-help]	undefinedreference	__xnarch_xchg_called_with_bad_pointer
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3DF1@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A1C3DF1@domain.hid>
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
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
> Any idea why I don=B4t get this error when compiling the native example=
s. Isn=B4t atomic.h included with these examples too ?=20

Included yes, but not actually used.

>=20
>=20
>>-----Urspr=FCngliche Nachricht-----
>>Von: xenomai-help-bounces@domain.hid
>>[mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Heikki Lindholm
>>Gesendet: Dienstag, 28. Februar 2006 20:06
>>An: Philippe Gerum
>>Cc: xenomai@xenomai.org
>>Betreff: Re: AW:[Xenomai-help] undefinedreference=20
>>__xnarch_xchg_called_with_bad_pointer
>>
>>Philippe Gerum kirjoitti:
>>
>>>Heikki Lindholm wrote:
>>>
>>>
>>>>Uh. I guess the compiler isn't killing the *_bad_pointer=20
>>
>>function as=20
>>
>>>>dead code when debug is enabled (although it is dead-code.)
>>>
>>>
>>>The optimizer is disabled by --enable-debug so that we don't get=20
>>>strange jumps while tracing with GDB, I guess that's why=20
>>
>>the dead code=20
>>
>>>is not eliminated. What about just killing this check,=20
>>
>>since the same=20
>>
>>>code is already validated when compiling it as a kernel module?=20
>>>(except asm-uvm/system.h, but that's not important).
>>
>>Yep. That seems like the way to go. I don't see much to gain=20
>>from the check. Of course, paranoid way would be to add the=20
>>__bad_ptr() function with abort() or something inside. Quick=20
>>patch attached for the former case.
>>
>>- hl
>>
>=20
>=20


--=20

Philippe.

