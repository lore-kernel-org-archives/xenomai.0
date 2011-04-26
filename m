Message-ID: <4DB6A93D.3070402@domain.hid>
Date: Tue, 26 Apr 2011 13:15:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DFFBF4EB468A894AB1474ED220F05AF60134C17F@srv-dc.ona-electroerosion.com>
In-Reply-To: <DFFBF4EB468A894AB1474ED220F05AF60134C17F@srv-dc.ona-electroerosion.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] FW: rtdm_iomap_to_user() I-pipe error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Asier Tamayo <asier.tamayo@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Asier Tamayo wrote:
> Hello again,
> 
> When one doesn't get replies to his questions, it may be either
> because: i) they are too obvious (RTFM), ii) too difficult, iii)
> there is little information and it makes the checking in one's system
> impossible, or iv) they haven't been correctly explained. It may also
> be that the help demander is not being polite.
> 
> As i have received no answer, I will assume I haven't explained my
> problem correctly and will give myself a second chance ;) The
> following lines will just rewrite my question, since I haven't been
> able to find any new clue:
> 
> I'm porting a PCI driver to a RTDM, using Xenomai version 2.4.7 and
> Linux 2.6.27, from the ELinOS 5.0 distribution.

Before anything else, please try the latest version of the branch you
use (that would be Xenomai 2.4.10)

> 
> I want to allow a RT task to access the PCI memory directly, by
> calling the rtdm_iomap_to_user() function just after mlockall and
> rt_dev_open, and before rt_task_shadow. The function returns me a
> correct value, but then I cannot access the PCI registers by using
> that address. The mmap seems not to be correct. The values I get:
> 
> Driver: xen_mydriver->location = pci_resource_start(dev,0); -->
> 0x20000000 xen_mydriver->base_address =
> ioremap(xen_mydriver->location, xen_mydriver->mem_size); -->
> 0xe0a00000 *(unsigned short*)(my_context->base_address + 0x100) =
> 0xAAAA; --> It works
> 
> RT task: rtdm_iomap_to_user(user_info,my_context->location, 300,
> PROT_READ|PROT_WRITE, &new_iomap, NULL, NULL); --> 0xb5f6f000 
> virt_to_phys(new_iomap) --> 0xf5f6f000 *(unsigned short*)(new_iomap +

virt_to_phys is not supposed to work in that case. Since you ioremap'ed
the address, you already know the physical address anyway.

-- 
                                                                Gilles.

