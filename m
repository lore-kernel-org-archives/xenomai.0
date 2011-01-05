Message-ID: <4D24E3AC.2000904@domain.hid>
Date: Wed, 05 Jan 2011 22:33:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6FCCA913376DD7488F4139A4D11B8F48016311A5@domain.hid>
	<4D1FAE66.8080005@domain.hid>
	<6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>
In-Reply-To: <6FCCA913376DD7488F4139A4D11B8F4801673CAB@troe2k1.cs.myharris.net>
Content-Type: text/plain; charset=UTF-8
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
To: "Herrera-Bendezu, Luis" <lherrera@domain.hid>
Cc: xenomai@xenomai.org

Herrera-Bendezu, Luis wrote:
> Gilles:
> 
>> Herrera-Bendezu, Luis wrote:
>>> Hello:
>>>
>>> I have the following setup:
>>> PPC405EX
>>> Linux 2.6.30.3
>>> Xenomai 2.4.10
>>> I-pipe 2.7-02
>>> ppc_4xx-gcc (GCC) 4.2.2
>>> Configuration file is attached
>> Do you have the same issue with the latest version of the I-pipe patch
>> for this same version of the Linux kernel? It should be 2.8-00.
> 
> Tried I-pipe 2.8-00 which needs Linux 2.6.32.

Sorry, I misread the ftp list, I was rather thinking about:
http://download.gna.org/adeos/patches/v2.6/powerpc/older/adeos-ipipe-2.6.30.3-powerpc-DENX-2.7-06.patch


 It resulted on same problem
> as reported with Linux 2.6.30.3 I-pipe 2.7-02.
> 
> Was there any particular set of changes that you expected it could fix the
> problem? Do you think more recent versions may work? If yes, which version
> could be tried?

Yes, there was a fix, specifially in the powerpc tree, with mappings
issue. But I think it is older than 2.6.32.

Now that I look at your message again, your problem seems more likely to
be in your code. Specifically, you say: "bus address returned by
pci_alloc_consistent()". I do not think pci_alloc_consistent return
value is a bus address. The dma_handle returned by pointer probably is.
But I am not sure you are supposed to know this.

Please post your code (or a minimal, standalone version of it which
demonstrates the problem).

-- 
                                                                Gilles.

