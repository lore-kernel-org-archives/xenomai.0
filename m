Message-ID: <439C6CB9.6050605@domain.hid>
Date: Sun, 11 Dec 2005 19:15:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Extensible heaps - needed for the future?
References: <439C654F.9080805@domain.hid>
In-Reply-To: <439C654F.9080805@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> I noticed that xnhead_extend() is not used at the moment [1], thus the
> whole extent management is redundent for now. Are there plans to use it
> in the future? Should we keep this feature?
> 
> I'm asking as I still have the idea in my head of breaking up the heap
> service and introducing a generic allocator interface to select
> different heap allocators at compile time. So, should extensions be an
> optional feature of an allocator?

Keep in mind that the native API is a plain client of the abstract RTOS 
implemented by the nucleus, nothing more. What the native API does not 
use in this area would probably be useful to other clients though. For 
instance, the VRTX skin locally reimplements its own heap extension 
system that could be replaced by the nucleus one -- and should.

> 
> Jan
> 
> 
> [1]http://www.rts.uni-hannover.de/xenomai/lxr/ident?v=SVN-trunk;i=xnheap_extend
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

