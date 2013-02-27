Message-ID: <512E75C8.4050403@xenomai.org>
Date: Wed, 27 Feb 2013 22:08:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAD1EtohJTQi9jj07_NrC=anxQiqQS1=TrHecAK21uW0wBoOnYQ@mail.gmail.com>	<512E67D4.70804@xenomai.org>	<CAD1EtogDAPC7Q1-sq1fh1J71hQRYMoAs=HNEzZOYosxP8NeWbg@mail.gmail.com>	<512E696A.2010106@xenomai.org>	<512E69D3.6090601@xenomai.org>	<CAD1Etoj6q+xOoK5Zgy1rpB73_9e236mpfOjCQk6+eDMa=c2Fmw@mail.gmail.com>
	<CAD1EtoiHUSqP-aXWenyHNkm8xA4dJHW_0kqiVtMJ36ssAMYPww@mail.gmail.com>
In-Reply-To: <CAD1EtoiHUSqP-aXWenyHNkm8xA4dJHW_0kqiVtMJ36ssAMYPww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Failing to recognize/use PEAK PCAN-miniPCIe card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

On 02/27/2013 10:03 PM, Daniel M. Drucker, Ph.D. wrote:

> Success!
> 
> All we had to do was add:
> 
> #define PEAK_MPCI_DEVICE_ID  0x0008  // Device ID for newer PCIe cards
> (IPEH-003027)
> 
> and add that to pci_device_id peak_pci_tbl[].
> 
> Note that that ID is included in the user-mode driver (
> linux-3.5.7/drivers/net/can/sja1000/peak_pci.c ).


If the driver is in the kernel sources, chances are that it is not a
user-mode driver at all...
-- 
                                                                Gilles.

