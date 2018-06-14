From: Philippe Gerum <rpm@xenomai.org>
References: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
 <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
 <d8f7d33e-a6fc-2911-56d8-f985981b1698@xenomai.org>
 <5B1EDD8E.2010707@freyder.net>
 <6d63abf1-0b15-5c55-5ab5-f0f424848dd3@xenomai.org>
 <5B201BCD.1060600@freyder.net>
 <f529188c-4a06-000c-985a-e46a30a919c1@xenomai.org>
 <5B21A065.3020707@freyder.net>
 <335b30c0-ceed-c9b2-841d-a0cad3a93f2d@xenomai.org>
Message-ID: <7a1a9208-b1c3-a3fd-a40a-bb42c89669e7@xenomai.org>
Date: Thu, 14 Jun 2018 17:21:22 +0200
MIME-Version: 1.0
In-Reply-To: <335b30c0-ceed-c9b2-841d-a0cad3a93f2d@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
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
To: Steve Freyder <steve@freyder.net>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/14/2018 03:10 PM, Philippe Gerum wrote:
> On 06/14/2018 12:53 AM, Steve Freyder wrote:
>> I rebuilt my program with a 512K stack, same problem with the SEGV.
>>
>> Tried something different, without running my application at all, I ran
>> this script:
>>
>> ulimit -c unlimited
>> smokey --run=memory_pshared --verbose=2 --mem-pool-size=32M --session=foo
>>
>> it ran fine, but if I ran it a second time, without waiting for the
>> first invocation to
>> finish, then I got the same SEGV that I previously was seeing with my
>> program and the
>> traceback looks the same.
>>
>> It's as if there's an initialization issue when you're not the creator
>> of the
>> pshared heap.
>>
>>
> 
> Yeah, this can't work just yet. Implementation blunder. I'll follow up
> on this.
> 

Could you check if the situation gets any better with this change in?

http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=7e3d69ae6c9235289a8984b609ae2400ab950f17

Thanks,

-- 
Philippe.

