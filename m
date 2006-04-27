Message-ID: <4450DB97.9010708@domain.hid>
Date: Thu, 27 Apr 2006 16:56:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] IRQ1 forwarded to Linux?
References: <1146143577.3671.3.camel@domain.hid>
	<1146149090.2938.33.camel@domain.hid>
In-Reply-To: <1146149090.2938.33.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Guillaume Boutillier <guillaume.boutillier@domain.hid>
Cc: xenomai@xenomai.org

Guillaume Boutillier wrote:
> Hello,
>=20
>=20
>>>ROSSIER Daniel wrote:
>>>
>>>>Hello,
>>>>
>>>>=20
>>>>
>>>>We have a small Xeno application which implements an interrupt servic=
e=20
>>>>(ISR) on IRQ 1 (keyboard) =E2=80=93 quite stupid, but
>>>>
>>>
>>>Sorry,
>>>
>>>- $ cat /proc/ipipe/Linux
>>>+ $ cat /proc/ipipe/Xenomai
>=20
>=20
> I checked when I run my application...=20
> But I couldn't understand the meaning of the different flags : accepted=
,
> passed and grabbed?!=20
>=20

What about posting the output to this list? Maybe someone could help.

>=20
>>>when your test is loaded would be useful to understand why Linux still=
=20
>>>gets the kbd IRQs.
>>>
>>>
>>>>just for testing. If we understand well, returning from the ISR with=20
>>>>RET_INTR_HANDLED should not propagate the
>>>>
>>>>IRQ to the other domains, therefore to the Linux one, right?
>>>>
>>>>Why can we then keep working with the shell? (I expect that we can no=
t=20
>>>>interact with the shell, even not see the echoed char.).
>>>>
>>>>=20
>>>>
>>>>Does Xenomai patch the keyb driver?
>>>>
>>>
>>>No.
>>>
>>>
>>>>=20
>>>>
>>>>(We've seen that on /proc/xenomai/irq, we get the IRQ1 count, but NOT=
 on=20
>>>>the /proc/interrupts, as expected).
>>>>
>>>>=20
>>>>
>>>>Thanks for your help
>>>>
>>>>=20
>>>>
>>>>Daniel
>>>>
>>>>
>>>>---------------------------------------------------------------------=
---
>>>>
>>>>_______________________________________________
>>>>Xenomai-help mailing list
>>>>Xenomai-help@domain.hid
>>>>https://mail.gna.org/listinfo/xenomai-help
>>>
>>>
> Thanks for your help
>=20
> Guillaume Boutillier
>=20
>=20
>>pi=C3=A8ce jointe message de courriel, "Message transf=C3=A9r=C3=A9 - R=
e:
>>[Xenomai-help] IRQ1 forwarded to Linux?"
>>Le jeudi 27 avril 2006 =C3=A0 15:12 +0200, S=C3=A9bastien Gerber a =C3=A9=
crit :
>>
>>>ROSSIER Daniel wrote:
>>>
>>>>Hello,
>>>>
>>>>=20
>>>>
>>>>We have a small Xeno application which implements an interrupt servic=
e=20
>>>>(ISR) on IRQ 1 (keyboard) =E2=80=93 quite stupid, but
>>>>
>>>
>>>What does the following say?
>>>$ cat /proc/ipipe/Linux
>>>
>>>
>>>>just for testing. If we understand well, returning from the ISR with=20
>>>>RET_INTR_HANDLED should not propagate the
>>>>
>>>>IRQ to the other domains, therefore to the Linux one, right?
>>>>
>>>>Why can we then keep working with the shell? (I expect that we can no=
t=20
>>>>interact with the shell, even not see the echoed char.).
>>>>
>>>>=20
>>>>
>>>>Does Xenomai patch the keyb driver?
>>>>
>>>>=20
>>>>
>>>>(We've seen that on /proc/xenomai/irq, we get the IRQ1 count, but NOT=
 on=20
>>>>the /proc/interrupts, as expected).
>>>>
>>>>=20
>>>>
>>>>Thanks for your help
>>>>
>>>>=20
>>>>
>>>>Daniel
>>>>
>>>>
>>>>---------------------------------------------------------------------=
---
>>>>
>>>>_______________________________________________
>>>>Xenomai-help mailing list
>>>>Xenomai-help@domain.hid
>>>>https://mail.gna.org/listinfo/xenomai-help
>>>
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

