From: Jeff Webb <jeff.webb@nta-inc.net>
Message-ID: <b82b1342-701b-57de-e749-73b2f6882ee9@nta-inc.net>
Date: Mon, 7 Aug 2017 10:08:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] UDD framework
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I am attempting to port legacy Xenomai 2.6.4 code to Xenomai 3.  In our current code base, we implement userspace drivers using libpci, iopl, inb/outb, /dev/mem, and the pthread_intr_*_np family of functions.  Since the pthread_intr_*_np functions are no longer part of Xenomai, I have been researching and experimenting with the new UDD framework as a replacement.  Although documentation and examples are a little scarce, I have found most of the information I need.  I also used some documentation on the Linux UIO framwork to fill in some gaps in my knowledge.  My preliminary conclusion is that using the UDD framework would allow us to port our existing code base without too much modification, but I still have a few remaining questions.

I see the way that PCI device memory regions can be accessed using mmap with UDD_MEM_PHYS mem_regions, but on some PCI devices we also need to access I/O port regions, such as:

   Region 0: Memory at f7102000 (32-bit, non-prefetchable) [size=128]
   Region 1: I/O ports at b100 [size=128]
   Region 2: I/O ports at b280 [size=4]

The UIO documentation recommends using the struct uio_info's port field (an array of 'uio_port' structs) to pass information about the I/O port regions associated with the device to userspace.  I did not see the equivalent of this functionality in the UDD framework, and was wondering why it was omitted.  What is the recommended way of determining the ports associated with a device when using a UDD driver?  It seems like continuing to do this using libpci and then somehow matching this up with the corresponding UDD device would be messy and error-prone.

Thanks,

-Jeff

