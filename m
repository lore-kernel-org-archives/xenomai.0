Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50C8330D.8040305@xenomai.org>
Date: Wed, 12 Dec 2012 09:30:59 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <325B0F26-79FE-4C8B-A41E-10ED40FC0B3B@mah.priv.at>
References: <1491832.238.1355257934434.JavaMail.poli@jacqueline>
	<FE9848C4-D19F-4628-8047-5E67A667A2E9@mah.priv.at>
	<50C8330D.8040305@xenomai.org>
Subject: Re: [Xenomai] RT GPIO with Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


Am 12.12.2012 um 08:32 schrieb Gilles Chanteperdrix:

> On 12/12/2012 07:54 AM, Michael Haberler wrote:
>=20
>> not strictly a Xenomai issue, but I'd completely bypass the kernel
>> GPIO support and manipulate the GPIO registers directly - they are
>> all memory mapped
>>=20
>> some inspiration here:
>> =
http://git.mah.priv.at/gitweb/emc2-dev.git/blob/refs/heads/rtos-integratio=
n-preview1:/src/hal/drivers/hal_gpio.c
>>=20
>> this runs from a userland thread but kernel shouldnt be much
>> different
>=20
>=20
> Yeah, good idea, depending on the way to access registers, you get
> concurrence issues, conflicts between applications, a lot of fun.

just to make sure I understand your suggestion:=20

in kernel mode you'd suggest to go through gpiolib and use =
gpio_get_value/gpio_set_value if possible ?

in user mode you can prepare things through sysfs but I dont see an =
alternative to memory-mapped register manipulation in that case if one =
wants to avoid system calls like read/write/open/ioctl which likely will =
be a dog on top of switching to secondary domain

-m



>=20
> --=20
>                                                                Gilles.


