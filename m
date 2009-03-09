From: Andreas Glatz <andreasglatz@domain.hid>
In-Reply-To: <49B53EE4.1030008@domain.hid>
References: <1236608449.3587.32.camel@domain.hid> <49B53EE4.1030008@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Mar 2009 12:37:32 -0400
Message-Id: <1236616652.3531.57.camel@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Hi,

On Mon, 2009-03-09 at 17:08 +0100, Philippe Gerum wrote:
> Andreas Glatz wrote:
> > Hi,
> > 
> > Calling rt_queue_create in a real-time task is supposed to fail
> > according to the documentation. 
> >
> 
> It fails from kernel space, otherwise, from user-space, your application would 
> simply be moved to a Linux context automatically for processing the 
> rt_queue_create() syscall.

Currently, we are developing in Userspace, so everything works fine. But
we still would like to have the option to run in kernel-space if for
some reason the user-space performance is too poor. 

> 
> > I found out, that the reason for this is, that the memory for 
> > the queue memory pool is allocated with vmalloc/kmalloc. 
> > Is there another reason?
> > 
> 
> No, that's the main reason, along with other Linux memory management ops to map 
> the pool to user-space if Q_SHARED is passed.

That's great :)

> 
> > I still would like to be able to call rt_queue_create in a 
> > real-time task in my activity of porting real-time applications
> > to Xenomai because I think that patching rt_queue_create would
> > be less time consuming than redesigning the applications.
> > 
> 
> You mean that it would be faster to hack rt_queue_create() than moving your 
> real-time code to userland? Well, probably, fair enough. However, you will 
> probably lose much more time debugging your port from kernel space than it would 
> have cost you to move it to user-space and benefit from the GDB support there. YMMV.

We have a Makefile based build system which generates a user-space
executable or a kernel-space module. The legacy code which I am porting
was written in C++. I had to add some "glue" code for being able to add
C++ code to a kernel module (don't tell Linus about it ;). The Xenomai
layer of the C++ part uses native API calls which are available both in
user- and kernel-space.
 
We decided to develop the application in user-space and after we are bug
free, we are thinking to move it to kernel space to compare the
performance of the application running in user- and kernel-space.

Everything works fine so far and we can switch between running in
user-space and kernel-space without any problems except that we are not
able to create RT_QUEUES in tasks in kernel-space. 

I'm convinced, that we never would have gotten that far without Xenomai
and it's very consistent and streamlined API!

> 
> > My approach to get there would be to split rt_queue_create into 
> > two separate functions, one that allocates the memory pool
> > and another one which initializes the queue structure... 
> >
> 
> Then don't work at RT_HEAP level, but rather manipulate the internal xnheap 
> object from the RT_QUEUE descriptor instead (bufpool). You would basically have 
> to change the bufpool field to become a pointer to the actual heap object, and 
> keep the rest unchanged.

Thank you for this tip!!


Regards, 
Andreas

