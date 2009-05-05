Date: Tue, 5 May 2009 14:04:12 +0200 (CEST)
From: btirefort@domain.hid
Message-ID: <1174789692.6462641241525052471.JavaMail.root@domain.hid>
In-Reply-To: <1506907350.6457971241524133549.JavaMail.root@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-help <xenomai@xenomai.org>

Hello

Sorry for the delay
I found my problem of freeze, I tell it for information.

My X system (using gnome) is now stable.
The solution : I have desintalled gnome-power-manager

very thanks for your help

Benoit

----- Mail Original -----
De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
=C3=80: btirefort@domain.hid
Cc: "Jan Kiszka" <jan.kiszka@domain.hid>, "xenomai-help" <xenomai@xenomai.org>
Envoy=C3=A9: Jeudi 23 Avril 2009 15h30:31 GMT +01:00 Amsterdam / Berlin / B=
erne / Rome / Stockholm / Vienne
Objet: Re: [Xenomai-help] Problem of freeze

btirefort@domain.hid wrote:
>> ----- Mail Original -----
>> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>> =C3=80: btirefort@domain.hid
>> Cc: "xenomai-help" <xenomai@xenomai.org>
>> Envoy=C3=A9: Jeudi 23 Avril 2009 10h28:31 GMT +01:00 Amsterdam / Berlin =
/ Berne / Rome / Stockholm / >Vienne
>> Objet: Re: [Xenomai-help] Problem of freeze
>=20
>> btirefort@domain.hid wrote:
>>> Hello
>>>
>>> I'am rookie in xenomai and i have a problem.
>>>
>>> Here my configuration :
>>>
>>> Linux base : CentOS v5.3 (with gnome)
>>> kernel : linux-2.6.28.7
>>> <xenomai : 2.4.7
>>> processor cpu familly  : 6
>>>               type : 14 (Intel Core Duo T2500 2Ghz)
>>> memory : 1 GB
>>> HDD : SCSI with Adaptec AIC-7892B card
>>>
>>> I have installed xenomai with no problem.
>>> All options of ACPI, APM and CPU frequency scaling are disabled.
>=20
>> This is wrong. You should enable ACPI, and only disable ACPI_PROCESSOR.
>> Disabling ACPI is known to cause bugs with Linux on some machines.
>=20
>> --=20
>> =09=09=09=09=09    Gilles.
>=20
> Thanks for your reply
> So now ACPI is enable and ACPI PROCESSOR Disable
>=20
> I use xenomai with the patch adeos-ipipe-2.6.28.9-x86-2.2-07.patch from t=
he Xenomai git
>=20
> But i have the same problem :(
>=20
> I have a question, when I configure the kernel, for the procesor type, ca=
n i use th right type for me (core 2) or I must use only 6x86MX type ?

No you should use the right type for your procsesor.

I see that you are using X-window, so I guess you do not see the
console. Unfortunately, if your hang is due to a kernel oops we do not
have a clue. So, you should try and get the console output on another
machine, using preferably a serial cable, or if not possible the netconsole=
.

--=20
                                                 Gilles.


