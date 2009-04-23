Date: Thu, 23 Apr 2009 15:26:29 +0200 (CEST)
From: btirefort@domain.hid
Message-ID: <1043994168.4085071240493189508.JavaMail.root@domain.hid>
In-Reply-To: <1639429240.4084331240493011744.JavaMail.root@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problem of freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>


>----- Mail Original -----
>De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>=C3=80: btirefort@domain.hid
>Cc: "xenomai-help" <xenomai@xenomai.org>
>Envoy=C3=A9: Jeudi 23 Avril 2009 10h28:31 GMT +01:00 Amsterdam / Berlin / =
Berne / Rome / Stockholm / >Vienne
>Objet: Re: [Xenomai-help] Problem of freeze

> btirefort@domain.hid wrote:
>> Hello
>>=20
>> I'am rookie in xenomai and i have a problem.
>>
>>Here my configuration :
>>
>>Linux base : CentOS v5.3 (with gnome)
>>kernel : linux-2.6.28.7
>><xenomai : 2.4.7
>> processor cpu familly  : 6
>>               type : 14 (Intel Core Duo T2500 2Ghz)
>> memory : 1 GB
>> HDD : SCSI with Adaptec AIC-7892B card
>>=20
>> I have installed xenomai with no problem.
>> All options of ACPI, APM and CPU frequency scaling are disabled.

>This is wrong. You should enable ACPI, and only disable ACPI_PROCESSOR.
>Disabling ACPI is known to cause bugs with Linux on some machines.

>--=20
>=09=09=09=09=09    Gilles.

Thanks for your reply
So now ACPI is enable and ACPI PROCESSOR Disable

I use xenomai with the patch adeos-ipipe-2.6.28.9-x86-2.2-07.patch from the=
 Xenomai git

But i have the same problem :(

I have a question, when I configure the kernel, for the procesor type, can =
i use th right type for me (core 2) or I must use only 6x86MX type ?


Benoit

