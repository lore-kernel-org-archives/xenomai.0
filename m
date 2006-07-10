MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17586.37686.544589.640678@domain.hid>
Date: Mon, 10 Jul 2006 19:49:42 +0200
Subject: Re: [Xenomai-help] memset of heap crashes Xenomai-Task
In-Reply-To: <44B29100.4070206@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A3F91A5@domain.hid>
	<17586.28969.44700.753766@domain.hid>
	<44B29100.4070206@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Roderik_Wildenburg@domain.hid, xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Roderik_Wildenburg@domain.hid wrote:
 > >  > Xenomai Version : 2.2-rc2
 > >  > Skin : native
 > >  > Kernel : 2.4.25
 > >  > Arch.: PPC
 > >  > 
 > >  > I try to allocate as much memory as possible with the functions :
 > >  > rt_heap_create and
 > >  > rt_heap_alloc.
 > >  > (see also "Xenomai heap services" in this mailing list; see source
 > >  > attached)
 > >  > 
 > >  > When I try to use the allocated memory with memset, the Xenomai-task
 > >  > crashes with a "Segmentation fault".
 > >  > 
 > >  > Is memset allowed to be used with Xenomai heaps ?
 > > 
 > > memset should work with Xenomai heaps, I suspect your problem is rather
 > > that the memory is not really allocated until you memset it, which fails
 > > when no memory is available. In this case, calling memset on memory
 > > allocated with malloc should segfault the same way when the system
 > > memory is exhausted. IIRC, this behaviour is documented in mlockall
 > > manual page.
 > 
 > I wonder if this "virtual allocation" also applies to vmalloc'ed memory
 > like in this case. I don't think so, or the kernel would oops as well.

On some architectures vmalloced memory is only added to a process page
directory when the fault occurs. I do not know if the RAM allocation is
delayed until then, though.

-- 


					    Gilles Chanteperdrix.

