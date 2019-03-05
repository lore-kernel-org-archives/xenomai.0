Subject: Re: [PATCH 1/7] travis: add basic CI support
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <937d0f10-347e-873f-42cf-39569350367a@siemens.com>
Date: Tue, 5 Mar 2019 18:53:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
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

On 05.03.19 15:45, roman.stratiienko--- via Xenomai wrote:
> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> ---
>   .travis.yml | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
>   create mode 100644 .travis.yml
> 
> diff --git a/.travis.yml b/.travis.yml
> new file mode 100644
> index 000000000..0807760f4
> --- /dev/null
> +++ b/.travis.yml
> @@ -0,0 +1,73 @@
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
> +  - ./scripts/config -e CONFIG_IPIPE
> +  - ./scripts/config -e CONFIG_XENOMAI
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
> +        KERNEL_VERSION: 4.20.7
> +        KERNEL_DEFCONFIG: multi_v7_defconfig
> +        IPIPE_URL: https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/draft-v4.20.7/0001-Draft-version-of-ipipe-arm-ported-on-v4.20.7.patch

Ah, nice, a port to a more recent kernel. Do you also have a queue according to 
our noarch / arch split? Would enable reuse for other archs.

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

Actually, we haven't tested 32-bit even on 4.4 in a while.

> +        IPIPE_URL: https://xenomai.org/downloads/ipipe/v4.x/x86/ipipe-core-4.4.166-x86-12.patch
> 

Cool! This is a valuable step forward /wrt CI. How long do these builds run 
each, roughly? We scale by spawning a separate build per kernel, right?

I had travis on the to-do list for a while, but everyone around lacked time to 
finish what we started internally. I'll dig out what we had to ensure we can 
merge valuable ideas. But that may even happen after creating a baseline with this.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

