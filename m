References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <CAHoW4hHS2QS1td6mUiWid-unDrMDZaQMo3vkYsDynNze5YsaSw@mail.gmail.com>
 <55C326C5.4070608@xenomai.org>
 <CAHoW4hHityc2RSznYrqr4BHnTNSwjgYH7265jyqrjawmbXZKQQ@mail.gmail.com>
 <55C37BF3.2070609@xenomai.org>
 <CAHoW4hGq02Me+TuKVdvLi4W3GseeBA7DgFFajue-_D-gUh1wtg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55C8C82E.6050206@xenomai.org>
Date: Mon, 10 Aug 2015 17:50:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAHoW4hGq02Me+TuKVdvLi4W3GseeBA7DgFFajue-_D-gUh1wtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Charles Kiorpes <ckiorpes@gmail.com>
Cc: xenomai@xenomai.org

On 08/10/2015 03:52 PM, Charles Kiorpes wrote:
>> This may be a memory corruption issue, some metadata from the shared
>> heap got trashed earlier in the init sequence.
>>
>> Would it be practical to switch this app to the mercury core (no need
>> for preempt-rt, just a plain regular desktop kernel), only for the
>> purpose of running the init phase over valgrind? That would entail
>> stubbing/bypassing the hardware-related inits (e.g. drivers) if ever
>> possible.
> 
> I reconfigured to use Mercury, but I can't reproduce the error in this
> configuration.  There is no longer any segfault, or ENOMEM.
> 
> Despite being unable to reproduce the problem, Valgrind output
> indicates something funny happening when I call rt_event_create() on
> an object that already exists.
> 
> Here's the output from Valgrind of what occurs when I call
> rt_event_create() in pshared mode with an event that already exists
> (I've truncated some of the call stacks, this is all from one call to
> rt_event_create through a wrapper layer):
> 
> ==6204== Thread 36 Task32:
> ==6204== Invalid read of size 1
> ==6204==    at 0x40E1F10: __hash_key (hash.c:66)
> ==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
> ==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
> ==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
> ==6204==    by 0x4056C93: event_finalize (event.c:116)
> ==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
> ==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
> ==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
> ==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
> ==6204==    by 0x4057017: rt_event_create (event.c:218)
> ==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
> ==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)

Ok, this one is a double-deletion bug in an error path from
rt_create_event(). Will fix, thanks.

-- 
Philippe.

