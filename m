From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17586.28969.44700.753766@domain.hid>
Date: Mon, 10 Jul 2006 17:24:25 +0200
Subject: Re: [Xenomai-help] memset of heap crashes Xenomai-Task
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A3F91A5@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F91A5@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
 > Xenomai Version : 2.2-rc2
 > Skin : native
 > Kernel : 2.4.25
 > Arch.: PPC
 > 
 > I try to allocate as much memory as possible with the functions :
 > rt_heap_create and
 > rt_heap_alloc.
 > (see also "Xenomai heap services" in this mailing list; see source
 > attached)
 > 
 > When I try to use the allocated memory with memset, the Xenomai-task
 > crashes with a "Segmentation fault".
 > 
 > Is memset allowed to be used with Xenomai heaps ?

memset should work with Xenomai heaps, I suspect your problem is rather
that the memory is not really allocated until you memset it, which fails
when no memory is available. In this case, calling memset on memory
allocated with malloc should segfault the same way when the system
memory is exhausted. IIRC, this behaviour is documented in mlockall
manual page.

Be careful with sysconf(_SC_AVPHYS_PAGES), it may include the swap size,
but when mlocking memory, your application can not use swap pages, so,
you should substract the size of swap, if any.
Also, what is the value of /proc/sys/vm/overcommit_memory on your system
?

-- 


					    Gilles Chanteperdrix.

