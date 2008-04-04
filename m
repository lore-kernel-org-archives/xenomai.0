Message-ID: <47F5FEFA.6030102@domain.hid>
Date: Fri, 04 Apr 2008 12:12:10 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <47F5FC80.3060603@domain.hid>
In-Reply-To: <47F5FC80.3060603@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] problem with trivial-periodic.c example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Thomas_H=E4berle?= <thomas.haeberle@domain.hid>
Cc: xenomai@xenomai.org

Thomas H=E4berle wrote:
> Hello!
>=20
> I am running Xenomai 2.3.5 on my MPC5200S on a STK52xx with a Linux=20
> 2.4.25-DENX kernel (cross-compiling to the target).
>=20
> When I try to compile the "trivial-periodic.c" example with
>  >>> $ ppc_6xx-gcc SimpleTask.c -I $XENOINSTALL/include -L=20
> $XENOINSTALL/lib -o SimpleTask -Wall
>=20
> I get the following:
>  >>>
> /tmp/ccwxJiOz.o(.text+0x30): In function `demo':
> : undefined reference to `rt_task_set_periodic'
> /tmp/ccwxJiOz.o(.text+0x34): In function `demo':
> : undefined reference to `rt_timer_read'
> /tmp/ccwxJiOz.o(.text+0x4c): In function `demo':
> : undefined reference to `rt_task_wait_period'
> /tmp/ccwxJiOz.o(.text+0x50): In function `demo':
> : undefined reference to `rt_timer_read'
> /tmp/ccwxJiOz.o(.text+0x160): In function `main':
> : undefined reference to `rt_task_create'
> /tmp/ccwxJiOz.o(.text+0x178): In function `main':
> : undefined reference to `rt_task_start'
> /tmp/ccwxJiOz.o(.text+0x188): In function `main':
> : undefined reference to `rt_task_delete'
> collect2: ld returned 1 exit status
> <<<
>=20
> Aren't the functions used in the example in the libraries in the=20
> "$XENOINSTALL/lib" directory?
> Or do I have to tell the compiler and/or linker about any of the Xenomai =

> source paths to get this working?

Please use the Makefile in that directory to learn how to build it. You
may need to define DESTDIR as well.

Wolfgang.

