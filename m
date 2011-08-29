Message-ID: <4E5B8489.5080000@domain.hid>
Date: Mon, 29 Aug 2011 14:22:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHoMn5qyUPgGBk+gKQsLweYb1UixJKVk6si9P4YLiOAstL_2XQ@mail.gmail.com>	<4E5B76E2.1090803@domain.hid>
	<CAHoMn5oX=cJ080BEbC9DCYN4rreTE5+m=Lh=N80Xi4qsiZFfbg@domain.hid>
In-Reply-To: <CAHoMn5oX=cJ080BEbC9DCYN4rreTE5+m=Lh=N80Xi4qsiZFfbg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] how to use rt_io_get_region function on
 AT91SAM9263 in user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: yi zheng <yizheng23@domain.hid>
Cc: xenomai@xenomai.org

On 08/29/2011 02:09 PM, yi zheng wrote:
>>
>>>>    Hi,all
>>>>      I want to write a Xenomai application running in user space tha=
t
>> can
>>>> access the
>>>> GPIO pins of my AT91SAM9263 ARM. To get the memory
>>>> region I found the function rt_misc_get_io_region(). Unfortunately
>>>> there is no discription of this function in the API documentation.
>>>> Does this function work like request_mem_region()?
>>
>>> Yes, it allows user-space access to request_mem_region. So, in additi=
on
>>> to this, you should do the usual mmap(/dev/mem) dance. However, it is=

>>> you get mutual exclusion between>probably better to write an RTDM dri=
ver
>> using linux gpiolib. This way,
>=20
>> linux and xenomai.
>=20
>    Do you mean I just access io memory like standard linux with followi=
ng
> steps:
>    fd =3D open("/dev/mem", O_RDWR | O_SYNC)) =3D=3D -1);
>     map_base =3D mmap((void *)target, nSize, PROT_READ | PROT_WRITE,
> MAP_SHARED,fd, target)
>    or there is something wrong with my understanding.If this is not the=

> correct way please give me a simple example=EF=BC=8Cthank you.

For an example of /dev/mem usage, see devmem2.c sources. For instance her=
e:
http://www.mail-archive.com/busybox@domain.hid

We do not have an example of rt_misc_get_io_region() available.

--=20
					    Gilles.


