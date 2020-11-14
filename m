Subject: Re: [PATCH 1/3] cobalt uapi: Introducing new feature flag for
 settime64 availability
References: <1229be33-848d-ab5b-d6dd-1b7ae38d36f9@siemens.com>
 <20201113115932.276959-1-florian.bezdeka@siemens.com>
 <20201113115932.276959-2-florian.bezdeka@siemens.com>
 <88ba257e-c9bd-02eb-741d-7d600f9ffdfa@tj.kylinos.cn>
 <61278b81-2502-6950-4647-5cafcbdb0d23@siemens.com>
From: song <chensong@tj.kylinos.cn>
Message-ID: <157dbba3-5d17-7f84-6319-9ea9eae35854@tj.kylinos.cn>+EDAFE494B95437A7
Date: Sat, 14 Nov 2020 15:50:18 +0800
MIME-Version: 1.0
In-Reply-To: <61278b81-2502-6950-4647-5cafcbdb0d23@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, "florian.bezdeka@siemens.com" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>



On 2020/11/14 下午3:32, Jan Kiszka wrote:
> On 14.11.20 07:57, song via Xenomai wrote:
>>
>>
>> On 2020/11/13 下午8:00, florian.bezdeka@siemens.com wrote:
>>> From: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>
>>> Adding a new feature flag to allow the library asking for settime64
>>> support. That will allow the library to use the new system call if it
>>> is available / supported by the kernel.
>>>
>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>> ---
>>>    include/cobalt/uapi/asm-generic/features.h | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/cobalt/uapi/asm-generic/features.h
>>> b/include/cobalt/uapi/asm-generic/features.h
>>> index 8a4927c49..93a96670a 100644
>>> --- a/include/cobalt/uapi/asm-generic/features.h
>>> +++ b/include/cobalt/uapi/asm-generic/features.h
>>> @@ -51,6 +51,7 @@ struct cobalt_featinfo {
>>>    #define __xn_feat_nofastsynch 0x10000000
>>>    #define __xn_feat_control     0x08000000
>>>    #define __xn_feat_prioceiling 0x04000000
>>> +#define __xn_feat_settime64   0x02000000
>>>      #ifdef CONFIG_SMP
>>>    #define __xn_feat_smp_mask __xn_feat_smp
>>> @@ -70,7 +71,8 @@ struct cobalt_featinfo {
>>>    #define __xn_feat_generic_mask            \
>>>        (__xn_feat_smp_mask        |    \
>>>         __xn_feat_fastsynch_mask     |    \
>>> -     __xn_feat_prioceiling)
>>> +     __xn_feat_prioceiling        |    \
>>> +     __xn_feat_settime64 )
>>>      /*
>>>     * List of features both sides have to agree on: If userland supports
>>> @@ -101,6 +103,8 @@ const char *get_generic_feature_label(unsigned int
>>> feature)
>>>            return "control";
>>>        case __xn_feat_prioceiling:
>>>            return "prioceiling";
>>> +    case __xn_feat_settime64:
>>> +        return "settime64";
>>>        default:
>>>            return 0;
>>>        }
>>>
>>
>> If i understand it correctly, we negotiate xn_feature instead of abi
>> revision? In lib/cobalt/clock.c?
>>
> 
> Yes. New userspace will mandate the feature, old will not require it.
> Kernel can handle both cases, passively.
Ok, i will submit a new patch in lib/cobalt/clock.c after this one is 
accepted.

By the way, the other patches in my patch serial have no dependency on 
this, can they be accepted? Or any other comments?

chensong

> 
>> Another question is settime64 is the first step of y2038, clock_gettime
>> and others will come up, shall we have xn_feat_time64 for all of them?
> 
> Yes, good point.
> 
> Jan
> 



