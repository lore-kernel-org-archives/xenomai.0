Resent-To: Xenomai help <xenomai@xenomai.org>
Resent-Message-Id: <4C2C41AA.9020502@domain.hid>
Message-ID: <4C2C411F.2090601@domain.hid>
Date: Thu, 01 Jul 2010 09:17:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <22150A2C94CC924695BE248F94CD11F2CD0F@EXDB4.ug.kth.se>	<4C2A518F.8030302@domain.hid>	<22150A2C94CC924695BE248F94CD11F2CDC2@domain.hid>	<4C2B0043.1070108@domain.hid>	<AANLkTikdRdEXJd97HKlWzUmon8bu94n-ATNozWyOmTOu@domain.hid>
	<4C2C3A74.6010608@domain.hid>
In-Reply-To: <4C2C3A74.6010608@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and Gumstix Overo
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
>> All the logs seem normal to me (I-pipe reports normal starup, Xenomai
>> reports successful start). I am starting to think that one of my changes to
>> the kernel might be making the system to fail silently.
> 
> I use Xenomai 2.5.3 on an OMAP3 based board without any problems. So,
> yes, either you are mis-configured (in order to check that, just use
> Xenomai default configuration), or your kernel is broken.

Also, check the EABI settings: if you are running a EABI user-space, you
should pass --enable-arm-eabi to Xenomai user-space configure script.

-- 
					    Gilles.


