Message-ID: <57B41CA5.5040103@allwinnertech.com>
Date: Wed, 17 Aug 2016 16:13:25 +0800
From: xielinfei <xielinfei@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] [help] porting I-pipe patch on linux-3.4 ARM(cortex-a7)
	soc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Philippe,

      I try to port Xenomai-2.6.2 to ARM (cortex-a7) soc, Using:
      Linux version: linux-3.4.39
      I-pipe patch:  ipipe-core-3.4.6-arm-4.patch
      Hardware: ARM (cortex-a7) single CPU
      Following the guild: Porting Xenomai dual kernel to a new ARM SoC - X=
enomai<https://www.google.com.hk/url?sa=3Dt&rct=3Dj&q=3D&esrc=3Ds&source=3D=
web&cd=3D2&cad=3Drja&uact=3D8&ved=3D0ahUKEwiC5a-r8cfOAhWJRI8KHatQC_cQFggmMA=
E&url=3Dhttps%3A%2F%2Fxenomai.org%2F2014%2F09%2Fporting-xenomai-dual-kernel=
-to-a-new-arm-soc%2F&usg=3DAFQjCNF7_SLahZ2bEmhJokUuxzy44eH10A&sig2=3DzgLgf_=
uma3eALRUl5S9v3A&bvm=3Dbv.129759880,d.dGo>

      For I-pipe patch, I modified <ipipe_tsc.c> and <ipipe_tsc_asm.S> to a=
dd support for "IPIPE_TSC_TYPE_FREERUNNING_ARCH"
       (I have successfully running on linux-3.10 on the same ARM soc)

      After integrate I-pipe patch(without Xenomai), the kernel running for=
 a while then halt, "__ipipe_tsc_update()" not update any more.
      I trace the code, the timer IRQ is always got by the gic controller, =
but ipipe not dispatch. the call trace is :
      __ipipe_grab_irq()--> __ipipe_dispatch_irq() --> __ipipe_sync_pipelin=
e()

     static inline void __ipipe_sync_pipeline(struct ipipe_domain *top, uns=
igned int irq)
     {
               if (__ipipe_current_domain !=3D top) {
                   __ipipe_do_sync_pipeline(top);
                   return;
              }
              if (!test_bit(IPIPE_STALL_FLAG, &ipipe_this_cpu_context(top)-=
>status)){
                  __ipipe_sync_stage();
              }
     }

     While halt,  the __ipipe_sync_pipeline will do nothing, if I hack it, =
force it calling "__ipipe_sync_stage"
     the kernel can goes on, but this should not be the solution.
     I don't know who set the IPIPE_STALL_FLAG, for I trace the code  it se=
ems to be ok,
     ----------------------------------------------------------------------=
---------------------
     fun:ipipe_unstall_root,clear
     fun:__ipipe_dispatch_irq, line=3D1279, control=3D1, name =3DLinux
     fun:__ipipe_dispatch_irq, line=3D1285
     fun:__ipipe_spin_lock_irqsave,test and set
     fun:__ipipe_spin_unlock_irqrestore,clear
     fun:__ipipe_dispatch_irq, line=3D1319
     fun:__ipipe_spin_lock_irqsave,test and set
     fun:ipipe_unstall_root,clear
     fun:ipipe_unstall_root,clear
     fun:ipipe_unstall_root,clear
     fun:__ipipe_dispatch_irq, line=3D1279, control=3D1, name =3DLinux
     fun:__ipipe_dispatch_irq, line=3D1285
     fun:__ipipe_spin_lock_irqsave,test and set
     fun:__ipipe_spin_unlock_irqrestore,clear
     fun:__ipipe_dispatch_irq, line=3D1319
     fun:__ipipe_spin_lock_irqsave,test and set
     fun:ipipe_unstall_root,clear
     fun:ipipe_unstall_root,clear
     fun:ipipe_unstall_root,clear
    -----------------------------------------------------------------------=
-------------------

    Looking forward to get some suggestion!   thank you!










NOTICE: This e-mail and any included attachments are intended only for the =
sole use of named and intended recipient (s) only. If you are the named and=
 intended recipient, please note that the information contained in this ema=
il and its embedded files are confidential and privileged. If you are neith=
er the intended nor named recipient, you are hereby notified that any unaut=
horized review, use, disclosure, dissemination, distribution, or copying of=
 this communication, or any of its contents, is strictly prohibited. Please=
 reply to the sender and destroy the original message and all your records =
of this message (whether electronic or otherwise). Furthermore, you should =
not disclose to any other person, use, copy or disseminate the contents of =
this e-mail and/or the documents accompanying it.
