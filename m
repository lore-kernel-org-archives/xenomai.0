Date: Tue, 20 Mar 2012 10:59:13 -0400
From: Glen Wernersbach <glen@domain.hid>
Message-ID: <CB8E1381.1EE32%glen@domain.hid>
In-Reply-To: <4F68993E.5030503@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Content-transfer-encoding: quoted-printable
Subject: Re: [Xenomai-help] Linux Serial Does not work with
 CONFIG_XENO_OPT_PERVASIVE enabled
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

As far as I can tell, no kernel messages what so ever.



On 3/20/12 10:50 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

> On 03/20/2012 02:28 PM, Glen Wernersbach wrote:
>> Hi All,
>>=20
>> I install Xenomai 2.6.0 on AT91SAM9G20 system and have found that when
>> CONFIG_XENO_OPT_PERVASIVE is enabled my standard non real time linux ser=
ial
>> write then read serial program does not work.
>>=20
>> If I turn off CONFIG_XENO_OPT_PERVASIVE, my serial program does work.
>=20
> Do you get a message on the kernel console about characters lost on
> serial device? These seems to be more frequent when the interrupt
> pipeline delays the interrupt than without the interrupt pipeline, but
> always exists.

--=20
Glen Wernersbach
President & CTO

Jetsoft Development Co.
629 Old St Rt. 74 =AD Suite 210
Cincinnati, Oh 45244
Custom Programming Web Site: www.jetsoftdev.com
Retail Products Web Site: www.scanhelp.com
Phone:   513-528-6660
Fax: 513-528-3470
Cell 513-240-9929
----
Partner for Software Technology
Jacobs Automation
2365 Progress Drive
Hebron, KY 41048=20
(513) 297-7550
----
"Support Dyslexia Research"




