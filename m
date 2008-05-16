Message-ID: <482D61D7.7090100@domain.hid>
Date: Fri, 16 May 2008 12:28:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4B2EEE69E41E524EB7FCDC62A15D68D8EA1D3C@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <4B2EEE69E41E524EB7FCDC62A15D68D8EA1D3C@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Problems using rtdm_iomap_to_user
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas.Debes@domain.hid
Cc: xenomai@xenomai.org

Thomas.Debes@domain.hid wrote:
> Hi,
>  
> we are currently implementing an RTDM driver for our PCI based fieldbus card running in a MPC5200 system (Xenomai 2.3.5/Kernel 2.4 PPC). In order to provide backward compatibility for existing applications (using an older Linux version of the driver) we need an ioctl to let those applications read/write to a mapped io memory. Therefore we used the following (incomplete)  piece of code :
>  
> void map_dpm_to_user(pcidev_t *pcidev,  rtdm_user_info_t *user_info,  void *arg)
>  {
>         unsigned long memaddr = 0, memlen = 0;
>         unsigned char *dpm = NULL;
> 
>         /* Get start address and length of resource */
>         memaddr = pci_resource_start(pcidev, 2);
>         memlen = pci_resource_len(pcidev, 2);
> 
>         memaddr &= PCI_BASE_ADDRESS_IO_MASK;
> 
>         /* Request resource */
>         request_mem_region(memaddr, memlen, NULL);
> 
>         /* Remap for direct access in kernel space */
>         dpm = (unsigned char*)ioremap(memaddrmask, memlen);
> 
>         /* Map to user */
>         rtdm_iomap_to_user(user_info, memaddr, memlen,
>                          PROT_READ|PROT_WRITE, (void **)arg, NULL, NULL);
> }
>  
> This code executes without errors but the application freezes on accessing the mapped memory. There was a similar question posted earlier (https://mail.gna.org/public/xenomai-core/2007-09/msg00030.html) but the suggested solution can not be used with a 2.4 kernel because phys_mem_access_prot was introduced with the kernel version 2.6 (afaik).  Can you confirm this problem? Are there any related patches in the current Xenomai version (2.4.x)?
>

This has partially been fixed in v2.4.x and beyond, by using pgprot_noncached()
so set the VMA protection bits in wrap_remap_io_page_range(), and fixing
rtdm_mmap_buffer() to better distinguish protection flags between I/O memory and
kmem areas. The point is that you need _PAGE_NO_CACHE | _PAGE_GUARDED to be set
in the VMA prot bits.

However, ppc is a bit special, since there may be the added requirement to clear
the _PAGE_GUARDED flag in case the mapped area is actually some prefetchable IO
memory resource from a PCI device.

Well, you could try the 2.4.x fixes, in case that fits your needs. But we will
likely have to change wrap_remap_io_page_range() and rtdm_mmap_buffer() anew, to
use phys_mem_access_prot() where available.

> Thanks
> Thomas 
> 
> MAN Roland Druckmaschinen AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle    
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592    
> USt-Ident-Nr. DE 250200933
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

