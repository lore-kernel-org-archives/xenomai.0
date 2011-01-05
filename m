Message-ID: <4D24EB92.3050104@domain.hid>
Date: Wed, 05 Jan 2011 17:07:14 -0500
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>	<4D1FAE66.8080005@domain.hid>	<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>
	<4D24E3AC.2000904@domain.hid>
In-Reply-To: <4D24E3AC.2000904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai -help] User space access to DMA memory
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 01/05/2011 04:33 PM, Gilles Chanteperdrix wrote:
> Herrera-Bendezu, Luis wrote:
>> Gilles:
>>
>>> Herrera-Bendezu, Luis wrote:
>>>> Hello:
>>>>
>>>> I have the following setup:
>>>> PPC405EX
>>>> Linux 2.6.30.3
>>>> Xenomai 2.4.10
>>>> I-pipe 2.7-02
>>>> ppc_4xx-gcc (GCC) 4.2.2
>>>> Configuration file is attached
>>> Do you have the same issue with the latest version of the I-pipe patch
>>> for this same version of the Linux kernel? It should be 2.8-00.
>>
>> Tried I-pipe 2.8-00 which needs Linux 2.6.32.
> 
> Sorry, I misread the ftp list, I was rather thinking about:
> http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2.6.30.3-powerpc-DENX-2.7-06.patch
> 
> 
>  It resulted on same problem
>> as reported with Linux 2.6.30.3 I-pipe 2.7-02.
>>
>> Was there any particular set of changes that you expected it could fix the
>> problem? Do you think more recent versions may work? If yes, which version
>> could be tried?
> 
> Yes, there was a fix, specifially in the powerpc tree, with mappings
> issue. But I think it is older than 2.6.32.
> 
> Now that I look at your message again, your problem seems more likely to
> be in your code. Specifically, you say: "bus address returned by
> pci_alloc_consistent()". I do not think pci_alloc_consistent return
> value is a bus address. The dma_handle returned by pointer probably is.
> But I am not sure you are supposed to know this.

pci_alloc_consistent() returns two values.  The kernel address is
returned directly (as a void *), and the bus address is returned
through the dma_handle pointer (third function argument).

Luis' original email indicated that he tried rtdm_mmap_to_user()
on the kernel address, and he tried rtdm_iomap_to_user() on the
bus address. Either way caused the crash he reported.

We have a home-grown program (mm) that basically opens /dev/mem
and allows peek/poke.  Using that with the bus address works to
access the memory.  We also pass that address to our hardware,
and it correctly DMAs the data.  So we believe the bus address
is correct.

I believe Luis has also tried a third approach - allocating with
kzalloc(size, GFP_DMA), and using rtdm_mmap_to_user() on the
resulting pointer.  That works, but getting the bus address is
a bit ugly - basically page_to_phys(virt_to_page()) of the pointer.

So there is something different about the way pci_alloc_consistent()
allocates memory as compared to kzalloc(GFP_DMA).  kzalloc(GFP_DMA)
works with rtdm_mmap_to_user() but pci_alloc_consistent() does
not.

	Steve

> 
> Please post your code (or a minimal, standalone version of it which
> demonstrates the problem).
> 


-- 
A: Because it makes the logic of the discussion difficult to follow.
Q: Why shouldn't I top post?
A: No.
Q: Should I top post?

