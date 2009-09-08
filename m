From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1252420689.4304.35.camel@domain.hid>
References: <1252420689.4304.35.camel@domain.hid>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 17:31:12 +0200
Message-Id: <1252423872.2693.84.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_heap cleanup issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christoph Permes <christoph.permes@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-09-08 at 16:38 +0200, Christoph Permes wrote:
> Hi,
> 
> I have a kernel module that allocates a shared memory and a non-realtime
> userspace application that reads data from the shared memory.
> 
> When loading and unloading kernel module and application multiple times,
> sometimes the shared memory is not cleaned up. The shared memory remains
> in /proc/xenomai/registry/native/heaps with size=0. A try to load the
> module again results in a kernel null pointer exception.

> There is no null pointer exception when killing the application before
> rmmod.
> 
> Is it generally a problem if kernel modules are unloaded before all
> applications that use the shared memory are terminated?

Actually, you should not be able to do that at all. The bug here is that
we should prevent you from unloading the module until all apps have
removed their references on the heap.

> With userspace realtime applications cleanup works without any problems
> regardless of the order the applications are started/terminated.
> Maybe I am doing something wrong in the example code above?
> 
> As my real application consists of several userspace applications
> (realtime and non-realtime) the startup and shutdown procedure is more
> complex so that it is not guaranteed that all userspace applications are
> finished when the kernel module is unloaded.
> 
> Thanks,
> 
> Christoph
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



