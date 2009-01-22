From: "Wayne Call" <wcall@domain.hid>
References: <1231007816-1232652648-cardhu_decombobulator_blackberry.rim.net-1405832660-@domain.hid>
	<4978CA01.1080107@domain.hid>
In-Reply-To: <4978CA01.1080107@domain.hid>
Date: Thu, 22 Jan 2009 13:46:43 -0700
Message-ID: <001501c97cd2$892353e0$9b69fba0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Xenomai-help] xenomai i2c
Reply-To: wcall@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: 'Xenomai help' <xenomai@xenomai.org>

Is it possible to read the /sys/bus/i2c/devices/0-0048/temperature file =
using rt_dev_read?  The application is running in the real time context. =
 Even though the device driver is not in the real time context, can an =
application running in the real time context just simple access the =
/sys/bus/i2c/devices files using rt_dev_read and rt_dev_write?  The /sys =
is where the sysfs has been mounted.

Wayne

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Sent: Thursday, January 22, 2009 12:33 PM
To: wcall@domain.hid
Cc: Xenomai help
Subject: Re: [Xenomai-help] xenomai i2c

wcall@domain.hid wrote:
> Where do I find an example of the RTDM skin?

In the directory ksrc/drivers of xenomai sources.

Please do not forget to cc the mailing list.

--=20
					    Gilles.


