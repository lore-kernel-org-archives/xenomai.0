Subject: Re: [PATCH v3] travis: add basic CI support
References: <20190311143722.21320-1-roman.stratiienko@globallogic.com>
 <20190311143722.21320-2-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ef22da7e-46f1-710c-53a6-4467f88b0db3@siemens.com>
Date: Mon, 18 Mar 2019 13:59:11 +0100
MIME-Version: 1.0
In-Reply-To: <20190311143722.21320-2-roman.stratiienko@globallogic.com>
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
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org

On 11.03.19 15:37, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
> 
> Changes since v2
> 
> Removed redundand "CONFIG_" prefix
> Added building of the drivers
> 
> Currently CAN bus driver build fails on v4.20 and v5.0,
> (https://travis-ci.org/devel-opi/xenomai-fork/builds/504429157)
> 
> Please suggest which configs should be also enabled in
> CI to cover as much as possible code lines
> 
>   .travis.yml | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 99 insertions(+)
>   create mode 100644 .travis.yml
> 
> diff --git a/.travis.yml b/.travis.yml
> new file mode 100644
> index 000000000..8d3eba2c3
> --- /dev/null
> +++ b/.travis.yml
> @@ -0,0 +1,99 @@
> +language: c
> +dist: xenial
> +
> +addons:
> +  apt:
> +    packages:
> +      - gcc-aarch64-linux-gnu
> +      - gcc-arm-linux-gnueabihf
> +      - patch
> +      - quilt
> +      - wget
> +
> +env:
> +  global:
> +    - KDIR=/tmp/kernel
> +
> +install:
> +  - if [[ "${KERNEL_VERSION}" == *-rc* ]]; then
> +      KERNEL_URL=https://git.kernel.org/torvalds/t/linux-${KERNEL_VERSION}.tar.gz;
> +    else
> +      KERNEL_URL=https://www.kernel.org/pub/linux/kernel/v${KERNEL_VERSION::1}.x/linux-${KERNEL_VERSION}.tar.xz;
> +    fi
> +  - wget -O kernel.tar.xz ${KERNEL_URL} && mkdir ${KDIR} && tar -C ${KDIR} --strip=1 -xf kernel.tar.xz
> +  - wget -O /tmp/ipipe.patch ${IPIPE_URL}
> +
> +before_script:
> +  - case "${ARCH}" in
> +      "arm64") export CROSS_COMPILE=aarch64-linux-gnu-
> +          ;;
> +      "arm"  ) export CROSS_COMPILE=arm-linux-gnueabihf-
> +          ;;
> +      "x86"  ) export CROSS_COMPILE=
> +          ;;
> +    esac
> +  - pushd ${KDIR}
> +  - make -j $(nproc) ${KERNEL_DEFCONFIG}
> +  - ./scripts/config -e IPIPE
> +  - ./scripts/config -e XENOMAI
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_DEBUG
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_8255
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_PARPORT
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_MITE
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_TIO
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_MIO
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_PCIMIO
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_670x
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_660x
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_S526
> +  - ./scripts/config -e XENO_DRIVERS_ANALOGY_FAKE
> +  - ./scripts/config -e XENO_DRIVERS_AUTOTUNE
> +  - ./scripts/config -e XENO_DRIVERS_CAN
> +  - ./scripts/config -e XENO_DRIVERS_CAN_DEBUG
> +  - ./scripts/config -e XENO_DRIVERS_CAN_LOOPBACK
> +  - ./scripts/config -e XENO_DRIVERS_CAN_BUS_ERR
> +  - ./scripts/config -e XENO_DRIVERS_CAN_VIRT
> +  - ./scripts/config -e XENO_DRIVERS_CAN_FLEXCAN
> +  - ./scripts/config -e XENO_DRIVERS_GPIO
> +  - ./scripts/config -e XENO_DRIVERS_GPIO_SUN8I_H3
> +  - ./scripts/config -e XENO_DRIVERS_GPIO_DEBUG
> +  - ./scripts/config -e XENO_DRIVERS_GPIOPWM
> +  - ./scripts/config -e XENO_DRIVERS_RTIPC
> +  - ./scripts/config -e XENO_DRIVERS_NET
> +  - ./scripts/config -e XENO_DRIVERS_16550A
> +  - ./scripts/config -e XENO_DRIVERS_SPI
> +  - ./scripts/config -e XENO_DRIVERS_TIMERBENCH
> +  - ./scripts/config -e XENO_DRIVERS_UDD
> +
> +  - popd
> +
> +script:
> +  - ./scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH} --linux=${KDIR}
> +  - cd ${KDIR}
> +  - make -j $(nproc) olddefconfig
> +  - make -j $(nproc) all
> +
> +matrix:
> +  include:
> +    - env:
> +      - ARCH: arm
> +        KERNEL_VERSION: 4.14.85
> +        KERNEL_DEFCONFIG: multi_v7_defconfig
> +        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/arm/ipipe-core-4.14.85-arm-6.patch
> +    - env:
> +      - ARCH: arm
> +        KERNEL_VERSION: 4.1.18
> +        KERNEL_DEFCONFIG: multi_v7_defconfig
> +        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/arm/older/ipipe-core-4.1.18-arm-9.patch
> +    - env:
> +      - ARCH: x86
> +        KERNEL_VERSION: 4.14.89
> +        KERNEL_DEFCONFIG: x86_64_defconfig
> +        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.14.89-x86-2.patch
> +    - env:
> +      - ARCH: x86
> +        KERNEL_VERSION: 4.4.166
> +        KERNEL_DEFCONFIG: i386_defconfig
> +        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.4.166-x86-12.patch
> 

Starting to process my backlog with adding this commit to next. I had to create 
a mirror in github for that, but now we have

https://travis-ci.com/xenomai-ci/xenomai

fed by

https://github.com/xenomai-ci/xenomai

which is automatically updated when I push to the official repo. When everything 
runs smoothly, we likely want to set some links, maybe including a build badge, 
in our docs.

Thanks for starting this!
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

