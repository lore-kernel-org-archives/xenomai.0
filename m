Subject: Re: [PATCH v2] gitlab-ci: add cache to decrease build times
References: <20201026092106.18119-1-Quirin.Gylstorff@siemens.com>
 <87fdf1fa-85c1-08c5-ca35-2f07ef448fd6@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0ffdac36-7002-4b6d-d183-caf7d543cb86@siemens.com>
Date: Mon, 26 Oct 2020 11:45:12 +0100
MIME-Version: 1.0
In-Reply-To: <87fdf1fa-85c1-08c5-ca35-2f07ef448fd6@siemens.com>
Content-Type: text/plain; charset=utf-8
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
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>, xenomai@xenomai.org

On 26.10.20 10:22, Jan Kiszka via Xenomai wrote:
> On 26.10.20 10:21, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Add the variable CCACHE_DIR to the build to move the ccache from ~/.ccache
>> to the current directory and upload the cache from each build.
>>
>> Each job uses a separate cache.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>
>> You can find an example build at:
>> https://gitlab.com/Quirin.Gy/xenomai/-/pipelines/207559342/builds
>> On this setup the build time is decrease from 2h to 20min.
>> Each build has 0.5 cores available.
>>
>> Changes V2:
>>  - Move ccache dir to $(pwd)/.ccache instead of .ccache in each build dir.
>>
>>  .gitlab-ci.yml | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 59bd1d355..d76c9e25e 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -56,14 +56,12 @@ variables:
>>        export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched"
>>        ;;
>>        esac
>> -    - mkdir ~/ccache
>> -    - ln -s /usr/bin/ccache ~/ccache/aarch64-linux-gnu-gcc
>> -    - ln -s /usr/bin/ccache ~/ccache/arm-linux-gnueabihf-gcc
>> -    - ln -s /usr/bin/ccache ~/ccache/powerpc-linux-gnu-gcc
>> -    - export PATH=~/ccache:$PATH
>> +    - ln -s /usr/lib/ccache/${CROSS_COMPILE}gcc-8 /usr/lib/ccache/${CROSS_COMPILE}gcc
>> +    - export PATH=/usr/lib/ccache:$PATH
>>      - ${CROSS_COMPILE}gcc --version
>>  
>>    script:
>> +    - export CCACHE_DIR=$(pwd)/.ccache
>>      - pushd ${KDIR}
>>      - make -j $(nproc) ${KERNEL_DEFCONFIG}
>>      # Generic settings
>> @@ -162,7 +160,10 @@ variables:
>>      - ./configure --enable-smp ${CONFIGURE_OPTS}
>>      - make -j $(nproc)
>>      - ccache -s
>> -
>> +  cache:
>> +    key: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
>> +    paths:
>> +      - .ccache
>>  
>>  arm-4.19-release:
>>    extends: .build
>>
> 
> Does this still apply to master? I merged your previous change this
> morning by accident. If not, please rebase.
> 
> Thanks,
> Jan
> 

Applies fine, taken to next.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

