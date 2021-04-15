Subject: Re: [PATCH v2 5/7] drivers/net: wrap csum_partial_copy_nocheck()
References: <20210327101912.2291474-1-rpm@xenomai.org>
 <20210327101912.2291474-6-rpm@xenomai.org>
 <f00e7b29-5d8d-cdcb-adeb-630c277f7d67@siemens.com>
 <87k0p4ui5y.fsf@xenomai.org>
 <ce95f3e8-7bdc-c94f-8814-d6af1c3e5d71@siemens.com>
 <878s5kugo7.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8c69e790-a094-7c96-c5b0-d71899cfc4f9@siemens.com>
Date: Thu, 15 Apr 2021 10:10:22 +0200
MIME-Version: 1.0
In-Reply-To: <878s5kugo7.fsf@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 15.04.21 09:54, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 15.04.21 09:21, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> On 27.03.21 11:19, Philippe Gerum wrote:
>>>>> From: Philippe Gerum <rpm@xenomai.org>
>>>>>
>>>>> Since v5.9-rc1, csum_partial_copy_nocheck() forces a zero seed as its
>>>>> last argument to csum_partial(). According to #cc44c17baf7f3, passing
>>>>> a non-zero value would not even yield the proper result on some
>>>>> architectures.
>>>>>
>>>>> Nevertheless, the current ICMP code does expect a non-zero csum seed
>>>>> to be used in the next computation, so let's wrap net_csum_copy() to
>>>>> csum_partial_copy_nocheck() for pre-5.9 kernels, and open code it for
>>>>> later kernels so that we still feed csum_partial() with the user-given
>>>>> csum. We still expect the x86, ARM and arm64 implementations of
>>>>> csum_partial() to do the right thing.
>>>>>
>>>>
>>>> If that issue only affects the ICMP code path, why not only changing
>>>> that, leaving rtskb_copy_and_csum_bits with the benefit of doing copy
>>>> and csum in one step?
>>>>
>>>
>>> As a result of #cc44c17baf7f3, I see no common helper available from the
>>> kernel folding the copy and checksum operations anymore, so I see no way
>>> to keep rtskb_copy_and_csum_bits() as is. Did you find an all-in-one
>>> replacement for csum_partial_copy_nocheck() which would allow a csum
>>> value to be fed in?
>>>
>>
>> rtskb_copy_and_csum_dev does not need that.
>>
> 
> You made rtskb_copy_and_csum_bits() part of the exported API. So how do
> you want to deal with this?
> 

That is an internal API, so we don't care.

But even if we converted rtskb_copy_and_csum_bits to work as it used to
(with a csum != 0), there would be not reason to make
rtskb_copy_and_csum_dev pay that price.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

