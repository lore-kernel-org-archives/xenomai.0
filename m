Subject: Re: [PATCH] travis: use ccache
References: <20190320160146.4224-1-roman.stratiienko@globallogic.com>
 <4d885178-b10e-b70e-01d7-dd0f8ed823d1@web.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c17d1c17-98ad-47ab-7e69-4e6986090124@siemens.com>
Date: Tue, 9 Apr 2019 15:50:31 +0200
MIME-Version: 1.0
In-Reply-To: <4d885178-b10e-b70e-01d7-dd0f8ed823d1@web.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: roman.stratiienko@globallogic.com, xenomai@xenomai.org

On 01.04.19 20:02, Jan Kiszka via Xenomai wrote:
> On 20.03.19 17:01, roman.stratiienko--- via Xenomai wrote:
>> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
>>
>> This speeds-up travis build
>>
>> Measurement results (build with ipipe-core-4.14.85-arm-6)
>>   - Without ccache: 26 min 7 sec
>>   - With ccache (1st run): 31 min 21 sec
>>   - With ccache (every next run): 4 min 23 sec
>>
>> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
>> ---
>>   .travis.yml | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index c5a9026aa..e40cec51d 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -1,5 +1,6 @@
>>   language: c
>>   dist: xenial
>> +cache: ccache
>>
>>   addons:
>>     apt:
>> @@ -15,6 +16,8 @@ addons:
>>   env:
>>     global:
>>       - KDIR=/tmp/kernel
>> +    - USE_CCACHE=1
>> +    - CCACHE_MAXSIZE=400M
>>
>>   install:
>>     - if [[ "${KERNEL_VERSION}" == *-rc* ]]; then
>> @@ -40,6 +43,10 @@ before_script:
>>             export CONFIGURE_OPTS="--enable-dlopen-libs --enable-lazy-setsched"
>>             ;;
>>       esac
>> +  - mkdir ~/ccache
>> +  - ln -s /usr/bin/ccache ~/ccache/aarch64-linux-gnu-gcc
>> +  - ln -s /usr/bin/ccache ~/ccache/arm-linux-gnueabihf-gcc
>> +  - export PATH=~/ccache:$PATH
>>     - pushd ${KDIR}
>>     - make -j $(nproc) ${KERNEL_DEFCONFIG}
>>     - ./scripts/config -e IPIPE
>> @@ -88,6 +95,7 @@ script:
>>     - scripts/bootstrap
>>     - ./configure --enable-smp ${CONFIGURE_OPTS}
>>     - make -j $(nproc)
>> +  - ccache -s
>>
>>   matrix:
>>     include:
>>
> 
> Nice! Applied to next.
> 

Looks like it's not working as desired on arm64:

https://travis-ci.com/xenomai-ci/xenomai/builds/107612473

Any idea?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

