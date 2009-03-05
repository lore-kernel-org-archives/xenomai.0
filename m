Message-ID: <49AF98EA.7080600@domain.hid>
Date: Thu, 05 Mar 2009 10:18:34 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0183D12A@ARVMAIL1.mra.roland-man.biz>
	<499E7967.3000209@domain.hid>
	<4B2EEE69E41E524EB7FCDC62A15D68D80312FEE6@domain.hid>
	<49AE4264.6070506@domain.hid>
	<4B2EEE69E41E524EB7FCDC62A15D68D803130403@domain.hid>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D803130403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: thomas.debes@domain.hid
Cc: xenomai@xenomai.org, wg@domain.hid

thomas.debes@domain.hid wrote:
> Hello Wolfgang,
>=20
> Please ignore my previous post. The build command line I used was:
>=20
> ${CROSS_COMPILE}gcc fetest.c -o fetest -I/opt/eldk/xenomai/include -D_G=
NU_SOURCE -lm -L/opt/eldk/xenomai/lib -lnative
>=20
> CROSS_COMPILE points to ppc_82xx-, Xenomai to 2.3.5/2.4.6, eldk to 3.1.=
1.
>

Do you have CONFIG_XENO_OPT_DEBUG_NUCLEUS enabled in your kconfig, and if=
 so, do
you get any message in your kernel log when running fetest?

> Thanks again for your help!
>=20
> Thomas
>=20
>> -----Urspr=FCngliche Nachricht-----
>> Von: Wolfgang Grandegger [mailto:wg@domain.hid]
>> Gesendet: Mittwoch, 4. M=E4rz 2009 09:57
>> An: Debes, Thomas RAEK3 MRA
>> Cc: rpm@xenomai.org; Wildenburg, Roderik RAEK3 MRA; xenomai-
>> help@domain.hid
>> Betreff: Re: AW: [Xenomai-help] Floating Point Exceptions in RT-Tasks
>>
>> Hello Thomas,
>>
>> thomas.debes@domain.hid wrote:
>>> Hello,
>>>
>>> are there any news related to this topic? If ELDK 3.1.1 with kernel
>> 2.4 works on your system there must be something wrong with our
>> configuration...
>>
>> I have not found the time yet to test your example with Linux 2.4.25
>> due
>> to preparations for the EmbeddedWorld fair this week, sorry. How do yo=
u
>> build/make your test program?
>>
>> Wolfgang.
>>
>>> Thomas
>>>
>>> -----Urspr=FCngliche Nachricht-----
>>> Von: xenomai-help-bounces@domain.hid [mailto:xenomai-help-
>> bounces@domain.hid] Im Auftrag von Philippe Gerum
>>> Gesendet: Freitag, 20. Februar 2009 10:36
>>> An: Wildenburg, Roderik RAEK3 MRA
>>> Cc: xenomai@xenomai.org; wg@domain.hid
>>> Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
>>>
>>> roderik.wildenburg@domain.hid wrote:
>>>> On behalf of Thomas I would like to answer your question :
>>>>
>>>> We too use Eldk 3.1.1 with a libc-2.3.1.so (from the Eldk 3.1.1
>> rootfs) and an adeos-ipipe-2.4.25-ppc-DENX-1.2-02.patch.
>>>> We do not use Eldk=B4s rootfs completely, as our system is busybox
>> based, but many parts form it (for example the libraries and bash). Do
>> you know anything else, we have to activate/keep care of to get FPU-
>> exceptions ? From my point of view everything should be configured all
>> right, as we get exceptions when the thread switches to secondary
>> mode!??
>>> Please send your kernel .config file, and the output of the ldd
>> command against
>>> the small fesetenv test we have been trying lately on different
>> setups.
>>> TIA,
>>>
>>>> Dr. Grandegger : could you be so kind to try Thomas=B4 testprogram o=
n
>> our plattfrom with Eldk 3.1.1?
>>>> Many thanks in advance for your help
>>>> Roderik
>>>>
>>>>> -----Urspr=FCngliche Nachricht-----
>>>>> Von: xenomai-help-bounces@domain.hid
>>>>> [mailto:xenomai-help-bounces@domain.hid] Im Auftrag von Philippe Gerum
>>>>> Gesendet: Donnerstag, 19. Februar 2009 16:20
>>>>> An: Debes, Thomas RAEK3 MRA
>>>>> Cc: xenomai@xenomai.org
>>>>> Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
>>>>>
>>>>> Philippe Gerum wrote:
>>>>>> thomas.debes@domain.hid wrote:
>>>>>>> Thanks for testing it - that is exactly what I would like
>>>>> to see. Obviously it's a kernel/I-Pipe related thing which
>>>>> prevents me from getting the exception. Unfortunately
>>>>> updating to kernel 2.6 is not an option for now.
>>>>>> I'm afraid this is not I-pipe related, this would have been
>>>>> too easy. The test
>>>>>> snippet works fine here as well on a lite5200 +
>>>>> ipipe-2.4.25-1.2-02, ELDK-4.1
>>>>>> environment.
>>>>>>
>>>>>> Now we should suspect something going on with your target
>>>>> environment; which
>>>>>> libc are you based on?
>>>>>>
>>>>> Works fine with ELDK-3.1.1 rootfs as well.
>>>>>
>>>>>>> Thomas
>>>>>>>
>>>>>>> -----Urspr=FCngliche Nachricht-----
>>>>>>> Von: Wolfgang Grandegger [mailto:wg@domain.hid]
>>>>>>> Gesendet: Mittwoch, 18. Februar 2009 19:59
>>>>>>> An: Debes, Thomas RAEK3 MRA
>>>>>>> Cc: xenomai@xenomai.org; Gilles Chanteperdrix
>>>>>>> Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
>>>>>>>
>>>>>>> Wolfgang Grandegger wrote:
>>>>>>>> thomas.debes@domain.hid wrote:
>>>>>>>>> Unfortunately I don't have a newer kernel, I will talk
>>>>> to Wolfgang Grandegger, maybe he can do a short test with my
>>>>> formerly attached sample application.
>>>>>>>> I will try it out on my TQM5200 board later today or tomorrow.
>>>>>>> With I-Pipe v2.4-03, Xenomai v2.5-devel (SVN revision
>>>>> 4519) and Linux
>>>>>>> 2.6.26 on my TQM85200 I get:
>>>>>>>
>>>>>>>   -bash-3.2# ./fpu-exception-test
>>>>>>>   Floating point exception
>>>>>>>
>>>>>>>   -bash-3.2# dmesg|tail
>>>>>>>   ...
>>>>>>>   Xenomai: Switching trivial to secondary mode after
>>>>>>>   exception #1792 from user-space at 0x10001840 (pid 1127)
>>>>>>>
>>>>>>> Is that the expected behavior?
>>>>>>>
>>>>>>> Wolfgang.
>>>>>>>
>>>>>>> --------------------------------------------------------
>>>>>>> manroland AG
>>>>>>> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
>>>>>>> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch,
>>>>> Dr. Markus Rall, Paul Steidle
>>>>>>> Sitz der Gesellschaft: Offenbach am Main, Registergericht:
>>>>> Amtsgericht Offenbach HRB-Nr. 42592
>>>>>>> USt-Ident-Nr. DE 250200933
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Xenomai-help mailing list
>>>>>>> Xenomai-help@domain.hid
>>>>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>>>>
>>>>> --
>>>>> Philippe.
>>>>>
>>>>> _______________________________________________
>>>>> Xenomai-help mailing list
>>>>> Xenomai-help@domain.hid
>>>>> https://mail.gna.org/listinfo/xenomai-help
>>>>>
>>>> --------------------------------------------------------
>>>> manroland AG
>>>> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
>>>> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus
>> Rall, Paul Steidle
>>>> Sitz der Gesellschaft: Offenbach am Main, Registergericht:
>> Amtsgericht Offenbach HRB-Nr. 42592
>>>> USt-Ident-Nr. DE 250200933
>>>>
>>>
>>
>> --
>> Dr. Wolfgang Grandegger, Phone: (+49)-8142-6698930, Email: wg@domain.hid
>> _____________________________________________________________________
>> DENX Software Engineering GmbH,    CEO: Wolfgang Denk & Detlev Zundel
>> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
>=20


--=20
Philippe.

