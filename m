MIME-Version: 1.0
In-Reply-To: <1174789692.6462641241525052471.JavaMail.root@domain.hid>
References: <1506907350.6457971241524133549.JavaMail.root@domain.hid>
	<1174789692.6462641241525052471.JavaMail.root@domain.hid>
Date: Thu, 7 May 2009 10:39:52 -0400
Message-ID: <b6ad4ed70905070739w1af00a52h2c19c57dd480ec37@domain.hid>
From: John Yamokoski <yamokosk@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: xenomai-help <xenomai@xenomai.org>

Greetings,

I have the same freezing problem after compiling/installing/running an
adeos patched kernel on an Ubuntu system. Unfortunately to uninstall
gnome-power-manager I must also uninstall 'ubuntu-desktop'.. which I
am not sure I want to do.

Any ideas? Do I need to switch to a different window manager? Is there
some setting with gnome-power-manager I can set that will avoid the
freezing?

I will also query the ubuntu community. If I hear anything back I will
post it here.

J.D.


On Tue, May 5, 2009 at 8:04 AM,  <btirefort@domain.hid> wrote:
> Hello
>
> Sorry for the delay
> I found my problem of freeze, I tell it for information.
>
> My X system (using gnome) is now stable.
> The solution : I have desintalled gnome-power-manager
>
> very thanks for your help
>
> Benoit
>
> ----- Mail Original -----
> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
> =C0: btirefort@domain.hid
> Cc: "Jan Kiszka" <jan.kiszka@domain.hid>, "xenomai-help" <xenomai@xenomai.org=
g>
> Envoy=E9: Jeudi 23 Avril 2009 15h30:31 GMT +01:00 Amsterdam / Berlin / Be=
rne / Rome / Stockholm / Vienne
> Objet: Re: [Xenomai-help] Problem of freeze
>
> btirefort@domain.hid wrote:
>>> ----- Mail Original -----
>>> De: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
>>> =C0: btirefort@domain.hid
>>> Cc: "xenomai-help" <xenomai@xenomai.org>
>>> Envoy=E9: Jeudi 23 Avril 2009 10h28:31 GMT +01:00 Amsterdam / Berlin / =
Berne / Rome / Stockholm / >Vienne
>>> Objet: Re: [Xenomai-help] Problem of freeze
>>
>>> btirefort@domain.hid wrote:
>>>> Hello
>>>>
>>>> I'am rookie in xenomai and i have a problem.
>>>>
>>>> Here my configuration :
>>>>
>>>> Linux base : CentOS v5.3 (with gnome)
>>>> kernel : linux-2.6.28.7
>>>> <xenomai : 2.4.7
>>>> processor cpu familly =A0: 6
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 type : 14 (Intel Core Duo T2500 2Ghz)
>>>> memory : 1 GB
>>>> HDD : SCSI with Adaptec AIC-7892B card
>>>>
>>>> I have installed xenomai with no problem.
>>>> All options of ACPI, APM and CPU frequency scaling are disabled.
>>
>>> This is wrong. You should enable ACPI, and only disable ACPI_PROCESSOR.
>>> Disabling ACPI is known to cause bugs with Linux on some machines.
>>
>>> --
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0Gilles.
>>
>> Thanks for your reply
>> So now ACPI is enable and ACPI PROCESSOR Disable
>>
>> I use xenomai with the patch adeos-ipipe-2.6.28.9-x86-2.2-07.patch from =
the Xenomai git
>>
>> But i have the same problem :(
>>
>> I have a question, when I configure the kernel, for the procesor type, c=
an i use th right type for me (core 2) or I must use only 6x86MX type ?
>
> No you should use the right type for your procsesor.
>
> I see that you are using X-window, so I guess you do not see the
> console. Unfortunately, if your hang is due to a kernel oops we do not
> have a clue. So, you should try and get the console output on another
> machine, using preferably a serial cable, or if not possible the netconso=
le.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 Gilles.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

