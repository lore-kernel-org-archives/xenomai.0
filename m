Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Stefan Schaal <sschaal@domain.hid>
In-Reply-To: <1E9219AE-B3C3-49D8-8625-CBC768C8E4EF@usc.edu>
Date: Mon, 2 Nov 2009 11:22:04 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <1F88BE18-9D5E-4B96-B60E-3E9733778999@domain.hid>
References: <E65E9416-A152-4EFE-93C8-31A123514B6E@usc.edu>	<195F4A80-1B62-4673-804B-71CC6F6DD60C@usc.edu>
	<84E78C77-1DC1-44EE-8703-62C89A204B81@domain.hid>
	<4AEE8D8A.5030108@domain.hid>
	<1E9219AE-B3C3-49D8-8625-CBC768C8E4EF@usc.edu>
Subject: Re: [Xenomai-core] lots of mode switches in xenomai-head tree?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Schaal <sschaal@domain.hid>
Cc: Jonas Buchli <jonas@domain.hid>, Peter Pastor Sampedro <pastorsa@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Hi Jan,

   you pointer to the 4a2cb7b817 help! We had  -lrtdk  before - 
lpthread -lpthread_rt in our compile statement. Just in 2.4.8, this  
seems to make no difference.

-Stefan


On Nov 2, 2009, at 10:42, Stefan Schaal wrote:

> Hi Jan,
>
>  we updated the git on Oct. 29 (3 days ago). We do use the posix  
> skin, i.e., we use the xeno-config --posix-ldflags. This worked all  
> fine without mode switches under Xenomai 2.4.8. My git does include  
> 4a2cb7b817. I will try to reproduce the error in a test program.
>
> -Stefan
>
>
> On Nov 1, 2009, at 23:43, Jan Kiszka wrote:
>
>> Stefan Schaal wrote:
>>> Hi,
>>>
>>>  I am working with the latest xenomai-head tree (we need analogy for
>>> our NI board ...). Under Xenomai 2.4.8 our code did not have any  
>>> mode
>>> switches. Using the xenomai-head, we get a lot of mode switches.  
>>> Using
>>> he backtrace_symbols_fd, we get print-outs like:
>>>
>>>
>>> xsimulation[0x808553b]
>>> [0xffffe400]
>>> /usr/xenomai/lib/librtdk.so.0(assert_nrt+0x85)[0xb7fa2ea5]
>>> /usr/xenomai/lib/librtdk.so.0(__wrap_clock_gettime+0x17)[0xb7fa2ef7]
>>> xsimulation[0x807cd16]
>>> xsimulation[0x807d7fb]
>>> /usr/xenomai/lib/libnative.so.3[0xb7fab689]
>>> /lib/tls/i686/cmov/libpthread.so.0[0xb7f824ff]
>>> /lib/tls/i686/cmov/libc.so.6(clone+0x5e)[0xb7e8f49e]
>>>
>>> Which indicates that the wrapper for clock_gettime causes this
>>> trouble, which is also confirmed by commenting clock_gettime out,  
>>> and
>>> the  mode switches disappear.
>>>
>>> Maybe something that needs fixing?
>>
>> Do you wrap & link against the POSIX library, ie. use that skin as  
>> well?
>> If not, your code is actually using clock_gettime incorrectly as it  
>> then
>> falls back to the Linux service which can trigger syscalls (or even
>> deadlocks when the TSC is used).
>>
>> If you do use libpthread_rt, then my next question is if your work is
>> based on today's git head or some older version not including  
>> 4a2cb7b817.
>>
>> Jan
>>
>
>


