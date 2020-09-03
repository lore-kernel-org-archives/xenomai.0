Subject: Re: [PATCH 1/1] ci: Add gitlab-ci.yml
References: <20200903135700.25134-1-Quirin.Gylstorff@siemens.com>
 <20200903135700.25134-2-Quirin.Gylstorff@siemens.com>
 <dbc9ab21-60da-7d32-78c2-be45f612dc16@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Message-ID: <9becf4a1-a69a-2d4d-153d-bae2e9ad7e49@siemens.com>
Date: Thu, 3 Sep 2020 19:51:56 +0200
MIME-Version: 1.0
In-Reply-To: <dbc9ab21-60da-7d32-78c2-be45f612dc16@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org



On 9/3/20 4:05 PM, Jan Kiszka wrote:
> On 03.09.20 15:57, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Derive .gitlab-ci.yml from .travis.yml to allow ci build on denx.gitlab.de.
>>
>> Changes:
>>   - The base image is switched to debian:buster.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml | 254 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 254 insertions(+)
>>   create mode 100644 .gitlab-ci.yml
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> new file mode 100644
>> index 000000000..10d9ef8d6
>> --- /dev/null
>> +++ b/.gitlab-ci.yml
>> @@ -0,0 +1,254 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2020
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +stages:
>> +  - build
>> +
>> +default:
>> +  image: debian:buster
>> +
>> +variables:
>> +  GIT_STRATEGY: clone
>> +  KDIR: "/tmp/kernel"
>> +  USE_CCACHE: "1"
>> +  CCACHE_MAXSIZE: "400M"
>> +  IPIPE_MIRROR_URL: "https://gitlab.denx.de/Xenomai"
>> +  PACKAGES: "gcc-8 gcc-8-aarch64-linux-gnu libc6-dev-arm64-cross \
>> +             gcc-8-arm-linux-gnueabihf libc6-dev-armhf-cross \
>> +             gcc-8-powerpc-linux-gnu libc6-dev-powerpc-cross  \
>> +             u-boot-tools git make bc bison libelf-dev autotools-dev \
>> +             autoconf autogen libtool pkg-config ccache flex libssl-dev"
>> +
>> +.build:
>> +  stage: build
>> +  before_script:
>> +    - apt update
>> +    - apt install -y ${PACKAGES}
>> +    - update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800
>> +    - update-alternatives --install /usr/bin/aarch64-linux-gnu-gcc aarch64-linux-gnu-gcc /usr/bin/aarch64-linux-gnu-gcc-8 800
>> +    - update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-8 800
>> +    - update-alternatives --install /usr/bin/powerpc-linux-gnu-gcc powerpc-linux-gnu-gcc /usr/bin/powerpc-linux-gnu-gcc-8 800
>> +    - REV=$(git ls-remote --tags --refs ${IPIPE_KERNEL} | sed "s|.*[[:space:]]refs/tags/||" | grep "${IPIPE_REV}" | sort -r -n -t - -k 5 -k 6 | head -1)
>> +    - test -n "${REV}" || REV="${IPIPE_REV}"
>> +    - echo $?
>> +    - git clone --depth 1 --branch ${REV} ${IPIPE_KERNEL} ${KDIR}
>> +    - case "${ARCH}" in
>> +      "arm64")
>> +      export CROSS_COMPILE=aarch64-linux-gnu-
>> +      export CONFIGURE_OPTS="--host=aarch64-linux-gnu --with-cc=aarch64-linux-gnu-gcc"
>> +      ;;
>> +      "arm")
>> +      export CROSS_COMPILE=arm-linux-gnueabihf-
>> +      export CONFIGURE_OPTS="--host=arm-linux-gnueabihf --with-cc=arm-linux-gnueabihf-gcc"
>> +      ;;
>> +      "powerpc")
>> +      export CROSS_COMPILE=powerpc-linux-gnu-
>> +      export CONFIGURE_OPTS="--host=powerpc-linux-gnu --with-cc=powerpc-linux-gnu-gcc"
>> +      ;;
>> +      "x86")
>> +      export CROSS_COMPILE=
>> +      export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched"
>> +      ;;
>> +      esac
>> +    - mkdir ~/ccache
>> +    - ln -s /usr/bin/ccache ~/ccache/aarch64-linux-gnu-gcc
>> +    - ln -s /usr/bin/ccache ~/ccache/arm-linux-gnueabihf-gcc
>> +    - ln -s /usr/bin/ccache ~/ccache/powerpc-linux-gnu-gcc
>> +    - export PATH=~/ccache:$PATH
>> +    - ${CROSS_COMPILE}gcc --version
>> +
>> +  script:
>> +    - pushd ${KDIR}
>> +    - make -j $(nproc) ${KERNEL_DEFCONFIG}
>> +    # Generic settings
>> +    - ./scripts/config -d DEBUG_INFO
>> +    # I-pipe and Xenomai settings
>> +    - ./scripts/config -e IPIPE
>> +    - ./scripts/config -e XENOMAI
>> +    - ./scripts/config -e XENO_OPT_SCHED_CLASSES
>> +    - ./scripts/config -e XENO_OPT_SCHED_WEAK
>> +    - ./scripts/config -e XENO_OPT_SCHED_TP
>> +    - ./scripts/config -e XENO_OPT_SCHED_SPORADIC
>> +    - ./scripts/config -e XENO_OPT_SCHED_QUOTA
>> +    - ./scripts/config -e XENO_OPT_SHIRQ
>> +    - ./scripts/config -e XENO_OPT_SCALABLE_SCHED
>> +    - ./scripts/config -e XENO_OPT_DEBUG
>> +    - ./scripts/config -e XENO_OPT_DEBUG_COBALT
>> +    - ./scripts/config -e XENO_OPT_DEBUG_MEMORY
>> +    - ./scripts/config -e XENO_OPT_DEBUG_CONTEXT
>> +    - ./scripts/config -e XENO_OPT_DEBUG_USER
>> +    - ./scripts/config -e XENO_OPT_DEBUG_LEGACY
>> +    - ./scripts/config -e XENO_OPT_DEBUG_TRACE_RELAX
>> +    - ./scripts/config -e XENO_DRIVERS_16550A
>> +    - ./scripts/config -e XENO_DRIVERS_16550A_ANY
>> +    - ./scripts/config -e XENO_DRIVERS_16550A_PCI
>> +    - ./scripts/config -e XENO_DRIVERS_16550A_PCI_MOXA
>> +    - ./scripts/config -e XENO_DRIVERS_IMX_UART
>> +    - ./scripts/config -e XENO_DRIVERS_RTDMTEST
>> +    - ./scripts/config -e XENO_DRIVERS_CAN
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_LOOPBACK
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_VIRT
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_FLEXCAN
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ISA
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_MEM
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PEAK_PCI
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_IXXAT_PCI
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ADV_PCI
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PLX_PCI
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_EMS_PCI
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_ESD_PCI
>> +    - ./scripts/config -e XENO_DRIVERS_CAN_SJA1000_PEAK_DNG
>> +    - ./scripts/config -m XENO_DRIVERS_NET
>> +    - ./scripts/config -e XENO_DRIVERS_RTNET_CHECKED
>> +    - ./scripts/config -e XENO_DRIVERS_NET_ETH_P_ALL
>> +    - ./scripts/config -e XENO_DRIVERS_NET_RTIPV4_NETROUTING
>> +    - ./scripts/config -e XENO_DRIVERS_NET_RTIPV4_ROUTER
>> +    - ./scripts/config -e XENO_DRIVERS_NET_RTIPV4_DEBUG
>> +    - ./scripts/config -m XENO_DRIVERS_NET_RTIPV4_TCP
>> +    - ./scripts/config -e XENO_DRIVERS_NET_RTIPV4_TCP_ERROR_INJECTION
>> +    - ./scripts/config -m XENO_DRIVERS_NET_NOMAC
>> +    - ./scripts/config -e XENO_DRIVERS_NET_RTCFG_DEBUG
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_PCNET32
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_TULIP
>> +    - ./scripts/config -e XENO_DRIVERS_NET_DRV_EEPRO100_DBG
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_E1000E
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_NATSEMI
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_VIA_RHINE
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_IGB
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_R8169
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_SMC91111
>> +    - ./scripts/config -e XENO_DRIVERS_NET_EXP_DRIVERS
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_3C59X
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_E1000_NEW
>> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_RT2500
>> +    - ./scripts/config -m XENO_DRIVERS_NET_ADDON_RTCAP
>> +    - ./scripts/config -m XENO_DRIVERS_NET_ADDON_PROXY
>> +    - ./scripts/config -e XENO_DRIVERS_NET_ADDON_PROXY_ARP
>> +    - ./scripts/config -e XENO_DRIVERS_ANALOGY
>> +    - ./scripts/config -e XENO_DRIVERS_ANALOGY_DEBUG
>> +    - ./scripts/config -e XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
>> +    - ./scripts/config -e XENO_DRIVERS_ANALOGY_FAKE
>> +    - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_PCIMIO
>> +    - ./scripts/config -e XENO_DRIVERS_ANALOGY_S526
>> +    - ./scripts/config -e XENO_DRIVERS_RTIPC
>> +    - ./scripts/config -e XENO_DRIVERS_UDD
>> +    - ./scripts/config -e XENO_DRIVERS_GPIO
>> +    - ./scripts/config -e XENO_DRIVERS_GPIO_BCM2835
>> +    - ./scripts/config -e XENO_DRIVERS_GPIO_MXC
>> +    - ./scripts/config -e XENO_DRIVERS_GPIO_SUN8I_H3
>> +    - ./scripts/config -e XENO_DRIVERS_GPIO_ZYNQ7000
>> +    - ./scripts/config -e XENO_DRIVERS_GPIO_XILINX
>> +    - ./scripts/config -e XENO_DRIVERS_GPIO_OMAP
>> +    - ./scripts/config -e XENO_DRIVERS_GPIO_DEBUG
>> +    - ./scripts/config -e XENO_DRIVERS_GPIOPWM
>> +    - ./scripts/config -e XENO_DRIVERS_SPI_BCM2835
>> +    - ./scripts/config -e XENO_DRIVERS_SPI_SUN6I
>> +    - ./scripts/config -e XENO_DRIVERS_SPI_OMAP2_MCSPI_RT
>> +    - ./scripts/config -e XENO_DRIVERS_SPI_DEBUG
>> +    - popd
>> +    - scripts/prepare-kernel.sh --arch=${ARCH} --linux=${KDIR}
>> +    - pushd ${KDIR}
>> +    - make -j $(nproc) olddefconfig
>> +    - make -j $(nproc) all
>> +    - popd
>> +    - scripts/bootstrap
>> +    - ./configure --enable-smp ${CONFIGURE_OPTS}
>> +    - make -j $(nproc)
>> +    - ccache -s
>> +
>> +
>> +arm-4.19-release:
>> +  extends: .build
>> +  variables:
>> +    ARCH: arm
>> +    IPIPE_REV: ipipe-core-4.19..*-arm-.*
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
>> +    KERNEL_DEFCONFIG: multi_v7_defconfig
>> +
>> +arm-4.14-release:
>> +  extends: .build
>> +  variables:
>> +    ARCH: arm
>> +    IPIPE_REV: ipipe-core-4.14..*-arm-.*
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm.git
>> +    KERNEL_DEFCONFIG: multi_v7_defconfig
>> +
>> +arm-4.4-cip-head:
>> +  extends: .build
>> +  variables:
>> +    ARCH: arm
>> +    IPIPE_REV: ipipe-4.4.y-cip
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
>> +    KERNEL_DEFCONFIG: multi_v7_defconfig
>> +
>> +arm64-4.19-release:
>> +  extends: .build
>> +  variables:
>> +    ARCH: arm64
>> +    IPIPE_REV: ipipe-core-4.19..*-arm64-.*
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
>> +    KERNEL_DEFCONFIG: defconfig
>> +
>> +arm64-4.14-release:
>> +  extends: .build
>> +  variables:
>> +    ARCH: arm64
>> +    IPIPE_REV: ipipe-core-4.14..*-arm64-.*
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-arm64.git
>> +    KERNEL_DEFCONFIG: defconfig
>> +
>> +x86-4.19-cip-head:
>> +  extends: .build
>> +  variables:
>> +    ARCH: x86
>> +    IPIPE_REV: ipipe-x86-4.19.y-cip
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
>> +    KERNEL_DEFCONFIG: x86_64_defconfig
>> +
>> +x86-4.19-cip-release:
>> +  extends: .build
>> +  variables:
>> +    ARCH: x86
>> +    IPIPE_REV: ipipe-core-4.19..*cip.*-x86-.*
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
>> +    KERNEL_DEFCONFIG: x86_64_defconfig
>> +
>> +x86-4.14-release:
>> +  extends: .build
>> +  variables:
>> +    ARCH: x86
>> +    IPIPE_REV: ipipe-core-4.14..*-x86-.*
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-x86.git
>> +    KERNEL_DEFCONFIG: x86_64_defconfig
>> +
>> +x86-4.4-cip-head:
>> +  extends: .build
>> +  variables:
>> +    ARCH: x86
>> +    IPIPE_REV: ipipe-4.4.y-cip
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
>> +    KERNEL_DEFCONFIG: x86_64_defconfig
>> +
>> +x86-4.4-cip-release:
>> +  extends: .build
>> +  variables:
>> +     ARCH: x86
>> +     IPIPE_REV: ipipe-core-4.4..*-cip.*-x86-.*
>> +     IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe.git
>> +     KERNEL_DEFCONFIG: x86_64_defconfig
>> +
>> +powerpc-4.19-release:
>> +  extends: .build
>> +  variables:
>> +    ARCH: powerpc
>> +    IPIPE_REV: ipipe-core-4.19..*-ppc32-.*
>> +    IPIPE_KERNEL: ${IPIPE_MIRROR_URL}/ipipe-ppc32.git
>> +    KERNEL_DEFCONFIG: mpc5200_defconfig
>>
> 
> Great! Except that we should either drop .travis-ci.yml or try to factor
> out the common parts.
> 
> Is there any chance to do the latter, specifically to avoid that we need
> to change two files for adding one new kernel version? If not, we should
> bury Travis after testing gitlab for a while.
> 
> Do you have a link to a test run at hand?

Yes here is a link[1] to the run. I need to send a v2 as the cip builds 
are not that stable and fail more than the are successful. Something 
with the version. I will try to get the travis and gitlab configs merge.
Should be possible with some kind of include or move them to scripts.

[1]:https://gitlab.com/Quirin.Gy/xenomai/-/pipelines/185329147

> 
> Jan
> 

-- 
Quirin

