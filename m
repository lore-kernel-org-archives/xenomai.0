Date: Tue, 20 Mar 2012 17:20:00 -0400
From: Glen Wernersbach <glen@domain.hid>
Message-ID: <CB8E6CC0.1EE6B%glen@domain.hid>
In-Reply-To: <4F68EA11.30109@domain.hid>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

I know that there are some compile bugs if you turn off
CONFIG_XENO_OPT_PERVASIVE.

What is the downside to running without it?



On 3/20/12 4:35 PM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

> On 03/20/2012 09:19 PM, Glen Wernersbach wrote:
>> I actually think in is in the settings because if run just the setup par=
t of
>> the code without reading and writing, on the kernel that works my activi=
ty
>> LED turns off.=20
>>=20
>> On the xeno kernel the LED never changes.
>=20
> I actually think that CONFIG_XENO_OPT_PERVASIVE does not make any
> difference which could cause a difference of hardware behaviour. So, it
> must be another option triggered by this config change. So, if you want
> us to help you, please post the .configs.
>=20

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




