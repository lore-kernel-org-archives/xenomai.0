References: <CANWkrROZXVOO1nSV0yJtky9H5XefA6Jqs8fC5bxGn3Zo5miv7Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56B49B53.10601@siemens.com>
Date: Fri, 5 Feb 2016 13:53:39 +0100
MIME-Version: 1.0
In-Reply-To: <CANWkrROZXVOO1nSV0yJtky9H5XefA6Jqs8fC5bxGn3Zo5miv7Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] DMA userspace access
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 2016-02-04 16:28, Michael Smith wrote:
> Hi guys.
> I am currently converting an existing Linux driver to RTDM.
> I came across a read() file operations function where the author uses
> the function
> get_user_pages() to get a pointer to userspace memory do to a direct
> DMA transfer operation to it.
> I don't see any equivalent functionality in the RTDM API, so I just
> wanted to check if
> I'm not missing something.
> There are various RTDM functions to map IO & kernel memory to
> userspace but not to
> aquire and lock userspace pages in order to do a transfer to it like
> with this function.
> 
> It seems that the only solution in this case is to keep the code as it
> is and to call it
> in the secondary domain instead of the primary.
> Please let me know if there is an alternative way to do this from the
> primary domain.

I didn't try yet, but it may work: vfio provides clean forwarding of
DMA-performing PCI and also AMBA platform devices to userspace. E.g.,
DPDK uses this to implement NIC drivers in userspace. Prerequisite:
Linux-supported IOMMU (SMMU on ARM).

However, you will still need RTDM for handling/forwarding interrupts
unless you plan for polling. And there we are in conflict with vfio
taking over the device. Probably, we need some extension of vfio here.

That said, there would still be the option to introduce a more or less
hacky "get my userspace page's phys address" call to udd.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

