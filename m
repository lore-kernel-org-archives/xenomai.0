Message-ID: <44049605.2000108@domain.hid>
Date: Tue, 28 Feb 2006 19:27:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW:
	[Xenomai-help]	undefinedreference	__xnarch_xchg_called_with_bad_pointer
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3DB1@domain.hid>
	<440479E7.7010800@domain.hid>
In-Reply-To: <440479E7.7010800@domain.hid>
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
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
> Uh. I guess the compiler isn't killing the *_bad_pointer function as=20
> dead code when debug is enabled (although it is dead-code.)

The optimizer is disabled by --enable-debug so that we don't get strange =
jumps=20
while tracing with GDB, I guess that's why the dead code is not eliminate=
d. What=20
about just killing this check, since the same code is already validated w=
hen=20
compiling it as a kernel module? (except asm-uvm/system.h, but that's not=
 important).

  As a
> work-around, I think, you could just comment the line, where=20
> *_bad_pointer is called.
>=20
> -- Heikki Lindholm
>=20
> Roderik_Wildenburg@domain.hid kirjoitti:
>=20
>> You are right, but who is somebody ?  The example definitly does not=20
>> call any xchg-function directly. The only thing I did, was to activate=
=20
>> debugging and recompile all the libraries (make clean; configure=20
>> --debug-enable;  make ) and soon I get this error message when=20
>> compiling the demo (I don=B4t get an error message when debugging is=20
>> disabled) . Amazingly I don=B4t get this error message when compiling=20
>> the native examples (ksrc/skins/native/demos) (debug enabled).
>> Any ideas ?
>>
>> Roderik
>>
>>
>>
>>
>>> -----Urspr=FCngliche Nachricht-----
>>> Von: xenomai-help-bounces@domain.hid
>>> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Heikki Lindholm
>>> Gesendet: Dienstag, 28. Februar 2006 15:48
>>> An: Wildenburg, Roderik RAEK3 MRA
>>> Cc: xenomai@xenomai.org
>>> Betreff: Re: [Xenomai-help] undefinedreference=20
>>> __xnarch_xchg_called_with_bad_pointer
>>>
>>> Roderik_Wildenburg@domain.hid kirjoitti:
>>>
>>>> Dear Gurus,
>>>>
>>>> I have compiled ppc(!)-xenomai with debug information=20
>>>
>>>
>>> (configure --enable-debug), so far so good (compiling of xenomai=20
>>> itself and it=B4s libraries, testsuite etc. was successful).=20
>>>
>>>> Buuuut ..., when compiling the vxWorks-demos=20
>>>
>>>
>>> (ksrc/skins/vxworks/demos/*.c), I get an error message about an=20
>>> undefined refernce __xnarch_xchg_called_with_bad_pointer. I searched=20
>>> for this mysterious function, but could only find it in=20
>>> asm-powerpc/atomic.h, where it is declared as external (extern void=20
>>> __xnarch_xchg_called_with_bad_pointer(void);).
>>>
>>>> Does anybody know, where I can get the implementation of=20
>>>
>>>
>>> this function, or what I have to do else to get rid of the error=20
>>> message ?
>>>
>>> You might also want to read the comment near the extern declaration=20
>>> of the function in atomic.h, where it says that the function is not=20
>>> even intended to be implemented. The error means somebody called=20
>>> *atomic_xchg with wrong arguments (or there's something else wrong=20
>>> like inlines not working).
>>>
>>> -- Heikki Lindholm
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>>
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

