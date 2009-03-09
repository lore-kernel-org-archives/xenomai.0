From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <2FD407A9-747D-44DD-AEE7-54AE200C99CA@comcast.net>
References: <1236608449.3587.32.camel@domain.hid>
	<2FD407A9-747D-44DD-AEE7-54AE200C99CA@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Mar 2009 11:19:17 -0400
Message-Id: <1236611957.3531.28.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-core] rt_queue_create in RT task?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Hi,

On Mon, 2009-03-09 at 10:36 -0400, Steven Seeger wrote:
> Andreas,
> 
> I do not know your situation but it is generally better to not  
> allocate things in realtime contexts because it is not deterministic.

Of course :) So my plan is to preallocate the memory for the
memory pool of all queues, for example with rt_heap_create.
To follow the example, I would pass the reference of the RT_HEAP
object to rt_queue_create which would call rt_heap_alloc to get 
the memory for its queue memory pool. Using RT_HEAP would create some
additional overhead, which currently doesn't worry me too much. 


> You may consider redesigning your applications to use pre-allocated  
> queues as it would be better overall.

Agreed. I consider it as last resort.

> 
> Regards,
> Steven

Thanks,
Andreas

> 
> On Mar 9, 2009, at 10:20 AM, Andreas Glatz wrote:
> 
> > Hi,
> >
> > Calling rt_queue_create in a real-time task is supposed to fail
> > according to the documentation.
> >
> > I found out, that the reason for this is, that the memory for
> > the queue memory pool is allocated with vmalloc/kmalloc.
> > Is there another reason?
> >
> > I still would like to be able to call rt_queue_create in a
> > real-time task in my activity of porting real-time applications
> > to Xenomai because I think that patching rt_queue_create would
> > be less time consuming than redesigning the applications.
> >
> > My approach to get there would be to split rt_queue_create into
> > two separate functions, one that allocates the memory pool
> > and another one which initializes the queue structure...
> >
> > Best regards,
> > Andreas
> >
> >
> >
> >
> > _______________________________________________
> > Xenomai-core mailing list
> > Xenomai-core@domain.hid
> > https://mail.gna.org/listinfo/xenomai-core
> 

