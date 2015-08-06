References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <CAHoW4hHS2QS1td6mUiWid-unDrMDZaQMo3vkYsDynNze5YsaSw@mail.gmail.com>
 <55C326C5.4070608@xenomai.org>
 <CAHoW4hHityc2RSznYrqr4BHnTNSwjgYH7265jyqrjawmbXZKQQ@mail.gmail.com>
 <55C37BF3.2070609@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55C37CBA.6060703@xenomai.org>
Date: Thu, 6 Aug 2015 17:26:51 +0200
MIME-Version: 1.0
In-Reply-To: <55C37BF3.2070609@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>, xenomai@xenomai.org

On 08/06/2015 05:23 PM, Philippe Gerum wrote:
> On 08/06/2015 05:00 PM, Charles Kiorpes wrote:
>>> Could you --enable-debug, and have gdb determine the offending
>>> instruction? TIA,
>>
>> The gdb output is as follows:
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> get_free_range (heap=heap@entry=0x6dc07000, bsize=bsize@entry=256, log2size=8)
>>     at ../../../xenomai-3.0-rc6/lib/copperplate/heapobj-pshared.c:242
>> 242                                           freepage =
>> __shref_check(heap, *((memoff_t *)freepage));
>>
>> Thanks,
>> - Charles
>>
> 
> This may be a memory corruption issue, some metadata from the shared
> heap got trashed earlier in the init sequence.
> 
> Would it be practical to switch this app to the mercury core (no need
> for preempt-rt, just a plain regular desktop kernel), only for the
> purpose of running the init phase over valgrind? That would entail
> stubbing/bypassing the hardware-related inits (e.g. drivers) if ever
> possible.
> 

Also, does this bug happen with --disable-pshared?

-- 
Philippe.

