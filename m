References: <b82b1342-701b-57de-e749-73b2f6882ee9@nta-inc.net>
 <fe69ba28-957e-b936-56d5-e1437edbb188@nta-inc.net>
From: Jeff Webb <jeff.webb@nta-inc.net>
Message-ID: <f2c2ad6d-5045-51ca-ca7b-512a60ec2cf7@nta-inc.net>
Date: Mon, 28 Aug 2017 13:45:27 -0500
MIME-Version: 1.0
In-Reply-To: <fe69ba28-957e-b936-56d5-e1437edbb188@nta-inc.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] UDD framework
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 08/07/2017 11:15 AM, Jeff Webb wrote:
> On 08/07/2017 10:08 AM, Jeff Webb wrote:
>> I am attempting to port legacy Xenomai 2.6.4 code to Xenomai 3.
>> In our current code base, we implement userspace drivers using
>> libpci, iopl, inb/outb, /dev/mem, and the pthread_intr_*_np
>> family of functions.  Since the pthread_intr_*_np functions are
>> no longer part of Xenomai, I have been researching and
>> experimenting with the new UDD framework as a replacement.
>> Although documentation and examples are a little scarce, I have
>> found most of the information I need.  I also used some
>> documentation on the Linux UIO framwork to fill in some gaps in
>> my knowledge.  My preliminary conclusion is that using the UDD
>> framework would allow us to port our existing code base without
>> too much modification, but I still have a few remaining
>> questions.
>>
>> I see the way that PCI device memory regions can be accessed
>> using mmap with UDD_MEM_PHYS mem_regions, but on some PCI devices
>> we also need to access I/O port regions, such as:
>>
>>   Region 0: Memory at f7102000 (32-bit, non-prefetchable) [size=128]
>>   Region 1: I/O ports at b100 [size=128]
>>   Region 2: I/O ports at b280 [size=4]
>>
>> The UIO documentation recommends using the struct uio_info's port
>> field (an array of 'uio_port' structs) to pass information about
>> the I/O port regions associated with the device to userspace.  I
>> did not see the equivalent of this functionality in the UDD
>> framework, and was wondering why it was omitted.  What is the
>> recommended way of determining the ports associated with a device
>> when using a UDD driver?  It seems like continuing to do this
>> using libpci and then somehow matching this up with the
>> corresponding UDD device would be messy and error-prone.
> 
> If no other support exists, perhaps I could use kmalloc to allocate a
> UDD_MEM_LOGICAL region corresponding to each PCI I/O port region on the
> card.  The kernel UDD driver would then populate these regions with
> the I/O addresses of the corresponding PCI I/O port regions.  The
> UDD_MEM_LOGICAL regions could then be read by the userspace driver
> to determine the I/O address to use with inb/outb (and iopl).

Another way would be to pass the port I/O region addresses (and possibly sizes) to userspace via explicit IOCTLs.  If so, should the IOCTL numbers for such a use case be standardized?

If there is no standard way to do this sort of thing, and if there are no recommendations about how to do proceed, I'll just do what feels right in my case, but I thought someone might have some experience or opinion on how this should be done in the Xenomai UDD context, since the Linux UIO method of passing port information is not available.

Thanks,

-Jeff

