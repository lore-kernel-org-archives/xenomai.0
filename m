Date: Sat, 13 Dec 2008 21:33:58 +0200 (EET)
From: "Rus V. Brushkoff" <rus@domain.hid>
Message-ID: <Pine.LNX.4.64.0812132112260.17624@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] rt_heaps and PCI adress space
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


 	Hi,

  I'm using Xenomai-svn on x86, have two questions :

  - Can I supply to hardware (RT_HEAP_INFO).phys_addr after creating heap 
with H_DMA flag as I suplly it from pci_alloc_consistent() call ? Is it 
will be PCI bus addr ?

  - Someone created H_SHARED heap between kernel and user space - all is 
working perfect. Is it possible to supply to rt_heap_alloc() address 
of already allocated block ? For example - there is some block 
allocated/mapped from PCI hardware by ioremap(). So is it possible to 
write some kind of rt_heap_alloc_fixed(RT_HEAP *heap, size_t size, RTIME 
timeout, void *existing_buffer) that all the writes from userspace to 
this heap will write to kernel space at existing_buffer addr, and reads 
from userspace will read from this existing_buffer ? Please comment if 
'not' - why, if 'yes' - how ? ;)


 		Rus

