Message-ID: <4988708D.1060204@domain.hid>
Date: Tue, 03 Feb 2009 17:27:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <271563.65105.qm@domain.hid>
	<4986B44B.3030307@domain.hid>
	<162418.27985.qm@domain.hid>
In-Reply-To: <162418.27985.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Re :  Problem with  rtdm_irq_request
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
To: seb p <sebas_p2002@domain.hid>
Cc: xenomai@xenomai.org

seb p wrote:
> I try with the last version of xenomai but it's the same problem.
>=20
> I send you my code.
>

http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtdm=
irq.html

> Thank you for your help.
>=20
> Seb.
>=20
> -----------------------------------------------------------------------=
-
> *De :* Philippe Gerum <rpm@xenomai.org>
> *=C3=80 :* seb p <sebas_p2002@domain.hid>
> *Cc :* xenomai@xenomai.org
> *Envoy=C3=A9 le :* Lundi, 2 F=C3=A9vrier 2009, 9h52mn 27s
> *Objet :* Re: [Xenomai-help] Problem with rtdm_irq_request
>=20
> seb p wrote:
>> Hello,
>>
>> I use a atmel card AT91SAM9260 and I install Linux 2.6.25 with xenomai
>> 2.4.4. I am doing a RTDM serial driver. I use the function
>> rtdm_irq_request
>>
> <http://www.xenomai.org/documentation/trunk/html/api/group__rtdmirq.htm=
l#g9bb3d95218ac5261e4033fb0bf695073>
>> with the routine rt_rs485_interrupt. The interrupt number is 7. The
>> interrupt is enable when a carracter is in the buffer Rx and the
>> programm execute the routine rt_rs485_interrupt. But in my programm,
>> when a caracter is in the buffer Rx, the programm doesn't execute the
>> routine and I must reboot the linux. The console don't answer.
>>
>> Have you got an idea of the problem? Thanks.
>>
>=20
> Time is a scarce resource for everyone. With that in mind, please:
>=20
> - do not report issues based on outdated Xenomai releases unless you
> made sure
> that such issue also happens on the latest release. Xenomai 2.4.6.1 wil=
l
> happily
> work over 2.6.25/arm.
>=20
> - send an excerpt of your code that helps understanding the issue.
>=20
>> S=C3=A9b.
>>
>>
>> ----------------------------------------------------------------------=
--
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid <mailto:Xenomai-help@domain.hid>
>> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
> --=20
> Philippe.
>=20


--=20
Philippe.

