Date: Mon, 26 Mar 2012 01:27:18 -0400
From: Glen Wernersbach <glen@domain.hid>
Message-ID: <CB957676.1F007%glen@domain.hid>
In-Reply-To: <4F6986AD.9050201@domain.hid>
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

I figured out the fix. There was a hard coded minor number for a misc devic=
e
register for the GPIO.

For some reason PERVASIVE conflicted with it.

Changed it to dynamic assign ID and it worked fine.

Linux serial now works.


On 3/21/12 3:43 AM, "Gilles Chanteperdrix"
<gilles.chanteperdrix@xenomai.org> wrote:

> On 03/21/2012 05:46 AM, Glen Wernersbach wrote:
>> I am going to start trying to see if I can figure out what is not gettin=
g
>> set.
>>=20
>> By the way. This board also has 4 other serial ports on a 8250.c driver.=
 It
>> also fails under the xeno build.
>=20
> But the serial console works, right? So there is at least on serial port
> working.

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




