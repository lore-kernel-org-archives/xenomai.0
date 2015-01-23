Date: Fri, 23 Jan 2015 15:08:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150123140810.GB9521@hermes.click-hack.org>
References: <3022250.HiL0lpQ0bg@soho> <6556840.cT0vWHhSc4@soho>
 <20150123102426.GB6264@hermes.click-hack.org>
 <33073894.RfSf0qJ9Gn@soho>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33073894.RfSf0qJ9Gn@soho>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai-3 booting problems (2)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On Fri, Jan 23, 2015 at 12:43:05PM +0100, Leopold Palomo-Avellaneda wrote:
> El Divendres, 23 de gener de 2015, a les 11:24:26, Gilles Chanteperdrix va 
> escriure:
> 
> > > xenomai has some kind of issue tracker?
> > 
> > Also, speaking about tracking issues. You did not answer my
> > question: all these configurations issues you have have nothing
> > specific to xenomai 3. How come you did not reuse the same
> > configuration that you used for Xenomai 2.6.4 ?
> 
> No Gilles. I think that I wrote it before (as I said ;-)
> 
> I copied the same configuration from xenomai-2.6.4 to xenomai-3.0.0. Xenomai 3 
> introduced some differences. I have attached the diffs.

The CONFIG_XENO* differences and the CONFIG_IPIPE* differences
are obviously due to Xenomai version change. The rest is not.

> 
> The fb issue has appeared because I test the kernels in a box without graphic 
> environtment but today I tested in my box (with graphic environtment). I 
> prefer the nvidia cards in general for the labs because I have less problems 
> than the ati ones.

I prefer the Intel ones: the drivers are free, as in free beer, are
mainlined into all the projects involved (linux, libdrm, mesa,
libva, xorg, etc..) have a working hardware acceleration with good
performances (maybe not for bleeding edge games, but OK for usual
3D needs and for decompressing H264 and displaying video).

> < CONFIG_VFIO_IOMMU_TYPE1=m
> < CONFIG_VFIO=m
> < CONFIG_VFIO_PCI=m
> < CONFIG_VFIO_PCI_VGA=y
> 5764,5773c5773
> < CONFIG_IOMMU_API=y
> < CONFIG_IOMMU_SUPPORT=y
> < CONFIG_AMD_IOMMU=y
> < # CONFIG_AMD_IOMMU_STATS is not set
> < CONFIG_AMD_IOMMU_V2=y
> < CONFIG_DMAR_TABLE=y
> < CONFIG_INTEL_IOMMU=y
> < # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> < CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> < CONFIG_IRQ_REMAP=y
> ---
> > # CONFIG_IOMMU_SUPPORT is not set
> 6530d6529
> < # CONFIG_INTEL_TXT is not set
> 6726d6724
> < CONFIG_KVM_DEVICE_ASSIGNMENT=y


-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 811 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150123/7231044f/attachment.sig>
