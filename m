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
From: Steve Freyder <steve@freyder.net>
Message-ID: <5B23F5FA.9040607@freyder.net>
Date: Fri, 15 Jun 2018 12:23:06 -0500
MIME-Version: 1.0
In-Reply-To: <f9318b36-50b4-aa44-0c8d-f0cf1e4e1e79@xenomai.org>
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

On 6/14/2018 11:52 AM, Philippe Gerum wrote:
> On 06/14/2018 06:41 PM, Steve Freyder wrote:
>> #2  0x76f418fc in shavl_search_inner (ops=0x76f56630 <size_search_ops>,
>> delta=0x76f418fc <add_free_range+216>, n=0x7eca29d4,
>>      avl=0x741f38ec) at
>> ../../../../xenomai-3/include/boilerplate/avl-inner.h:285
>> #3  shavl_search_nearest (ops=0x76f56630 <size_search_ops>, dir=1,
>> node=0x7eca29d4, avl=0x741f38ec)
>>      at ../../../../xenomai-3/include/boilerplate/avl-inner.h:395
>> #4  shavl_search_ge (ops=0x76f56630 <size_search_ops>, node=0x7eca29d4,
>> avl=0x741f38ec)
> The search operations parameter is last in the original code, but first
> in your backtrace. Does this mean that you had conflicts there and fixed
> them up manually? Since this is a new code, I'm unsure why you had such
> conflicts in the first place.
>
> Could you check with a pristine -next tree so that we may compare our
> results from the same code base?
>
> Thanks,
>
Philippe,

I went back to do a full git clone, checkout, patch, rebuild, and I
found that when I fetched the -next branch that the patch had been
comitted already.  So I proceeded to skip to the build step, and then
retest the simultaneous execution of two instances of the smokey
memory_pshared test, but still got the same failure.

Are you seeing the test failure with your build?

I've never had any reason to doubt the validity of my SDK or build
procedures, but if your build is passing the test, something must be
wrong on my end.

Steve


