Subject: Re: [PATCH 1/7] travis: add basic CI support
References: <20190305144521.2567-1-roman.stratiienko@globallogic.com>
 <937d0f10-347e-873f-42cf-39569350367a@siemens.com>
 <CALLqZ8SzT5tLPZ-z5YA6Zt3QOAEi8dexmGdEpfySc81P8fu2Yg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e747f965-54dc-6aa1-9df0-a81873123202@siemens.com>
Date: Tue, 5 Mar 2019 22:27:31 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8SzT5tLPZ-z5YA6Zt3QOAEi8dexmGdEpfySc81P8fu2Yg@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: roman.stratiienko@globallogic.com, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 05.03.19 21:29, Greg Gallagher via Xenomai wrote:
> On Tue, Mar 5, 2019 at 12:53 PM Jan Kiszka via Xenomai
> <xenomai@xenomai.org> wrote:
>>
>> On 05.03.19 15:45, roman.stratiienko--- via Xenomai wrote:
>>> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
>>>
>>> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
>>> ---
>>>    .travis.yml | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 73 insertions(+)
>>>    create mode 100644 .travis.yml
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> new file mode 100644
>>> index 000000000..0807760f4
>>> --- /dev/null
>>> +++ b/.travis.yml
>>> @@ -0,0 +1,73 @@
>>> +language: c
>>> +dist: xenial
>>> +
>>> +addons:
>>> +  apt:
>>> +    packages:
>>> +      - gcc-aarch64-linux-gnu
>>> +      - gcc-arm-linux-gnueabihf
>>> +      - patch
>>> +      - quilt
>>> +      - wget
>>> +
>>> +env:
>>> +  global:
>>> +    - KDIR=/tmp/kernel
>>> +
>>> +install:
>>> +  - if [[ "${KERNEL_VERSION}" == *-rc* ]]; then
>>> +      KERNEL_URL=https://git.kernel.org/torvalds/t/linux-${KERNEL_VERSION}.tar.gz;
>>> +    else
>>> +      KERNEL_URL=https://www.kernel.org/pub/linux/kernel/v${KERNEL_VERSION::1}.x/linux-${KERNEL_VERSION}.tar.xz;
>>> +    fi
>>> +  - wget -O kernel.tar.xz ${KERNEL_URL} && mkdir ${KDIR} && tar -C ${KDIR} --strip=1 -xf kernel.tar.xz
>>> +  - wget -O /tmp/ipipe.patch ${IPIPE_URL}
>>> +
>>> +before_script:
>>> +  - case "${ARCH}" in
>>> +      "arm64") export CROSS_COMPILE=aarch64-linux-gnu-
>>> +          ;;
>>> +      "arm"  ) export CROSS_COMPILE=arm-linux-gnueabihf-
>>> +          ;;
>>> +      "x86"  ) export CROSS_COMPILE=
>>> +          ;;
>>> +    esac
>>> +  - pushd ${KDIR}
>>> +  - make -j $(nproc) ${KERNEL_DEFCONFIG}
>>> +  - ./scripts/config -e CONFIG_IPIPE
>>> +  - ./scripts/config -e CONFIG_XENOMAI
>>> +  - popd
>>> +
>>> +script:
>>> +  - ./scripts/prepare-kernel.sh --ipipe=/tmp/ipipe.patch --arch=${ARCH} --linux=${KDIR}
>>> +  - cd ${KDIR}
>>> +  - make -j $(nproc) olddefconfig
>>> +  - make -j $(nproc) all
>>> +
>>> +matrix:
>>> +  include:
>>> +    - env:
>>> +      - ARCH: arm
>>> +        KERNEL_VERSION: 4.20.7
>>> +        KERNEL_DEFCONFIG: multi_v7_defconfig
>>> +        IPIPE_URL: https://github.com/devel-opi/linux-ipipe-arm-porting/releases/download/draft-v4.20.7/0001-Draft-version-of-ipipe-arm-ported-on-v4.20.7.patch
> Do we want to maintainthe 4.20kernel in arm-ipipe tree?  Would it make
> more sense to support a newer LTS kernel like 4.19?
> 

See my reply on patch 7: We need to discuss what to test, and from where to pull 
that.

I do not know the story of this version here, or the 5.0 one. They are surely 
useful to move forward, but releases are more reasonably done based on LTS. That 
means our next goal is 4.19, and then something around 5.4, I suppose.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

