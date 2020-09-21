Subject: Re: [PATCH 4/4] scripts/prepare-kernel.sh: add $(srctree) to the
 include path of ccflags
References: <20200918063253.8605-1-fino.meng@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <67e4fb79-2ae3-8575-5f8b-fc961caa1b98@siemens.com>
Date: Mon, 21 Sep 2020 08:22:40 +0200
MIME-Version: 1.0
In-Reply-To: <20200918063253.8605-1-fino.meng@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fino Meng <fino.meng@linux.intel.com>, xenomai@xenomai.org, fino.meng@intel.com

On 18.09.20 08:32, Fino Meng wrote:
> Out of tree build will fail after porting xenomai to Linux kernel 5.4.y,
> update Makefiles and scripts to fix it.
> 
> Signed-off-by: Fino Meng <fino.meng@linux.intel.com>
> ---
>   kernel/cobalt/arch/arm/Makefile                         | 2 +-
>   kernel/cobalt/arch/arm64/Makefile                       | 2 +-
>   kernel/cobalt/arch/powerpc/Makefile                     | 2 +-
>   kernel/cobalt/arch/x86/Makefile                         | 2 +-
>   kernel/cobalt/posix/Makefile                            | 2 +-
>   kernel/cobalt/rtdm/Makefile                             | 2 +-
>   kernel/drivers/analogy/Makefile                         | 2 +-
>   kernel/drivers/analogy/intel/Makefile                   | 2 +-
>   kernel/drivers/analogy/national_instruments/Makefile    | 2 +-
>   kernel/drivers/analogy/sensoray/Makefile                | 2 +-
>   kernel/drivers/analogy/testing/Makefile                 | 2 +-
>   kernel/drivers/can/Makefile                             | 2 +-
>   kernel/drivers/can/mscan/Makefile                       | 2 +-
>   kernel/drivers/can/sja1000/Makefile                     | 2 +-
>   kernel/drivers/gpiopwm/Makefile                         | 2 +-
>   kernel/drivers/net/addons/Makefile                      | 2 +-
>   kernel/drivers/net/drivers/Makefile                     | 2 +-
>   kernel/drivers/net/drivers/e1000/Makefile               | 2 +-
>   kernel/drivers/net/drivers/e1000e/Makefile              | 2 +-
>   kernel/drivers/net/drivers/experimental/Makefile        | 2 +-
>   kernel/drivers/net/drivers/experimental/e1000/Makefile  | 2 +-
>   kernel/drivers/net/drivers/experimental/rt2500/Makefile | 2 +-
>   kernel/drivers/net/drivers/igb/Makefile                 | 2 +-
>   kernel/drivers/net/drivers/mpc52xx_fec/Makefile         | 2 +-
>   kernel/drivers/net/drivers/tulip/Makefile               | 2 +-
>   kernel/drivers/net/stack/Makefile                       | 2 +-
>   kernel/drivers/net/stack/ipv4/Makefile                  | 2 +-
>   kernel/drivers/net/stack/ipv4/tcp/Makefile              | 2 +-
>   kernel/drivers/net/stack/ipv4/udp/Makefile              | 2 +-
>   kernel/drivers/net/stack/packet/Makefile                | 2 +-
>   kernel/drivers/net/stack/rtcfg/Makefile                 | 2 +-
>   kernel/drivers/net/stack/rtmac/Makefile                 | 2 +-
>   kernel/drivers/net/stack/rtmac/nomac/Makefile           | 2 +-
>   kernel/drivers/net/stack/rtmac/tdma/Makefile            | 2 +-
>   kernel/drivers/udd/Makefile                             | 2 +-
>   scripts/prepare-kernel.sh                               | 2 +-
>   36 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/kernel/cobalt/arch/arm/Makefile b/kernel/cobalt/arch/arm/Makefile
> index f18243599..295ba614b 100644
> --- a/kernel/cobalt/arch/arm/Makefile
> +++ b/kernel/cobalt/arch/arm/Makefile
> @@ -2,4 +2,4 @@ obj-$(CONFIG_XENOMAI) += xenomai.o
>   
>   xenomai-y := machine.o thread.o switch.o syscall.o
>   
> -ccflags-y := -Iarch/arm/xenomai/include -Iinclude/xenomai
> +ccflags-y := -I$(srctree)/arch/arm/xenomai/include -I$(srctree)/include/xenomai
> diff --git a/kernel/cobalt/arch/arm64/Makefile b/kernel/cobalt/arch/arm64/Makefile
> index 368b17d53..cf12a1801 100644
> --- a/kernel/cobalt/arch/arm64/Makefile
> +++ b/kernel/cobalt/arch/arm64/Makefile
> @@ -2,4 +2,4 @@ obj-$(CONFIG_XENOMAI) += xenomai.o
>   
>   xenomai-y := machine.o thread.o syscall.o
>   
> -ccflags-y := -Iarch/arm64/xenomai/include -Iinclude/xenomai
> +ccflags-y := -I$(srctree)/arch/arm64/xenomai/include -I$(srctree)/include/xenomai
> diff --git a/kernel/cobalt/arch/powerpc/Makefile b/kernel/cobalt/arch/powerpc/Makefile
> index 18147eeac..e175d0a3a 100644
> --- a/kernel/cobalt/arch/powerpc/Makefile
> +++ b/kernel/cobalt/arch/powerpc/Makefile
> @@ -5,4 +5,4 @@ xenomai-y := machine.o thread.o
>   
>   xenomai-$(CONFIG_XENO_ARCH_FPU) += fpu.o
>   
> -ccflags-y := -Iarch/powerpc/xenomai/include -Iinclude/xenomai
> +ccflags-y := -I$(srctree)/arch/powerpc/xenomai/include -I$(srctree)/include/xenomai
> diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
> index d430a6741..1ef407c35 100644
> --- a/kernel/cobalt/arch/x86/Makefile
> +++ b/kernel/cobalt/arch/x86/Makefile
> @@ -2,4 +2,4 @@
>   obj-$(CONFIG_XENOMAI) += xenomai.o
>   xenomai-y := machine.o thread.o smi.o c1e.o
>   
> -ccflags-y := -Iarch/x86/xenomai/include -Iinclude/xenomai
> +ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
> diff --git a/kernel/cobalt/posix/Makefile b/kernel/cobalt/posix/Makefile
> index f194bff70..e941b5011 100644
> --- a/kernel/cobalt/posix/Makefile
> +++ b/kernel/cobalt/posix/Makefile
> @@ -1,5 +1,5 @@
>   
> -ccflags-y += -Ikernel
> +ccflags-y += -I$(srctree)/kernel
>   
>   obj-$(CONFIG_XENOMAI) += xenomai.o
>   
> diff --git a/kernel/cobalt/rtdm/Makefile b/kernel/cobalt/rtdm/Makefile
> index e10568cd9..4f5a6caa7 100644
> --- a/kernel/cobalt/rtdm/Makefile
> +++ b/kernel/cobalt/rtdm/Makefile
> @@ -7,4 +7,4 @@ xenomai-y :=	core.o		\
>   		fd.o		\
>   		wrappers.o
>   
> -ccflags-y += -I$(src)/.. -Ikernel
> +ccflags-y += -I$(srctree)/$(src)/.. -I$(srctree)/kernel
> diff --git a/kernel/drivers/analogy/Makefile b/kernel/drivers/analogy/Makefile
> index a4ca8c1f4..8dcb7e7bb 100644
> --- a/kernel/drivers/analogy/Makefile
> +++ b/kernel/drivers/analogy/Makefile
> @@ -1,5 +1,5 @@
>   
> -ccflags-y += -Idrivers/xenomai/analogy
> +ccflags-y += -I$(srctree)/drivers/xenomai/analogy
>   
>   obj-$(CONFIG_XENO_DRIVERS_ANALOGY) += xeno_analogy.o testing/ intel/ national_instruments/ sensoray/
>   
> diff --git a/kernel/drivers/analogy/intel/Makefile b/kernel/drivers/analogy/intel/Makefile
> index 9b15d33f9..94beedc9b 100644
> --- a/kernel/drivers/analogy/intel/Makefile
> +++ b/kernel/drivers/analogy/intel/Makefile
> @@ -1,5 +1,5 @@
>   
> -ccflags-y += -Idrivers/xenomai/analogy
> +ccflags-y += -I$(srctree)/drivers/xenomai/analogy
>   
>   obj-$(CONFIG_XENO_DRIVERS_ANALOGY_8255) += analogy_8255.o
>   
> diff --git a/kernel/drivers/analogy/national_instruments/Makefile b/kernel/drivers/analogy/national_instruments/Makefile
> index d638269a6..b4c93d233 100644
> --- a/kernel/drivers/analogy/national_instruments/Makefile
> +++ b/kernel/drivers/analogy/national_instruments/Makefile
> @@ -1,5 +1,5 @@
>   
> -ccflags-y += -Idrivers/xenomai/analogy
> +ccflags-y += -I$(srctree)/drivers/xenomai/analogy
>   
>   obj-$(CONFIG_XENO_DRIVERS_ANALOGY_NI_MITE) += analogy_ni_mite.o
>   obj-$(CONFIG_XENO_DRIVERS_ANALOGY_NI_TIO) += analogy_ni_tio.o
> diff --git a/kernel/drivers/analogy/sensoray/Makefile b/kernel/drivers/analogy/sensoray/Makefile
> index 1bf7aba88..51bad4ddd 100644
> --- a/kernel/drivers/analogy/sensoray/Makefile
> +++ b/kernel/drivers/analogy/sensoray/Makefile
> @@ -1,5 +1,5 @@
>   
> -ccflags-y += -Idrivers/xenomai/analogy
> +ccflags-y += -I$(srctree)/drivers/xenomai/analogy
>   
>   obj-$(CONFIG_XENO_DRIVERS_ANALOGY_S526) += analogy_s526.o
>   
> diff --git a/kernel/drivers/analogy/testing/Makefile b/kernel/drivers/analogy/testing/Makefile
> index 53b75c48a..e92e5bc90 100644
> --- a/kernel/drivers/analogy/testing/Makefile
> +++ b/kernel/drivers/analogy/testing/Makefile
> @@ -1,5 +1,5 @@
>   
> -ccflags-y += -Idrivers/xenomai/analogy
> +ccflags-y += -I$(srctree)/drivers/xenomai/analogy
>   
>   obj-$(CONFIG_XENO_DRIVERS_ANALOGY_FAKE) += analogy_fake.o
>   
> diff --git a/kernel/drivers/can/Makefile b/kernel/drivers/can/Makefile
> index 36d125f5e..1c071b214 100644
> --- a/kernel/drivers/can/Makefile
> +++ b/kernel/drivers/can/Makefile
> @@ -1,5 +1,5 @@
>   
> -ccflags-y += -Idrivers/xenomai/can
> +ccflags-y += -I$(srctree)/drivers/xenomai/can
>   
>   obj-$(CONFIG_XENO_DRIVERS_CAN) += xeno_can.o mscan/ sja1000/
>   obj-$(CONFIG_XENO_DRIVERS_CAN_FLEXCAN) += xeno_can_flexcan.o
> diff --git a/kernel/drivers/can/mscan/Makefile b/kernel/drivers/can/mscan/Makefile
> index 7b9b5e609..0f157e9ec 100644
> --- a/kernel/drivers/can/mscan/Makefile
> +++ b/kernel/drivers/can/mscan/Makefile
> @@ -1,5 +1,5 @@
>   
> -ccflags-y += -Idrivers/xenomai/can -Idrivers/xenomai/can/mscan
> +ccflags-y += -I$(srctree)/drivers/xenomai/can -I$(srctree)/drivers/xenomai/can/mscan
>   
>   obj-$(CONFIG_XENO_DRIVERS_CAN_MSCAN) += xeno_can_mscan.o
>   
> diff --git a/kernel/drivers/can/sja1000/Makefile b/kernel/drivers/can/sja1000/Makefile
> index dfb96b8e8..ff6715513 100644
> --- a/kernel/drivers/can/sja1000/Makefile
> +++ b/kernel/drivers/can/sja1000/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/can -Idrivers/xenomai/can/sja1000
> +ccflags-y += -I$(srctree)/drivers/xenomai/can -I$(srctree)/drivers/xenomai/can/sja1000
>   
>   obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000) += xeno_can_sja1000.o
>   obj-$(CONFIG_XENO_DRIVERS_CAN_SJA1000_PEAK_PCI) += xeno_can_peak_pci.o
> diff --git a/kernel/drivers/gpiopwm/Makefile b/kernel/drivers/gpiopwm/Makefile
> index c5d2bd6ee..8c9d5be2c 100644
> --- a/kernel/drivers/gpiopwm/Makefile
> +++ b/kernel/drivers/gpiopwm/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Ikernel -Iinclude/xenomai/
> +ccflags-y += -I$(srctree)/kernel -I$(srctree)/include/xenomai/
>   
>   obj-$(CONFIG_XENO_DRIVERS_GPIOPWM) += xeno_gpiopwm.o
>   
> diff --git a/kernel/drivers/net/addons/Makefile b/kernel/drivers/net/addons/Makefile
> index 2b3f11138..1f3939b07 100644
> --- a/kernel/drivers/net/addons/Makefile
> +++ b/kernel/drivers/net/addons/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_ADDON_RTCAP) += rtcap.o
>   
> diff --git a/kernel/drivers/net/drivers/Makefile b/kernel/drivers/net/drivers/Makefile
> index d95c5a81c..d97d5591c 100644
> --- a/kernel/drivers/net/drivers/Makefile
> +++ b/kernel/drivers/net/drivers/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_EXP_DRIVERS) += experimental/
>   
> diff --git a/kernel/drivers/net/drivers/e1000/Makefile b/kernel/drivers/net/drivers/e1000/Makefile
> index f8875a264..1c2845252 100644
> --- a/kernel/drivers/net/drivers/e1000/Makefile
> +++ b/kernel/drivers/net/drivers/e1000/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_E1000) += rt_e1000.o
>   
> diff --git a/kernel/drivers/net/drivers/e1000e/Makefile b/kernel/drivers/net/drivers/e1000e/Makefile
> index f75bba1ca..6a488cbdc 100644
> --- a/kernel/drivers/net/drivers/e1000e/Makefile
> +++ b/kernel/drivers/net/drivers/e1000e/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_E1000E) += rt_e1000e.o
>   
> diff --git a/kernel/drivers/net/drivers/experimental/Makefile b/kernel/drivers/net/drivers/experimental/Makefile
> index ad2317790..eddd29d47 100644
> --- a/kernel/drivers/net/drivers/experimental/Makefile
> +++ b/kernel/drivers/net/drivers/experimental/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_RT2500) += rt2500/
>   
> diff --git a/kernel/drivers/net/drivers/experimental/e1000/Makefile b/kernel/drivers/net/drivers/experimental/e1000/Makefile
> index e1f998678..be144c477 100644
> --- a/kernel/drivers/net/drivers/experimental/e1000/Makefile
> +++ b/kernel/drivers/net/drivers/experimental/e1000/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_E1000_NEW) += rt_e1000_new.o
>   
> diff --git a/kernel/drivers/net/drivers/experimental/rt2500/Makefile b/kernel/drivers/net/drivers/experimental/rt2500/Makefile
> index eff55cccc..d5e2643c7 100644
> --- a/kernel/drivers/net/drivers/experimental/rt2500/Makefile
> +++ b/kernel/drivers/net/drivers/experimental/rt2500/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_RT2500) += rt_rt2x00core.o rt_rt2500pci.o
>   
> diff --git a/kernel/drivers/net/drivers/igb/Makefile b/kernel/drivers/net/drivers/igb/Makefile
> index 2bd8b2fe7..49cdf5056 100644
> --- a/kernel/drivers/net/drivers/igb/Makefile
> +++ b/kernel/drivers/net/drivers/igb/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_IGB) += rt_igb.o
>   
> diff --git a/kernel/drivers/net/drivers/mpc52xx_fec/Makefile b/kernel/drivers/net/drivers/mpc52xx_fec/Makefile
> index 336676d9f..4edf7ad82 100644
> --- a/kernel/drivers/net/drivers/mpc52xx_fec/Makefile
> +++ b/kernel/drivers/net/drivers/mpc52xx_fec/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_MPC52XX_FEC) += rt_mpc52xx_fec.o
>   
> diff --git a/kernel/drivers/net/drivers/tulip/Makefile b/kernel/drivers/net/drivers/tulip/Makefile
> index 9a5e620a9..30631101c 100644
> --- a/kernel/drivers/net/drivers/tulip/Makefile
> +++ b/kernel/drivers/net/drivers/tulip/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_DRV_TULIP) += rt_tulip.o
>   
> diff --git a/kernel/drivers/net/stack/Makefile b/kernel/drivers/net/stack/Makefile
> index d055dc2af..f75483e02 100644
> --- a/kernel/drivers/net/stack/Makefile
> +++ b/kernel/drivers/net/stack/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include -Ikernel/
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include -I$(srctree)/kernel/
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += ipv4/
>   
> diff --git a/kernel/drivers/net/stack/ipv4/Makefile b/kernel/drivers/net/stack/ipv4/Makefile
> index 7d45d238b..afdbeafce 100644
> --- a/kernel/drivers/net/stack/ipv4/Makefile
> +++ b/kernel/drivers/net/stack/ipv4/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4) += rtipv4.o
>   
> diff --git a/kernel/drivers/net/stack/ipv4/tcp/Makefile b/kernel/drivers/net/stack/ipv4/tcp/Makefile
> index 8a2d04962..88a9acfe8 100644
> --- a/kernel/drivers/net/stack/ipv4/tcp/Makefile
> +++ b/kernel/drivers/net/stack/ipv4/tcp/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_TCP) += rttcp.o
>   
> diff --git a/kernel/drivers/net/stack/ipv4/udp/Makefile b/kernel/drivers/net/stack/ipv4/udp/Makefile
> index 5f74b837c..b25a3346a 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/Makefile
> +++ b/kernel/drivers/net/stack/ipv4/udp/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_RTIPV4_UDP) += rtudp.o
>   
> diff --git a/kernel/drivers/net/stack/packet/Makefile b/kernel/drivers/net/stack/packet/Makefile
> index ebbbd2120..abee4f6ae 100644
> --- a/kernel/drivers/net/stack/packet/Makefile
> +++ b/kernel/drivers/net/stack/packet/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_RTPACKET) += rtpacket.o
>   
> diff --git a/kernel/drivers/net/stack/rtcfg/Makefile b/kernel/drivers/net/stack/rtcfg/Makefile
> index e69ead4c4..80a954de7 100644
> --- a/kernel/drivers/net/stack/rtcfg/Makefile
> +++ b/kernel/drivers/net/stack/rtcfg/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_RTCFG) += rtcfg.o
>   
> diff --git a/kernel/drivers/net/stack/rtmac/Makefile b/kernel/drivers/net/stack/rtmac/Makefile
> index dc72b188d..79d532fa1 100644
> --- a/kernel/drivers/net/stack/rtmac/Makefile
> +++ b/kernel/drivers/net/stack/rtmac/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_NOMAC) += nomac/
>   
> diff --git a/kernel/drivers/net/stack/rtmac/nomac/Makefile b/kernel/drivers/net/stack/rtmac/nomac/Makefile
> index 3ad7bc642..50c29ccc3 100644
> --- a/kernel/drivers/net/stack/rtmac/nomac/Makefile
> +++ b/kernel/drivers/net/stack/rtmac/nomac/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_NOMAC) += nomac.o
>   
> diff --git a/kernel/drivers/net/stack/rtmac/tdma/Makefile b/kernel/drivers/net/stack/rtmac/tdma/Makefile
> index 5fc4eb62b..f85f5d773 100644
> --- a/kernel/drivers/net/stack/rtmac/tdma/Makefile
> +++ b/kernel/drivers/net/stack/rtmac/tdma/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Idrivers/xenomai/net/stack/include
> +ccflags-y += -I$(srctree)/drivers/xenomai/net/stack/include
>   
>   obj-$(CONFIG_XENO_DRIVERS_NET_TDMA) += tdma.o
>   
> diff --git a/kernel/drivers/udd/Makefile b/kernel/drivers/udd/Makefile
> index 17ca1ea37..dedf72b32 100644
> --- a/kernel/drivers/udd/Makefile
> +++ b/kernel/drivers/udd/Makefile
> @@ -1,4 +1,4 @@
> -ccflags-y += -Ikernel
> +ccflags-y += -I$(srctree)/kernel
>   
>   obj-$(CONFIG_XENO_DRIVERS_UDD) += xeno_udd.o
>   
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 7fb8ed330..3ff9433d2 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -387,7 +387,7 @@ case $linux_VERSION.$linux_PATCHLEVEL in
>   test "x$CONFIG_XENO_REVISION_LEVEL" = "x" && CONFIG_XENO_REVISION_LEVEL=0
>   
>       if ! grep -q CONFIG_XENOMAI $linux_tree/arch/$linux_arch/Makefile; then
> -	p="KBUILD_CFLAGS += -Iarch/\$(SRCARCH)/xenomai/include -Iinclude/xenomai"
> +	p="KBUILD_CFLAGS += -I\$(srctree)/arch/\$(SRCARCH)/xenomai/include -I\$(srctree)/include/xenomai"
>   	(echo; echo $p) | patch_append arch/$linux_arch/Makefile
>   	p="core-\$(CONFIG_XENOMAI)	+= arch/$linux_arch/xenomai/"
>   	echo $p | patch_append arch/$linux_arch/Makefile
> 

Thanks, applied this one to next already.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

