MIME-Version: 1.0
In-Reply-To: <55C22EED.4040704@xenomai.org>
References: <CAHoW4hFHAmGqFOdDp3QHXK-6w0NQEw8XBxOc8kJkVUQAvEfT_w@mail.gmail.com>
 <55C22EED.4040704@xenomai.org>
Date: Wed, 5 Aug 2015 12:34:30 -0400
Message-ID: <CAHoW4hFeFo1qgvVjNEekyn=b7Z3yAny+4nG5Yt0OTMd+cMt8xw@mail.gmail.com>
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

Sorry if this gets to you twice, I forgot to "Reply to all"

After applying the patch and rebuilding, my application still
segfaults at the same point, with the same error in my dmesg output.

For a little more info, here are the config flags I'm using to build
the libraries:
--with-core=cobalt
--disable-debug
--enable-pshared
--enable-registry=/home/ckiorpes/xen-userspace/
--enable-tls
--enable-smp

The issue occurs whether or not I disable the registry with the
--no-registry flag.


-Charles

On Wed, Aug 5, 2015 at 11:42 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On 05/08/2015 15:09, Charles Kiorpes wrote:
>> Hello,
>>
>> I am trying to port a fairly large application from Xenomai 2.6.4 to
>> Xenomai 3.0-rc6
>>
>> Most of the port has been decently painless, but there is one issue I
>> can't seem to get past.
>>
>> I am consistently getting ENOMEM errors and segfaults in
>> libcopperplate.so during rt_event_create(), and always at the same
>> spot in my application.
>>
>> If a segfault occurrs, the dmesg output from the segfault looks like this:
>> [   235.422300] PortProcess[1502]: segfault at f1b3ebeb ip b76c14b7 sp
>> bfeae498 error 5 in libcopperplate.so.0.0.0[b76b7000+14000]
>>
>> The application uses a large number of named event flag groups.  At
>> the time that the error occurs, it is looping to create 32 new named
>> event groups.
>>
>> I have increased these values in my kernel config:
>> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=4096
>> CONFIG_XENO_OPT_SYS_HEAPSZ=512
>> CONFIG_XENO_OPT_PRIVATE_HEAPSZ=128
>> CONFIG_XENO_OPT_SHARED_HEAPSZ=128
>>
>> When I dig through the /proc/xenomai filesystem, I see that:
>> - I am only using 383/4096 registry slots
>> - My system heap is about half full (284160KB free of 524288KB)
>> - My shared and private heaps are basically empty
>>
>> My application is launched with --mem-pool-size=400000.  The main heap
>> (in /registry/user/session/system) has about 220KB used at the point
>> that the error occurs.
>> Increasing the mem-pool-size does not change the behavior.  I have
>> also tried further increasing the values of my system (1024), private
>> (256), and shared (256) heapsizes, with no effect.
>>
>> Obviously I've missed something, but I can't figure out where the
>> error is occurring.
>>
>> System details:
>> OS: Debian Jessie 32-bit
>> Kernel: 3.18.12 - patched using Xenomai 3.0-rc6
>> System: Intel Xeon W3503 (x86 architecture)
>> I-Pipe version 1
>>
>
> Any improvement with this patch in?
>
> commit 574c8e2edb99ff523e765cdb8749dd5259784627
> Author: Philippe Gerum <rpm@xenomai.org>
> Date:   Wed Aug 5 16:08:23 2015 +0200
>
>     lib/cobalt: fix private event state accessor
>
> diff --git a/lib/cobalt/internal.c b/lib/cobalt/internal.c
> index 348ca14..62ecb4a 100644
> --- a/lib/cobalt/internal.c
> +++ b/lib/cobalt/internal.c
> @@ -426,7 +426,7 @@ struct cobalt_event_state
> *get_event_state(cobalt_event_t *event)
>  {
>         return event->flags & COBALT_EVENT_SHARED ?
>                 cobalt_umm_shared + event->state_offset :
> -               cobalt_umm_shared + event->state_offset;
> +               cobalt_umm_private + event->state_offset;
>  }
>
>  int cobalt_event_init(cobalt_event_t *event, unsigned int value,
>
>
>
> --
> Philippe.

