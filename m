References: <20210327101912.2291474-1-rpm@xenomai.org>
 <20210327101912.2291474-6-rpm@xenomai.org>
 <f00e7b29-5d8d-cdcb-adeb-630c277f7d67@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2 5/7] drivers/net: wrap csum_partial_copy_nocheck()
In-reply-to: <f00e7b29-5d8d-cdcb-adeb-630c277f7d67@siemens.com>
Date: Thu, 15 Apr 2021 09:21:45 +0200
Message-ID: <87k0p4ui5y.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 27.03.21 11:19, Philippe Gerum wrote:
>> From: Philippe Gerum <rpm@xenomai.org>
>> 
>> Since v5.9-rc1, csum_partial_copy_nocheck() forces a zero seed as its
>> last argument to csum_partial(). According to #cc44c17baf7f3, passing
>> a non-zero value would not even yield the proper result on some
>> architectures.
>> 
>> Nevertheless, the current ICMP code does expect a non-zero csum seed
>> to be used in the next computation, so let's wrap net_csum_copy() to
>> csum_partial_copy_nocheck() for pre-5.9 kernels, and open code it for
>> later kernels so that we still feed csum_partial() with the user-given
>> csum. We still expect the x86, ARM and arm64 implementations of
>> csum_partial() to do the right thing.
>> 
>
> If that issue only affects the ICMP code path, why not only changing
> that, leaving rtskb_copy_and_csum_bits with the benefit of doing copy
> and csum in one step?
>

As a result of #cc44c17baf7f3, I see no common helper available from the
kernel folding the copy and checksum operations anymore, so I see no way
to keep rtskb_copy_and_csum_bits() as is. Did you find an all-in-one
replacement for csum_partial_copy_nocheck() which would allow a csum
value to be fed in?

-- 
Philippe.

