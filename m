From: Sebastian Smolorz <smolorz@domain.hid>
Date: Fri, 15 May 2009 13:25:02 +0200
References: <0MKv5w-1M4tAX3kHn-0001tx@domain.hid>
In-Reply-To: <0MKv5w-1M4tAX3kHn-0001tx@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905151325.02473.smolorz@domain.hid>
Subject: Re: [Xenomai-help] problem with mutexes between kernel and
	user-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Dr. Kiriakos Athanasas" <athanasas@domain.hid>, xenomai@xenomai.org

Dr. Kiriakos Athanasas wrote:
> I had an application which run under kernel 2.6.26 and xeno 2.4.6 without
> any problems.
> I tried now kernel 2.6.28.7 and xeno 2.5.1 and have the following
> problem:
>
> inside a kernel module I create a mutex for locking an shared memory.
> from an user-task I want now to
>
> communicate over the protected shm. Therefore I bind to the mutex of the
> kernel-space
>
> when I call rt_mutex_acquire I get the failure EIDRM. Why the mutex seems
> to be deleted?
>
> rt_mutex_release causes a segmentation fault.
>
> What is my mistake?
>
>
> Here the code description of user space (it is really simple):
>
> err = rt_mutex_create(&eca_mutex,"Mutex1");

You said above that you created the mutex in kernel space. So why does this 
line appear in your user application? Remove this line and try again.

> err = rt_mutex_bind(&eca_mutex," Mutex1",TM_INFINITE);
>
> err = rt_mutex_acquire(&eca_mutex, TM_INFINITE);   // lock mutex
>
> memcpy(.);
>
> err = rt_mutex_release(&eca_mutex);               // unlock mutex
>

-- 
Sebastian


