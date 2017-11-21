Date: Tue, 21 Nov 2017 09:01:29 +0100
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20171121090129.5cc3e2a6@md1em3qc>
In-Reply-To: <e1bd3510-58dc-7ed2-ac0a-a0010eb43d73@alaxarxa.net>
References: <tencent_2252D90437AFCF6B48706C45@qq.com>
 <e1bd3510-58dc-7ed2-ac0a-a0010eb43d73@alaxarxa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] 3.0.6 with linux 4.9.51 on x86_64 Intel(R) Atom(TM)
 CPU N2800 compilation failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: Jack Lee <jacklee11@foxmail.com>, xenomai <xenomai@xenomai.org>

Am Tue, 21 Nov 2017 08:28:11 +0100
schrieb Leopold Palomo-Avellaneda <leo@alaxarxa.net>:

> On 21/11/17 06:52, Jack Lee wrote:
> > Hello,
> >=20
> >   My board cpu is Intel Atom CPU N2800. I am using xenomai 3.0.6
> > with linux 4.9.51. I get the following error when compiling the
> > kernel. Can anyone give me some help? Thanks!
> >=20
> >   CC      arch/x86/xenomai/machine.o
> > In file included from arch/x86/xenomai/machine.c:22:0:
> > arch/x86/xenomai/include/asm/xenomai/syscall.h: In function
> > =E2=80=98__xn_get_syscall_nr=E2=80=99:
> > arch/x86/xenomai/include/asm/xenomai/syscall.h:46:31: error:
> > implicit declaration of function
> > =E2=80=98__COBALT_CALL32_SYSNR=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
> > #define __xn_syscall(regs)
> > __COBALT_CALL32_SYSNR(__xn_reg_sys(regs) \ ^
> > arch/x86/xenomai/include/asm/xenomai/syscall.h:60:32: note: in
> > expansion of macro =E2=80=98__xn_syscall=E2=80=99 return __xn_syscall_p=
(regs) ?
> > __xn_syscall(regs) : =20
>=20
> I had the same problem yesterday and Philippe Gerum answered:
>=20
> >> As a work around, drop CONFIG_IA32_EMULATION if you don't need
> >> it. =20

There is also a commit on top of 3.0.6 that should solve that problem.
You could try with
http://git.xenomai.org/xenomai-3.git/snapshot/xenomai-3-cc283c7f26c1b097b94=
a61bb25c2564f51daf16d.tar.bz2

Henning

> Best regards,
>=20
> Leopold
>=20


