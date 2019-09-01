Subject: Re: [PATCH] ci: Update arm 4.19 target
References: <a976f4fb-158a-8a1e-dba1-e2e154bec8ce@siemens.com>
 <fb003ba3-e084-7365-ccca-d7565f24654c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cb765fa3-51a1-8bab-42b5-83c4ddc900b1@siemens.com>
Date: Sun, 1 Sep 2019 19:09:59 +0200
MIME-Version: 1.0
In-Reply-To: <fb003ba3-e084-7365-ccca-d7565f24654c@siemens.com>
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
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

On 01.09.19 18:27, Jan Kiszka via Xenomai wrote:
> On 01.09.19 18:22, Jan Kiszka via Xenomai wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   .travis.yml | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index da7380cd10..657a1f2d68 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -154,7 +154,7 @@ matrix:
>>     include:
>>       - env:
>>         - ARCH: arm
>> -        IPIPE_REV: ipipe-core-4.19.33-arm-2
>> +        IPIPE_REV: ipipe-core-4.19.33-arm-3
> 
> Should be 55, of course. Updated in next.
> 
> Jan
> 
>>           IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm.git
>>           KERNEL_DEFCONFIG: multi_v7_defconfig
>>       - env:
>> @@ -167,6 +167,11 @@ matrix:
>>           IPIPE_REV: ipipe-4.4.y-cip
>>           IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe.git
>>           KERNEL_DEFCONFIG: multi_v7_defconfig
>> +    - env:
>> +      - ARCH: arm64
>> +        IPIPE_REV: ipipe-core-4.19.55-arm64-1
>> +        IPIPE_KERNEL: https://gitlab.denx.de/Xenomai/ipipe-arm64.git
>> +        KERNEL_DEFCONFIG: defconfig

CI run failed with kernel build error, see 
https://travis-ci.com/xenomai-ci/xenomai/jobs/229912070#L4879

Jan

>>       - env:
>>         - ARCH: arm64
>>           IPIPE_REV: ipipe-core-4.14.78-arm64-2
>>

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

