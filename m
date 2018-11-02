Date: Fri, 2 Nov 2018 11:07:50 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: [I-PIPE] ipipe-core-4.14.71-x86-1 released
Message-ID: <20181102110750.24650a70@md1za8fc.ad001.siemens.net>
In-Reply-To: <33f0bc4d-f8ef-9950-74ac-8b62bca6f015@xenomai.org>
References: <20181101175938.D29167FB@centrum.cz>
 <33f0bc4d-f8ef-9950-74ac-8b62bca6f015@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Petr =?UTF-8?B?xIxlcnZlbmth?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

Am Thu, 1 Nov 2018 18:38:47 +0100
schrieb Philippe Gerum <rpm@xenomai.org>:

> On 11/1/18 5:59 PM, Petr =C4=8Cervenka wrote:
> > Hello.
> > =C2=A0
> > Is it really finished?
> > I have problems to compile the patched kernel.
> > =C2=A0
> > At first, when it compiles machine.c, there is such error:
> > =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arch/x86/xenomai/machine.o
> > In file included from ./include/asm-generic/xenomai/syscall.h:23:0,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from
> > arch/x86/xenomai/include/asm/xenomai/syscall.h:24, from
> > arch/x86/xenomai/machine.c:22: ./arch/x86/include/asm/uaccess.h: In
> > function =E2=80=98set_fs=E2=80=99: ./arch/x86/include/asm/uaccess.h:33:=
9: error:
> > dereferencing pointer to incomplete type =E2=80=98struct task_struct=E2=
=80=99
> > current->thread.addr_limit =3D fs; ^~
> > =C2=A0
> > After an ad-hoc fix, there are some other errors for example during
> > compiling of thread.c, mostly connected to fpu: fpu.fpregs_active,
> > fpu.active_state, __fpregs_deactivate(), __fpregs_activate(),
> > clts(), stts(), SLAB_NOTRACK, ... Am I doing something wrong?
> > =C2=A0 =20
>=20
> You are likely not using the proper Xenomai branch, you need -next.

I would not suggest next, master and stable/v3.0.x should do. But
v3.0.7 and older will not work.

As far as i understood we will soon have a v3.1, for people that like
their releases ;).

Henning

