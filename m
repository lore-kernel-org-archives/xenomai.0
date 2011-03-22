Message-ID: <4D88D39D.907@domain.hid>
Date: Tue, 22 Mar 2011 17:51:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <COL122-W1001B88CC08016B1C1774EBDCE0@domain.hid>
	<4D80BA8B.7050803@domain.hid>, <4D81C6AD.8050803@domain.hid>
	<COL122-W637BE46C7D8B2CB7F79760BDB50@domain.hid>,
	<4D88925C.3040609@domain.hid>
	<COL122-W1673FD60DDA60D713554EBDB40@domain.hid>
In-Reply-To: <COL122-W1673FD60DDA60D713554EBDB40@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] MSI support in Xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: krishna m <krishnamurthyjs@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-03-22 16:55, krishna m wrote:
>  > Date: Tue, 22 Mar 2011 13:13:16 +0100
>  > From: jan.kiszka@domain.hid
>  > To: krishnamurthyjs@domain.hid
>  > CC: gilles.chanteperdrix@xenomai.org; xenomai@xenomai.org
>  > Subject: Re: MSI support in Xenomai
>  >
>  > On 2011-03-21 13:48, krishna m wrote:
>  > > > Date: Thu, 17 Mar 2011 09:30:37 +0100
>  > > > From: jan.kiszka@domain.hid
>  > > > To: gilles.chanteperdrix@xenomai.org; krishnamurthyjs@domain.hid
>  > > > CC: xenomai@xenomai.org
>  > > > Subject: Re: MSI support in Xenomai
>  > > >
>  > > > On 2011-03-16 14:26, Gilles Chanteperdrix wrote:
>  > > > > krishna m wrote:
>  > > > >> Hi All, I wanted to know if the latest Xenomai [Version
>  > > > >> xenomai-2.5.6] supports MSI interrupts. I am using the adeos Patch
>  > > > >> [version adeos-ipipe-2.6.37-x86-2.9-00] and corresponding Linux
>  > > > >> kernel [version: linux-2.6.37]. I have read in the Xenomai FAQ that
>  > > > >> MSI is not supported by the ipipe patch just wanted to know if the
>  > > > >> latest Xenomai and Ipipe supports MSI.
>  > > > >
>  > > > > No.
>  > > >
>  > > > Strictly spoken, but it works in practice. See
>  > > >
>  > > > http://thread.gmane.org/gmane.linux.real-time.xenomai.users/12135
>  > > >
>  > > > Jan
>  > > >
>  > > > --
>  > > > Siemens AG, Corporate Technology, CT T DE IT 1
>  > > > Corporate Competence Center Embedded Linux
>  > >
>  > > Hi Jan,
>  > >
>  > > Thanks for the reply. I got the following info from you post and i had few
>  > > questions related to this post:
>  > >
>  > >
>  > >
>  > > >> - MSI[-X] usage for RTDM (ie. RT) drivers is basically fine as long as you
>  > > avoid enabling/disabling from RT context (also used for quite a while here, no
>  > > known issues under this restriction)
>  > >
>  > > my question is are you mentioninig here that i must not be doing
>  > > pci_enable_msi() and pci_disable_msi() inside the RTDM driver ? if not then
>  > > where should these calls be done ?
>  >
>  > pci_enable/disable_msi are initialization services that only need to be
>  > executed over Linux context - also in RTDM drivers.
>  >
>  > >
>  > > Right now i have ported my standerd linux driver for the PCIe card to RTDM
>  > > drvier. This driver uses MSI. I am not enabeling or disabling MSI or IRQ any
>  > > where in the driver while processing [i.e. in ISR or read/write]. I am 
> enabeling
>  > > MSI in the PCI Probe and disabeling it in the PCI remove functions. The 
> problem
>  > > i am facing is as soon as i get the First MSI interrupt the kernel oops and i
>  > > get the following dump:
>  > >
>  > > |Mar 21 21:08:34 barch kernel: BUG: unable to handle kernel paging request 
> at 7f45402d
>  > > Mar 21 21:08:34 barch kernel: Oops: 0000 [#1] PREEMPT SMP
>  > > |
>  > >
>  >
>  > We would need the full backtrace to have at least a chance to help.
>  >
>  > >
>  > > [note: The normal linux driver works with out any problem].
>  > >
>  > > Please let me know your thoughts. Also is there an example PCIe RTDM driver
>  > > using MSI that i can refer to understand more about this topic ?
>  >
>  > Check RTnet's IGB driver. It works with MSI-X interrupts on x86.
>  >
>  > Jan
>  >
>  > --
>  > Siemens AG, Corporate Technology, CT T DE IT 1
>  > Corporate Competence Center Embedded Linux
> 
> Hi Jan,
> Thanks again for the reply. Here is the full backtrace:
> 
> Mar 22 21:12:47 localhost kernel: test_dev: Probe for device function=0
> Mar 22 21:12:47 localhost kernel: test_dev 0000:15:00.0: found PCI INT A -> IRQ 10

Here you get IRQ 10...

> Mar 22 21:12:47 localhost kernel: pci_bar = 0xfe000000
> Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT open handler is deprecated, 
> driver requires update.
> Mar 22 21:12:47 localhost kernel: Xenomai: RTDM: RT close handler is deprecated, 
> driver requires update.

[ These messages also have a meaning, though unrelated to the crash. ]

> Mar 22 21:12:47 localhost kernel: test_dev: IRQ 16 successfully assigned to the 
> device.

...but here IRQ 16 is assigned. Broken output or a real inconsistency?

Also, where is the MSI? You should see log messages about MSI/MSI-X IRQ
number assignment when properly enabling the support at PCI level.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

