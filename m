References: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
 <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
 <d8f7d33e-a6fc-2911-56d8-f985981b1698@xenomai.org>
 <5B1EDD8E.2010707@freyder.net>
 <6d63abf1-0b15-5c55-5ab5-f0f424848dd3@xenomai.org>
 <5B201BCD.1060600@freyder.net>
 <f529188c-4a06-000c-985a-e46a30a919c1@xenomai.org>
 <5B21A065.3020707@freyder.net>
 <335b30c0-ceed-c9b2-841d-a0cad3a93f2d@xenomai.org>
 <7a1a9208-b1c3-a3fd-a40a-bb42c89669e7@xenomai.org>
 <5B229AAF.1040505@freyder.net>
 <f9318b36-50b4-aa44-0c8d-f0cf1e4e1e79@xenomai.org>
 <5B23F5FA.9040607@freyder.net>
 <6379939c-6a71-6640-05ed-808f9a7d601e@xenomai.org>
From: Steve Freyder <steve@freyder.net>
Message-ID: <5B2412A5.4080202@freyder.net>
Date: Fri, 15 Jun 2018 14:25:25 -0500
MIME-Version: 1.0
In-Reply-To: <6379939c-6a71-6640-05ed-808f9a7d601e@xenomai.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Performance issue with memory allocators
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 6/15/2018 1:26 PM, Philippe Gerum wrote:
> On 06/15/2018 07:23 PM, Steve Freyder wrote:
>> On 6/14/2018 11:52 AM, Philippe Gerum wrote:
>>> On 06/14/2018 06:41 PM, Steve Freyder wrote:
>>>> #2  0x76f418fc in shavl_search_inner (ops=0x76f56630 <size_search_ops>,
>>>> delta=0x76f418fc <add_free_range+216>, n=0x7eca29d4,
>>>>       avl=0x741f38ec) at
>>>> ../../../../xenomai-3/include/boilerplate/avl-inner.h:285
>>>> #3  shavl_search_nearest (ops=0x76f56630 <size_search_ops>, dir=1,
>>>> node=0x7eca29d4, avl=0x741f38ec)
>>>>       at ../../../../xenomai-3/include/boilerplate/avl-inner.h:395
>>>> #4  shavl_search_ge (ops=0x76f56630 <size_search_ops>, node=0x7eca29d4,
>>>> avl=0x741f38ec)
>>> The search operations parameter is last in the original code, but first
>>> in your backtrace. Does this mean that you had conflicts there and fixed
>>> them up manually? Since this is a new code, I'm unsure why you had such
>>> conflicts in the first place.
>>>
>>> Could you check with a pristine -next tree so that we may compare our
>>> results from the same code base?
>>>
>>> Thanks,
>>>
>> Philippe,
>>
>> I went back to do a full git clone, checkout, patch, rebuild, and I
>> found that when I fetched the -next branch that the patch had been
>> comitted already.  So I proceeded to skip to the build step, and then
>> retest the simultaneous execution of two instances of the smokey
>> memory_pshared test, but still got the same failure.
>>
>> Are you seeing the test failure with your build?
> No, that is why I've asked for a confirmation actually.
>
>> I've never had any reason to doubt the validity of my SDK or build
>> procedures, but if your build is passing the test, something must be
>> wrong on my end.
>>
> Not necessarily, maybe I got lucky because of some setting. I'll follow
> up on this when I have tested more configurations.
>
OK, I'll hold off on any further testing then.  My script that runs the
failing test looks like this:

ulimit -c unlimited
smokey --run=memory_pshared --verbose=2 --mem-pool-size=32M --session=foo

It ran multiple instances simultaneously just fine by omitting the
"--session=foo" switch, and with a mem-pool-size of anything above
1M.  When I ran it with --mem-pool-size=1M I got this:

# smokey --run=memory_pshared --verbose=2 --mem-pool-size=1M
== memcheck started for pshared at Thu Jan  1 03:30:37 1970

      seq_heap_size=2048k
      random_alloc_rounds=1024
      pattern_heap_size=128k
      pattern_check_rounds=128
smokey: test memory_pshared failed: Cannot allocate memory
    2"957.744| WARNING: [smokey] heapobj_init() failed for 1073352 
bytes, raise --mem-pool-size?
cannot get arena size for heap size 1048576
failed with 1024k heap, 16-byte block (pow2)

Here's some md5sums of files in case a spot-check is desired.

ba840ed4e41eace931c9f0248c987455  boilerplate/hash.c
cc5e252def896e0c004300b4f064b027  boilerplate/init/bootstrap.c
1c000d2f10dd4dfff07615de67cd193f  boilerplate/time.c
87d328c980f6a2e29f91f35d8dad99b4  boilerplate/setup.c
db1d59e47276d2f9ccf24a8697b05392  boilerplate/heapmem.c
c865d144a6b66d6c91708fbf276ae8e2  boilerplate/version.c
bcf2d4e53b87234c6cd6b28041ace6a3  boilerplate/ancillaries.c
3965251ffae674ed309404d867c9d079  boilerplate/tlsf/target.h
756dc570297f040d7bc1caec469fc096  boilerplate/tlsf/tlsf.h
1e68c9c9ca007695525e02f590f4ac93  boilerplate/tlsf/tlsf.c
cdf8be823f34a6e3e3112c024661c7c2  boilerplate/avl.c
7fc35586913521a09af968f05a34b8fe  boilerplate/debug.c
8c53c85f833fede10b8e0cb72f04269b  boilerplate/obstack.c
92a0d40e0380f9cead5a9ab87cfaa4c4  boilerplate/iniparser/dictionary.c
1b3b25f95882b4fce0d4c4eff210f372  boilerplate/iniparser/iniparser.h
83af9baca0f626da90d8a09f884a7027  boilerplate/iniparser/iniparser.c
f7c0360cf72df3002ed788d7a5ddd9b8  boilerplate/iniparser/dictionary.h
5cb8c715c7809d0b3a94a3a06925e08d  copperplate/eventobj.c
407998c2014e266566d8c05d36323998  copperplate/traceobj.c
eb01e780a57d569b7d65f73251cb3cb6  copperplate/timerobj.c
7dfc2ecd12cdfe7f4a68067b9fda8d7c  copperplate/reference.c
bf4ea39ea64567f071275450a8382bdf  copperplate/cluster.c
bfc0cad74e628595f9213283bd269b5c  copperplate/heapobj-tlsf.c
db4503787648ee50348f5dd9b945633e  copperplate/registry.c
ce88c54091eb157ab17f062df4d9ec5f  copperplate/init.c
877a34a35a46910c26c50c219967797f  copperplate/semobj.c
eecaa499b53571e59b8b67ef3f38622d  copperplate/clockobj.c
5da1685ad689ad2f155052cc69900d85  copperplate/heapobj-heapmem.c
c79587e01dec3642feb6583e534bcb4d  copperplate/syncobj.c
141b9f0db30e0f078da92d67ba94cc04  copperplate/heapobj-malloc.c
0538925a54a8eddd5640d4fba92baa32  copperplate/internal.h
83d01f4d66739d24f63a955bd8fb739b  copperplate/heapobj-pshared.c
3071943e15a939f503d426c40e3537f2  copperplate/regd/fs-cobalt.c
7509b7c943fa4cd831799e7165241da6  copperplate/regd/fs-mercury.c
038b214b224caf05ec6faf0aa60ebcca  copperplate/regd/sysregfs.h
977e6dc243748b60a743612f76744e7f  copperplate/regd/fs-common.c
16a481fe0a895ff732cae61dd9cc5912  copperplate/regd/regd.c
5f9b01f80c4edf99331accd5a6dc8cc3  copperplate/threadobj.c
34e6ccd1241a663fe54fbd03eb7d516b  copperplate/internal.c

Thanks,
Steve


