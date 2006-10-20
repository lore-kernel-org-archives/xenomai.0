Subject: Re: [Xenomai-core] [PATCH 0/2] Selectable heap allocators
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <453911D4.8060901@domain.hid>
References: <453911D4.8060901@domain.hid>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 01:56:58 +0200
Message-Id: <1161388618.4988.198.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Miguel Angel Masmano Tello <mimastel@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2006-10-20 at 20:13 +0200, Jan Kiszka wrote:
> Hi,
> 
> here comes a patch series for an idea I have in mind for quite some
> time: break up the nucleus heap layer so that it can support different
> allocation schemes. Motivated was this idea by the great TLSF allocator
> by Miguel Masmano et al.
> 
> I once played with TLSF in userspace as a malloc replacement for RT
> apps, and I wondered if we shouldn't make use of it as well in the
> nucleus. It's most beautiful property is its strict O(1) complexity in
> my eyes, but it seems to provide even more qualities: less
> fragmentation, less overhead, maybe even better performance.
> 
> I haven't done any thorough analysis on those advantages (I'm counting
> on Miguel and others to prove them ;) ), only stability tests over the
> last weeks and a simple comparisons of the overhead. With 8 user-space
> tasks, a few mutexes, 8 RTDM sockets, and likely some other stuff
> allocated I get e.g. these usage numbers:

> bsdalloc:
> size=524288:used=17720:pagesz=512
> 
> tlsfalloc:
> size=524288:used=14036:pagesz=512
> 

I'm ok to merge different allocators - and the needed infrastructure to
support that - provided having several of them actually buys us
something significant, maybe depending on some usage patterns. Actually,
I once made the basic assumption that the BSDish heap could fulfill any
kind of allocation requirements for all the use cases we should care
about; maybe I was wrong, in which case, we should discuss of the
particular issue of introducing an abstract layer to support several
allocators. If the assumption remains unchallenged, then we don't need
to abstract this, and the issue boils down to whether we should switch
to TLSF or keep BSD.

This also means that we first need real figures for practical use cases
comparing BSD and TLSF, before going any step further (at least internal
and external fragmentation values, allocation and deallocation
worst-case for bulks of contiguous and discontiguous blocks from various
sizes, and anything else you may find relevant). At that point, we could
decide whether we should provide both over the abstract infrastructure,
simply replace BSD with TLSF, or keep the status quo.

> 
> This patch series now first tries to abstract a common interface for
> heap allocators. Those allocators can be statically selected at compile
> time. As the second step it adds latest TLSF version 2.2.0 as an
> alternative to BSD. Default remains BSD for now.
> 
> TLSF is currently limited to 32-bit archs, but 64-bit support is on the
> roadmap according to Miguel. He kindly helped me with preparing the TLSF
> patch for Xenomai usage. Thanks to him at this point!
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



