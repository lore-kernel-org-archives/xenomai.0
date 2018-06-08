From: Philippe Gerum <rpm@xenomai.org>
References: <bd6a8257-9986-df8b-182d-b1b5d41e3a2a@xenomai.org>
 <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
Message-ID: <d8f7d33e-a6fc-2911-56d8-f985981b1698@xenomai.org>
Date: Fri, 8 Jun 2018 14:48:29 +0200
MIME-Version: 1.0
In-Reply-To: <41222b4c-b99c-2745-f1df-f00785c52104@xenomai.org>
Content-Type: text/plain; charset=utf-8
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
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>

On 05/20/2018 08:15 PM, Philippe Gerum wrote:
> On 04/27/2018 08:23 PM, Philippe Gerum wrote:
>>
>> After a comprehensive series of tests, it is now obvious that
>> heapobj-pshared has gruesome performances when releasing bursts of
>> small-sized objects. Allocation of large objects is not particularly
>> efficient either, although not as bad. The Cobalt core allocator is
>> affected by the same bug too.
>>
>> Those new tests are available from the wip/heapmem branch, they are
>> based on the smokey framework (e.g. smokey --run=memory_* --verbose=2).
>>
>> Work is ongoing into the wip/heapmem branch to fix the mess, first
>> addressing the issue with the core (in-kernel) allocator,
>> heapobj-pshared next. Please note that wip/heapmem is a development
>> branch I'm working on for testing improvements - hopefully - to the
>> memory allocators, which should not be used in production.
>>
>> I would strongly recommend that users running single-process
>> applications - i.e. not needing the shared heap feature - make sure to
>> turn off heapobj-pshared when configuring, by passing --disable-pshared
>> to the configuration script (or leave the feature to the default off state).
>>
> > As the benchmark figures show when running 'memory_pshared', the shared
> memory allocator still needs to be fixed. This is next on my list.
The pshared allocator is now fixed in the next branch.

-- 
Philippe.

