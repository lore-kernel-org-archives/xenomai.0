Message-ID: <49B53EE4.1030008@domain.hid>
Date: Mon, 09 Mar 2009 17:08:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1236608449.3587.32.camel@domain.hid>
In-Reply-To: <1236608449.3587.32.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rt_queue_create in RT task?
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: xenomai@xenomai.org

Andreas Glatz wrote:
> Hi,
> 
> Calling rt_queue_create in a real-time task is supposed to fail
> according to the documentation. 
>

It fails from kernel space, otherwise, from user-space, your application would 
simply be moved to a Linux context automatically for processing the 
rt_queue_create() syscall.

> I found out, that the reason for this is, that the memory for 
> the queue memory pool is allocated with vmalloc/kmalloc. 
> Is there another reason?
> 

No, that's the main reason, along with other Linux memory management ops to map 
the pool to user-space if Q_SHARED is passed.

> I still would like to be able to call rt_queue_create in a 
> real-time task in my activity of porting real-time applications
> to Xenomai because I think that patching rt_queue_create would
> be less time consuming than redesigning the applications.
> 

You mean that it would be faster to hack rt_queue_create() than moving your 
real-time code to userland? Well, probably, fair enough. However, you will 
probably lose much more time debugging your port from kernel space than it would 
have cost you to move it to user-space and benefit from the GDB support there. YMMV.

> My approach to get there would be to split rt_queue_create into 
> two separate functions, one that allocates the memory pool
> and another one which initializes the queue structure... 
>

Then don't work at RT_HEAP level, but rather manipulate the internal xnheap 
object from the RT_QUEUE descriptor instead (bufpool). You would basically have 
to change the bufpool field to become a pointer to the actual heap object, and 
keep the rest unchanged.

> Best regards,
> Andreas
> 
> 
>  
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 
Philippe.

