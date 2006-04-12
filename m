Message-ID: <443D5B2A.9080507@domain.hid>
Date: Wed, 12 Apr 2006 15:55:22 -0400
From: Randy Smith <rsmith@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Help with heap managment
References: <443D2A92.1000205@domain.hid>
In-Reply-To: <443D2A92.1000205@domain.hid>
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
Cc: xenomai@xenomai.org

Randy learns to make device nodes for rtheap and rtpXX.  Had to use 
strace -f to see that it was failing to open /dev/rtheap.  After these 
are in place problem goes away.

Randy Smith wrote:
> Hi everyone,
>
> Using the native skin, I have two heaps that I create in a kernel 
> module using rt_heap_create.  They are of type H_SHARED.  I can see 
> these in the /proc file system.  When I cat these files I get...
>
> bash-2.05b# cat 
> /proc/xenomai/registry/native/heaps/header                                                                                      
>
> type=shared:size=8192:used=8192
> bash-2.05b# cat /proc/xenomai/registry/native/heaps/uframe
> type=shared:size=538624:used=536576
>
> so I know they exist.
>
> Now, in my user space code, I am trying to use these shared memory 
> segments by first calling rt_heap_bind to get the uniform descriptor 
> to use in a subsequent rt_heap_alloc call, but the bind fails with an 
> errorcode of -2 which doesn't map to the return codes listed in the 
> documentation.
>
> Any clues?
>
> Am I using the correct calling sequence from user space?
>
> -Randy Smith
> Software Engineer
> ImageMap, Inc.
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

