From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17559.56387.507326.790229@domain.hid>
Date: Tue, 20 Jun 2006 13:30:11 +0200
Subject: Re: [Xenomai-core] User-space DMA transfer and I/O access from Xenomai
	API
In-Reply-To: <4497D7F2.9090001@domain.hid>
References: <923F5E294B7B194EA41B7B11DAE5330B1A9F3990@domain.hid>
	<4497D7F2.9090001@domain.hid>
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
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Merilainen, Jussi (GE Healthcare) wrote:
 > >  
 > > 
 > > I'm porting a PCI driver for a custom board from VxWorks to Xenomai/Linux. My goal is to keep the driver as much as possible in user-space. Implementing the HW interrupt handler should be quite straight forward as presented in 'Writing user-space device drivers' in Native-API-Tour manual.
 > > My concern is the PCI DMA transfer. Does the Xenomai API provide any support for this in user-space? Does anyone have experience on this subject?
 > 
 > Actually, this need not be a Xenomai-specific issue. User space device
 > drivers are of increasing common interest in the Linux community. I only
 > collected some projects so far, I did not dig into the APIs:
 > 
 > - libpci as part of the pciutils provides ways to access device
 >   information, don't know if it also allows to map DMA memory to user
 >   space.

libpci allow user-space to retrieve the bus addresses of memory
regions of each PCI device. Mmaping this memory may be done using
/dev/mem. But usually, PCI devices do DMA the other way around: they are
passed the physical address of some RAM, become bus-master and write
directly to this RAM. So what is needed is:
- to map some physically contiguous RAM region to user-space;
- get the physical addres of this region in order to pass it to the PCI
  device to program the DMA.

Xenomai allow you to map to user-space some physically contiguous RAM
region (using either native heaps or posix shared memory smaller than
128K), but does not provide accessors to the RAM physical
address. Is it what you need ?

-- 


					    Gilles Chanteperdrix.

