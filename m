MIME-Version: 1.0
In-Reply-To: <55C37BF3.2070609@xenomai.org>
References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
 <CAHoW4hHS2QS1td6mUiWid-unDrMDZaQMo3vkYsDynNze5YsaSw@mail.gmail.com>
 <55C326C5.4070608@xenomai.org>
 <CAHoW4hHityc2RSznYrqr4BHnTNSwjgYH7265jyqrjawmbXZKQQ@mail.gmail.com>
 <55C37BF3.2070609@xenomai.org>
Date: Mon, 10 Aug 2015 09:52:43 -0400
Message-ID: <CAHoW4hGq02Me+TuKVdvLi4W3GseeBA7DgFFajue-_D-gUh1wtg@mail.gmail.com>
From: Charles Kiorpes <ckiorpes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Segfaults and ENOMEM during rt_event_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

> This may be a memory corruption issue, some metadata from the shared
> heap got trashed earlier in the init sequence.
>
> Would it be practical to switch this app to the mercury core (no need
> for preempt-rt, just a plain regular desktop kernel), only for the
> purpose of running the init phase over valgrind? That would entail
> stubbing/bypassing the hardware-related inits (e.g. drivers) if ever
> possible.

I reconfigured to use Mercury, but I can't reproduce the error in this
configuration.  There is no longer any segfault, or ENOMEM.

Despite being unable to reproduce the problem, Valgrind output
indicates something funny happening when I call rt_event_create() on
an object that already exists.

Here's the output from Valgrind of what occurs when I call
rt_event_create() in pshared mode with an event that already exists
(I've truncated some of the call stacks, this is all from one call to
rt_event_create through a wrapper layer):

==6204== Thread 36 Task32:
==6204== Invalid read of size 1
==6204==    at 0x40E1F10: __hash_key (hash.c:66)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a2d is 5 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F14: __hash_key (hash.c:66)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a2e is 6 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F20: __hash_key (hash.c:66)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a2c is 4 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F26: __hash_key (hash.c:66)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a2f is 7 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F2F: __hash_key (hash.c:67)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a31 is 9 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F35: __hash_key (hash.c:67)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a32 is 10 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F41: __hash_key (hash.c:67)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
...
==6204==    by 0x80B87BC: SMCCommandHandler (AswLibSv.c:230)
==6204==  Address 0x4434a30 is 8 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F47: __hash_key (hash.c:67)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a33 is 11 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F50: __hash_key (hash.c:65)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a29 is 1 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F56: __hash_key (hash.c:65)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a2a is 2 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F62: __hash_key (hash.c:65)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a28 is 0 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E1F67: __hash_key (hash.c:65)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a2b is 3 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E2044: __hash_key (hash.c:84)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a42 is 26 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E204D: __hash_key (hash.c:85)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a41 is 25 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid read of size 1
==6204==    at 0x40E2056: __hash_key (hash.c:86)
==6204==    by 0x40E2F55: do_pvhash (hash.c:371)
==6204==    by 0x40E2F55: pvhash_remove (hash.c:417)
==6204==    by 0x40739E6: registry_destroy_file (registry.c:255)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a40 is 24 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==
==6204== Invalid free() / delete / delete[] / realloc()
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x4056C93: event_finalize (event.c:116)
==6204==    by 0x406A17A: eventobj_finalize (eventobj.c:150)
==6204==    by 0x406B022: __syncobj_finalize (syncobj.c:294)
==6204==    by 0x406BD75: syncobj_destroy (syncobj.c:573)
==6204==    by 0x406A290: eventobj_destroy (eventobj.c:182)
==6204==    by 0x4057017: rt_event_create (event.c:218)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==  Address 0x4434a28 is 0 bytes inside a block of size 28 free'd
==6204==    at 0x402A3A8: free (vg_replace_malloc.c:473)
==6204==    by 0x4073A1E: pvfree (heapobj.h:159)
==6204==    by 0x4073A1E: registry_destroy_file (registry.c:265)
==6204==    by 0x405700D: rt_event_create (event.c:217)
==6204==    by 0x81942C0: RtosCreateNamedEvent (RtosXenomai3.c:279)
==6204==    by 0x80D67FD: CallbackInterruptEventOpen (Callbacks.c:488)
...
==6204==    by 0x8182909: TaskThread (TaskEngine.c:151)
==6204==    by 0x405A083: task_entry (task.c:237)
==6204==    by 0x406AEC2: thread_trampoline (internal.c:233)
==6204==    by 0x4086EFA: start_thread (pthread_create.c:309)
==6204==    by 0x432962D: clone (clone.S:129)
==6204==

Sorry for the long output.

This can be worked around by attempting an rt_event_bind() first and
only attempting to create the event if bind fails.

The above is the only complaint from Valgrind.

>Also, does this bug happen with --disable-pshared?

I am unable to run this application without pshared, because there are
two processes that need to signal each other using real-time events.

Thanks,
Charles

