Message-ID: <442D8DF9.2050802@domain.hid>
Date: Fri, 31 Mar 2006 22:15:53 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Questions porting existing rtai-24.1.12 app to
	xenomai
References: <442D8580.9020507@domain.hid>
In-Reply-To: <442D8580.9020507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Randy Smith <rsmith@domain.hid>
Cc: xenomai@xenomai.org

Randy Smith wrote:
> Hello list,
> 
> I'm confused and I hope someone can illuminate a path to enlightenment.  
> Please be gentle. :-)
> 
> I have inherited some linux 2.4.25 kernel module code for a powerpc that 
> uses rtai-24.1.12.  In my xenomai enabled kernel, I have disabled native 
> support and enabled the RTAI emulator.  This works as far as I know.  I 
> can insmod it at least but to test it, I need some user mode code and 
> that is where I am running into problems.
> 
> The kernel module runs as a periodic task and uses kernel mode shared 
> memory to communicate with the user mode application.  The user mode 
> application uses rtai_malloc to allocate the shared memory that the 
> kernel module created with rtai_kmalloc.  My application fails to link 
> since librtai.so cannot resolve the call to rtai_malloc.  What should I 
> migrate the rtai_malloc call to in order to use the rtai skin with 
> xenomai??

The thing is that the RTAI emulator provided currently covers a minimal 
set of kernel-space only RTAI services, and does not provide any 
user-space interface to these calls. The librtai.so library that would 
contain the user-space interface mimicking LXRT is actually empty, and 
basically a placeholder, waiting for someone to be motivated enough to 
extend the existing support and flesh it. (hint, hint...).

> 
> Can I not communicate kernel to user via shared memory in that skin?
> 

No, but you could use a combo with the POSIX skin which provides a 
complete shm support to create the shared segment, and make your 
kernel-based RTAI tasks tap into this memory. The user-space side would 
just need to bind to this segment using the regular Xenomai support the 
POSIX skin provides to user-space. This still would not bring you the 
LXRT support, but it would allow you to access the shared memory block 
from user-space.

I.e.

- A kernel module using the POSIX skin creates a shared memory segment 
in kernel space, and exports it as a global variable;
- A kernel module implementing your RTAI application taps into this 
segment by importing its address from the variable.
- A user-space process linking with the POSIX skin real-time services in 
user-space (libpthread_rt.so) binds itself to this segment and peeks at 
the shared memory.

Not pretty, but still a bit simpler than creating your own memory mapped 
pseudo-device.

> I get the feeling that this is an old api that xenomai doesn't support, 
> is this the case?
> 

In fact, it's just that the RTAI emulator over Xenomai currently 
provides only a small subset of the > 300 routines the original RTAI API 
exports, and solely in kernel space. The reason for that is likely that 
people porting from the RTAI API to Xeno usually switch to Xeno's native 
API directly.

> Any help would be appreciated.
> 
> Thanks,
> 
> -Randy Smith
> Software Engineer
> ImageMap, Inc.
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

