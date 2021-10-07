Subject: Re: [PATCH] cobalt/arch/arm: fptest: Add missing SIMD register
 clobbering
References: <30a64188-e09e-d63d-dfcc-a678f72e15ac@siemens.com>
 <ca45521bd820453d37d0be78263f199eb369eabe.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0572db5d-3360-45be-b328-2809a389a43a@siemens.com>
Date: Thu, 7 Oct 2021 09:58:05 +0200
MIME-Version: 1.0
In-Reply-To: <ca45521bd820453d37d0be78263f199eb369eabe.camel@siemens.com>
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
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06.10.21 23:01, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> On Wed, 2021-10-06 at 17:19 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This caused troubles with modern gcc that starts to use those regs for
>> other purposes. Seen with gcc-10 on Debian 11 e.g.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>> index b81d109933..d5c2c7515b 100644
>> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>> @@ -32,7 +32,12 @@ static inline void fp_regs_set(int features, unsigned int val)
>>               /* vldm %0!, {d0-d15},
>>                  AKA fldmiax %0!, {d0-d15} */
>>               __asm__ __volatile__("ldc p11, cr0, [%0],#32*4":
>> -                                  "=r"(i): "0"(&e[0]): "memory");
>> +                                  "=r"(i)
>> +                                  : "0"(&e[0])
>> +                                  : "d0", "d1", "d2", "d3", "d4", "d5",
>> +                                    "d6", "d7", "d8", "d9", "d10", "d11",
>> +                                    "d12", "d13", "d14", "d15",
>> +                                    "memory");
>>       }
>>  }
>>
> 
> Is that already applied to next? That should be one of the last missing
> pieces for porting xenomai-images to Debian 11.

It's in next, right.

> 
> The last unclear topic (AFAIR) is the ssh-key regeneration taking too
> long for some reason on ARM and Debian 11, but that should be a Debian
> specific issue and is hopefully not related to Xenomai itself.
> 

Right, now I recall. Interestingly, this does not show up on ARM (in
QEMU) with the already ported jailhouse-images.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

