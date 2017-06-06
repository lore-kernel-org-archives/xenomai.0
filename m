Date: Tue, 6 Jun 2017 10:30:30 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170606103030.5965146e@md1em3qc>
In-Reply-To: <CAFUnMknQhTEPTZCUp4chEoohHcgAfhFai7jRZPSEuhdiFY-3MA@mail.gmail.com>
References: <CAFUnMkkbtRuasbfiP2bZ_twJ1JZjQxq1EXeRDHBKL9LmiXdV5w@mail.gmail.com>
 <20170602164607.37c91e63@md1em3qc>
 <CAFUnMknQhTEPTZCUp4chEoohHcgAfhFai7jRZPSEuhdiFY-3MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>, xenomai@xenomai.org

Am Sat, 3 Jun 2017 16:46:08 +0530
schrieb Ashok kumar <ashokkumar.bb@gmail.com>:

> Hi,
> 
> Thank you for your reply , how to look pci and vendor id in the
> kernel code ,

grep for the vendor id / device id in the drivers or wifi subdirs
But asking google it seems like the driver you are looking for was
called broadcom-sta
In a more recent kernel it seems to be called "bcma" and "b43".

> I am using linux 3.2.21 kernel., xenomai 2.6.2.1
> in which folder PCI and vendor Id  is available

With this outdated software you should first consider updating. The
drivers probably where not upstream, if you are lucky you will find the
broadcom-sta stuff for that old kernel.

Another option would be to add a PCI or USB wifi-adaptor that was well
supported by that kernel.

Henning

> how to enable wifi ?
>
> when I entered the command lspci I got the output.
> 
> texsonics@texsonics-Inspiron-3542:/usr/sbin$ lspci
> 00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller
> (rev 0b) 00:02.0 VGA compatible controller: Intel Corporation
> Haswell-ULT Integrated Graphics Controller (rev 0b)
> 00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio
> Controller (rev 0b)
> 00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev
> 04) 00:16.0 Communication controller: Intel Corporation 8 Series HECI
> #0 (rev 04)
> 00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller
> (rev 04)
> 00:1c.0 PCI bridge: Intel Corporation 8 Series PCI Express Root Port
> 1 (rev e4)
> 00:1c.2 PCI bridge: Intel Corporation 8 Series PCI Express Root Port
> 3 (rev e4)
> 00:1c.3 PCI bridge: Intel Corporation 8 Series PCI Express Root Port
> 4 (rev e4)
> 00:1d.0 USB controller: Intel Corporation 8 Series USB EHCI #1 (rev
> 04) 00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller
> (rev 04) 00:1f.2 SATA controller: Intel Corporation 8 Series SATA
> Controller 1 [AHCI mode] (rev 04)
> 00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04)
> 06:00.0 Network controller: Broadcom Corporation BCM43142 802.11b/g/n
> (rev 01)
> 07:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller (rev 07)
> 
> thank you
> 
> 
> On Fri, Jun 2, 2017 at 8:16 PM, Henning Schild
> <henning.schild@siemens.com> wrote:
> 
> > Am Fri, 2 Jun 2017 19:38:14 +0530
> > schrieb Ashok kumar <ashokkumar.bb@gmail.com>:
> >  
> > > I am Ashok , I have installed the xenomai-2.6.21 patch with linux
> > > kernel 3.2.21  I am using Dell laptop core i3,x86_64 , after
> > > installation my wifi network is not working ,
> > > I have run the command
> > >
> > > lspci | grep Network
> > >
> > > 06:00.0 Network controller: Broadcom Corporation BCM43142
> > > 802.11b/g/n (rev 01)  
> >
> > Well these versions are pretty outdated. But your problem has
> > nothing to do with xenomai.
> > It could be that your kernel config does not enable the driver, or
> > the card is not even supported by that old kernel.
> >  
> > > but in ifconfig command wlan is not seen.  
> >
> > lspci -v should tell you whether any driver claimed the card,
> > probably not
> >  
> > > please provide me a solution to enable wifi with xenomai kernel.  
> >
> > Check whether the kernel supports that card and is configured
> > correctly. i.e. look for the pci device and vendor id in the kernel
> > code. You might be missing some ucode-/firmware- packages.
> >
> > Henning
> >  
> > > Thank you
> > > from Ashok
> > > _______________________________________________
> > > Xenomai mailing list
> > > Xenomai@xenomai.org
> > > https://xenomai.org/mailman/listinfo/xenomai  
> >
> >  


