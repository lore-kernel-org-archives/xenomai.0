MIME-Version: 1.0
From: Fangsuo Wu <tiger20081015@gmail.com>
Date: Fri, 30 Apr 2021 18:25:23 +0800
Message-ID: <CAMDn9+QDJR1+2XErEeyaOGoBPUnKrKCi2_zA6gvpAfK08DyW3Q@mail.gmail.com>
Subject: How to solve "implicit declaration of function '__ipipe_tsc_register'"
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi, I'm a beginner of xenomai. After I applied
the ipipe-core-4.19.55-arm-5.patch to my 4.19 linux kernel, I found the
below compiling error:




*/home/data/asr_code/nest/linux/drivers/clocksource/arm_arch_timer.c:1094:2=
:
error: implicit declaration of function '__ipipe_tsc_register'; did you
mean 'ipipe_timer_register'? [-Werror=3Dimplicit-function-declaration]
__ipipe_tsc_register(&tsc_info);  ^~~~~~~~~~~~~~~~~~~~
ipipe_timer_register*

Checked the patch, it seems the CONFIG_IPIPE_ARM_KUSER_TSC is not set in my
config. But in the kernel menu config,  CONFIG_IPIPE_ARM_KUSER_TSC is
defaulty n since the platform I used doesn't belong to ARCH_SOCFPGA or
ARCH_STI or ARCH_DAVINCI_DA850 or MACH_SUN8I. How can I solve this problem?
Thanks!

 Symbol: IPIPE_ARM_KUSER_TSC [=3Dn]

                                             =E2=94=82
  =E2=94=82 Type  : bool

                                                 =E2=94=82
  =E2=94=82   Defined at arch/arm/Kconfig:924

                                                =E2=94=82
  =E2=94=82   Depends on: IPIPE [=3Dy]

                                                 =E2=94=82
  =E2=94=82   Selects: HAVE_IPIPE_TRACER_SUPPORT [=3Dn] && GENERIC_TIME_VSY=
SCALL [=3Dy]
&& IPIPE_HAVE_HOSTRT [=3Dn]
                                                =E2=94=82
  =E2=94=82   Selected by [n]:

                                                 =E2=94=82
  =E2=94=82   - ARCH_SOCFPGA [=3Dn] && ARCH_MULTI_V7 [=3Dy] && IPIPE [=3Dy]

                                                =E2=94=82
  =E2=94=82   - ARCH_STI [=3Dn] && ARCH_MULTI_V7 [=3Dy] && IPIPE [=3Dy]

                                                =E2=94=82
  =E2=94=82   - ARCH_DAVINCI_DA850 [=3Dn] && ARCH_DAVINCI [=3Dn] && (!ARCH_=
DAVINCI_DMx
[=3Dn] || AUTO_ZRELADDR [=3Dy] && ARM_PATCH_PHYS_VIRT [=3Dy]) && IPIPE [=3D=
y]
                                                 =E2=94=82
  =E2=94=82   - MACH_SUN8I [=3Dn] && ARCH_SUNXI [=3Dn] && IPIPE [=3Dy]

                                                 =E2=94=82
  =E2=94=82
