MIME-Version: 1.0
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Wed, 29 Jul 2015 10:49:44 +0200
Message-ID: <CA+CJOCzk4p0RmpCsYoCQ71Tbckb5Ztj88ORnD2i-sU2jTg115Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Task killed by watchdog after exception #7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everybody,

I am running a real-time application using the VxWorks skin, on a Raspberry
Pi 1, with Xenomai 2.6.4. The application also makes use of the native API
to spawn an additional and periodic task. I have witnessed that, at random,
the product will stop working. Taking a look at the syslog indicates that
one of the VxWorks tasks (here CDL, but not always the same) gets killed by
the watchdog shortly after having been switched to second mode.

Jul 27 09:09:26 raspberrypi kernel: [ 1600.407883] Xenomai: Switching CDL
> to secondary mode after exception #7 from user-space at 0x37d1b0 (pid 253=
9)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.135965] Xenomai: watchdog
> triggered -- signaling runaway thread 'CDL'
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136007] ------------[ cut here
> ]------------
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136067] WARNING: at
> /home/essilor/linux-3.8.13-xenomai-2.6.4/rpi-linux/arch/arm/include/asm/x=
enomai/bits/shadow.h:287
> xnshadow_call_mayday+0x3c/0x70()
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136082] Modules linked in:
> nls_iso8859_1 bcm2835_spi_rtdm(O) vfat fat spi_bcm2708
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136165] [<c0013460>]
> (unwind_backtrace+0x0/0xe0) from [<c001e7dc>]
> (warn_slowpath_common+0x4c/0x64)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136199] [<c001e7dc>]
> (warn_slowpath_common+0x4c/0x64) from [<c001e80c>]
> (warn_slowpath_null+0x18/0x1c)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136236] [<c001e80c>]
> (warn_slowpath_null+0x18/0x1c) from [<c00a5c58>]
> (xnshadow_call_mayday+0x3c/0x70)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136272] [<c00a5c58>]
> (xnshadow_call_mayday+0x3c/0x70) from [<c009fd78>]
> (xnsched_watchdog_handler+0x84/0xbc)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136306] [<c009fd78>]
> (xnsched_watchdog_handler+0x84/0xbc) from [<c009b2c0>]
> (xntimer_tick_aperiodic+0x534/0xcb0)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136338] [<c009b2c0>]
> (xntimer_tick_aperiodic+0x534/0xcb0) from [<c0077140>]
> (xnintr_clock_handler+0xbc/0x234)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136384] [<c0077140>]
> (xnintr_clock_handler+0xbc/0x234) from [<c006ebac>]
> (__ipipe_dispatch_irq+0x1bc/0x2b0)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136419] [<c006ebac>]
> (__ipipe_dispatch_irq+0x1bc/0x2b0) from [<c00083ec>]
> (__ipipe_grab_irq+0x74/0x90)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136456] [<c00083ec>]
> (__ipipe_grab_irq+0x74/0x90) from [<c000d9f4>] (__irq_svc+0x34/0xc0)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136472] Exception
> stack(0xc781be88 to 0xc781bed0)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136498] be80:
> de204000 de204000 0000000a bf01f270 de204000 0000001e
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136525] bea0: 0000002e 0000002=
e
> de204004 d9f5a428 d9f5a024 c05df5ec 0000000a c781bed0
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136546] bec0: bf01d8f4 bf01d0b=
0
> 80000013 ffffffff
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136622] [<c000d9f4>]
> (__irq_svc+0x34/0xc0) from [<bf01d0b0>] (bcm2835_peri_read+0x4/0x44
> [bcm2835_spi_rtdm])
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136683] [<bf01d0b0>]
> (bcm2835_peri_read+0x4/0x44 [bcm2835_spi_rtdm]) from [<d9f5a000>]
> (0xd9f5a000)
> Jul 27 09:09:35 raspberrypi kernel: [ 1605.136700] ---[ end trace
> 47d8a025dda11533 ]---
> Jul 27 09:09:35 raspberrypi kernel: [ 1609.135972] Xenomai: watchdog
> triggered -- killing runaway thread 'CDL'


Doing a symbol search on the address 0x37d1b0 points to the following
function, and in particular, to the vmov instruction.

1047      void attenteEnMs(tU16 dureeEnMs) {

          attenteEnMs:
> 0037d188:   push {r11, lr}
> 0037d18c:   add r11, sp, #4
> 0037d190:   sub sp, sp, #16
> 0037d194:   mov r3, r0
> 0037d198:   strh r3, [r11, #-14]
> 1050       rqTrace("****  attenteEnMs =3D %d *****", dureeEnMs);
> 0037d19c:   ldrh r3, [r11, #-14]
> 0037d1a0:   ldr r0, [pc, #64]       ; 0x37d1e8 <attenteEnMs+96>
> 0037d1a4:   mov r1, r3
> 0037d1a8:   bl 0x448938 <rqTrace>
> 1052       nbDeTick =3D (tU16) (dureeEnMs / VALEUR_1_TICK_EN_MS);
> 0037d1ac:   ldrh r3, [r11, #-14]
> 0037d1b0:   vmov s15, r3
> 0037d1b4:   vcvt.f64.s32 d6, s15
> 0037d1b8:   vldr d7, [pc, #32]      ; 0x37d1e0 <attenteEnMs+88>
> 0037d1bc:   vdiv.f64 d7, d6, d7
> 0037d1c0:   vcvt.u32.f64 s13, d7
> 0037d1c4:   vmov r3, s13
> 0037d1c8:   strh r3, [r11, #-6]
> 1054       taskDelay(nbDeTick);
> 0037d1cc:   ldrh r3, [r11, #-6]
> 0037d1d0:   mov r0, r3
> 0037d1d4:   bl 0x79b190 <taskDelay>
> 1055      }


Is the hard-float operation the reason why the task gets switched to
secondary mode ? And if so, why wouldn't I be able to make use of the FPU
in primary mode ? Would I be right to assume that, when the task gets
switched to secondary mode, and because the other tasks are already
requiring a lot of cpu time, there is not enough free cpu time to run the
newly switched task which gets then killed by the watchdog ? Below is the
list of the spawned tasks with there respective priorities.

CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>   0  0      idle    -1      -         master     R          ROOT
>   0  3537   rt       1(255) 64t       vxworks    w          TRC
>   0  3538   rt      76(180) 0t        vxworks    W          TIM
>   0  3539   rt      21(235) 0t        vxworks    W          TMS
>   0  3540   rt       6(250) 2434t     vxworks    D          CHK
>   0  3541   rt      66(190) 0t        vxworks    W          SUG
>   0  3542   rt      36(220) 0t        vxworks    W          CBQ
>   0  3543   rt      31(225) 0t        vxworks    W          AQI
>   0  3544   rt      36(220) 0t        vxworks    W          IMP
>   0  3545   rt      41(215) 0t        vxworks    W          MOT
>   0  3546   rt      81(175) 0t        vxworks    W          ASV
>   0  3547   rt      46(210) 0t        vxworks    W          SUP
>   0  3548   rt      41(215) 0t        vxworks    W          CDL
>   0  3549   rt      26(230) 0t        vxworks    W          TDL
>   0  3550   rt      51(205) 0t        vxworks    X          IHM
>   0  3551   rt      61(195) 97t       vxworks    D          COM
>   0  3553   rt      21(235) 0t        vxworks    W          SRV
>   0  3554   rt      16(240) 0t        vxworks    W          VNCMAIN
>   0  3605   rt     257(-1)  0t        vxworks    W          wdserver-3532
>   0  3624   rt      99      634us     master     D          ASVISR


Thanks,

Nicolas

--=20


Avant d'imprimer ce document, pensez =C3=A0 l'environnement !

Always think green before printing !

Ce courriel et toutes ses pi=C3=A8ces jointes sont confidentiels et destin=
=C3=A9s=20
exclusivement =C3=A0 l'usage de la personne =C3=A0 laquelle ils sont adress=
=C3=A9s. Si=20
vous n '=C3=AAtes pas le destinataire, nous vous informons que toute=20
utilisation, modification, diffusion, =C3=A9dition ou reproduction (totale =
ou=20
partielle) de ce courriel et/ou de ses pi=C3=A8ces jointes, ou des informat=
ions=20
qu'ils contiennent, sous quelque forme que ce soit, est strictement=20
interdite. Si vous avez re=C3=A7u ce courriel par erreur, merci imm=C3=A9di=
atement=20
d'avertir l'exp=C3=A9diteur et de le supprimer avec ses pi=C3=A8ces jointes=
 ainsi que=20
toute copie, de votre syst=C3=A8me informatique. Nous ne pouvons assurer la=
=20
s=C3=A9curit=C3=A9 des informations transmises par voie =C3=A9lectronique. =
Nous d=C3=A9clinons=20
donc toute responsabilit=C3=A9 dans l'hypoth=C3=A8se ou ce courriel et/ou s=
es pi=C3=A8ces=20
jointes auraient =C3=A9t=C3=A9 notamment modifi=C3=A9s, alt=C3=A9r=C3=A9s e=
t/ou en cas de=20
transmission d'un virus. Par cons=C3=A9quent, en communiquant avec nous vou=
s=20
acceptez ces risques. Nous vous conseillons de v=C3=A9rifier l'absence de v=
irus=20
dans ce courriel et ses pi=C3=A8ces jointes.

This e-mail and its attachments are confidential and intended for use by=20
the above named recipient(s) only. If you are not the intended recipient,=
=20
please note that any use, modification, dissemination, edition or=20
reproduction (either in whole or partially) of this e-mail and/or its=20
attachments, or of the information contained herein, is strictly=20
prohibited. If you have received this e-mail by mistake, please notify the=
=20
sender immediately, and immediately delete this e-mail with its attachments=
=20
and any copy of it from your computer system. We do not ensure the security=
=20
of electronically transmitted information. Therefore, we take no=20
responsibility in the event this email and/or its attachments may have been=
=20
for example modified, altered and/or in the case of transmission of a=20
virus. Your communication with us through such means shall signify your=20
acceptance of such risks. We kindly advise you to check whether this email=
=20
or its attachments are free of viruses.
