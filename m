From: Wayne Warren <wwarren@emacinc.com>
In-Reply-To: <50882782.50003@xenomai.org>
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
	<506B5D6B.80005@xenomai.org> <506B5E0E.5050900@xenomai.org>
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>
	<506F402A.9030102@xenomai.org>
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>
	<506F6283.2040901@xenomai.org>
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>
	<506FFDDC.60104@xenomai.org>
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>
	<50749349.5070900@xenomai.org>
	<1350681759.1282.88.camel@ENG-09-LX.emacinc.com>
	<5081FF74.4010109@xenomai.org>
	<1350933768.17153.16.camel@ENG-09-LX.emacinc.com>
	<50859D99.5040009@xenomai.org>
	<1350934476.17153.20.camel@ENG-09-LX.emacinc.com>
	<5085B6BC.8060906@xenomai.org>
	<1351006344.2975.60.camel@ENG-09-LX.emacinc.com>
	<5086FA29.6010008@xenomai.org>
	<1351099930.25888.286.camel@ENG-09-LX.emacinc.com>
	<50882782.50003@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Oct 2012 12:55:28 -0500
Message-ID: <1351101328.25888.330.camel@ENG-09-LX.emacinc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
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


>=20
> What you need is __ipipe_tsc_register to be called before any call to
> __ipipe_tsc_update.

This breakpoint is definitely hit before the __ipipe_tsc_update
breakpoint:

Breakpoint 8, __ipipe_tsc_register (info=3D0xc0634108) at /home/wayne/src/l=
inux/linux-2.6.37-3517-xenomai/arch/arm/kernel/ipipe_tsc.c:45
45              switch(info->type) {=20
(gdb) bt                                                                   =
                                                          =20
#0  __ipipe_tsc_register (info=3D0xc0634108) at /home/wayne/src/linux/linux=
-2.6.37-3517-xenomai/arch/arm/kernel/ipipe_tsc.c:45         =20
#1  0xc001121c in omap2_gp_timer_init () at /home/wayne/src/linux/linux-2.6=
.37-3517-xenomai/arch/arm/mach-omap2/timer-gp.c:274      =20
#2  0xc000cae4 in time_init () at /home/wayne/src/linux/linux-2.6.37-3517-x=
enomai/arch/arm/kernel/time.c:163                         =20
#3  0xc0008b5c in start_kernel () at /home/wayne/src/linux/linux-2.6.37-351=
7-xenomai/init/main.c:617                         =20
#4  0x80008034 in ?? ()   =20


>=20
> __ipipe_tsc_get is supposed to be defined to be something like 0xffff0f40

   =E2=94=820xc0052ca4 <__ipipe_tsc_update+88>      ldr    r3, [pc, #36]   =
; 0xc0052cd0 <__ipipe_tsc_update+132>
  >=E2=94=820xc0052ca8 <__ipipe_tsc_update+92>      blx    r3              =
                                    =20
   =E2=94=820xc0052cac <__ipipe_tsc_update+96>      ldr    r3, [pc, #24]   =
; 0xc0052ccc <__ipipe_tsc_update+128>   =20

(gdb) info reg r3                                                        =
=20
r3             0xffff0f40       4294905664                               =
=20
(gdb) disassemble 0xffff0f40                                             =
=20
No function contains specified address.                                  =
=20
(gdb) x 0xffff0f40                                                       =
=20
0xffff0f40:     0xe51f000c                                               =
=20
(gdb) focus cmd                                                          =
=20
Focus set to CMD window.                                                 =
=20
(gdb) x /10                                                              =
=20
0xffff0f40:     0xe51f000c      0xe14f22dc      0xe5900000      0xe1520000
0xffff0f50:     0xe2a31000      0xe12fff1e      0xe1a00000      0xe1a00000
0xffff0f60:     0x00000000      0x00000000                                 =
                                                                           =
      =20
(gdb)                       =20

So it looks like maybe __ipipe_tsc_get is working as expected?=20
                     =20
>=20
> Or apply the following patch:
> http://git.xenomai.org/?p=3Dipipe-gch.git;a=3Dcommitdiff;h=3D42dd9056983c=
b6f65b6a336363f2f08f4426625a;hp=3D3b51cebda0b0d0123cb61b6ec07ecb62f293a528

I will try this out, thanks!

Wayne


