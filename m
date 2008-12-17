Date: Wed, 17 Dec 2008 15:24:18 +0200 (EET)
From: "Rus V. Brushkoff" <rus@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0812132112260.17624@domain.hid>
Message-ID: <Pine.LNX.4.64.0812171513040.22184@domain.hid>
References: <Pine.LNX.4.64.0812132112260.17624@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Xenomai-help] rt_heaps and PCI adress space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Sat, 13 Dec 2008, Rus V. Brushkoff wrote:

Replying to myself:

: - Can I supply to hardware (RT_HEAP_INFO).phys_addr after creating heap with
:H_DMA flag as I suplly it from pci_alloc_consistent() call ? Is it will be PCI
:bus addr ?

Seems like this value need to be passed to pci_map_single/dma_map_single

: - Someone created H_SHARED heap between kernel and user space - all is working
:perfect. Is it possible to supply to rt_heap_alloc() address of already
:allocated block ? For example - there is some block allocated/mapped from PCI
:hardware by ioremap(). So is it possible to write some kind of
:rt_heap_alloc_fixed(RT_HEAP *heap, size_t size, RTIME timeout, void
:*existing_buffer) that all the writes from userspace to this heap will write to
:kernel space at existing_buffer addr, and reads from userspace will read from
:this existing_buffer ? Please comment if 'not' - why, if 'yes' - how ? ;)

 No it is impossible, as rt_heap_alloc use special data structures for 
heaps, where buffers (pages) are only part of them. May be with special 
allocator written - where headers and page maps allocated in one region 
memory and pages located in another - it will be possible.

:
:

		Rus

