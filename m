MIME-Version: 1.0
Sender: szhe.bme@gmail.com
In-Reply-To: <20150208174239.GB2014@hermes.click-hack.org>
References: <CAAg8yo2U6Djk+myWxLJ+rBqEfoy0z3pZhZQMbPDUyi17jH-B+w@mail.gmail.com>
 <20150208174239.GB2014@hermes.click-hack.org>
Date: Thu, 19 Feb 2015 16:05:22 -0800
Message-ID: <CAAg8yo2Nx-PFM3Fm5bjeCfROrNq5yaicx-ewcQnj9qfVNHFErA@mail.gmail.com>
From: Zhe Su <zhesu@usc.edu>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Compatibility of PCAN PCI Express Four Channel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, konradb3@gmail.com
Cc: xenomai@xenomai.org

Dear Gilles and Konrad,

Thanks for your reply. As you suggested, I confirmed the ids of
four-channel PCI express CAN board is in the rtcan_peak_pci.c file. I just
got my new four-channel PCI express CAN board yesterday; however, none of
the channel is working on my xenomai.  It did recognize there is a
PEAK-System Device plugged in the PCI express slot, but it is not working
with the can driver. Here are the results of the comparison between a
two-channel PEAK-System PCI CAN board and a four-channel PEAK-System PCI
express CAN board.

lspci -nn
02:00.0 Network controller [0280]: PEAK-System Technik GmbH PCAN-PCI
CAN-Bus controller [001c:0001] (rev 02)
22:00.0 Network controller [0280]: PEAK-System Technik GmbH Device
[001c:0003] (rev 02)

lspci -v

02:00.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus
controller (rev 02)
    Subsystem: PEAK-System Technik GmbH 2 Channel CAN Bus SJC1000
(Optically Isolated)
    Flags: medium devsel, IRQ 28
    Memory at f3ee0000 (32-bit, non-prefetchable) [size=64K]
    Memory at f3ef0000 (32-bit, non-prefetchable) [size=64K]
    Kernel driver in use: PEAK-PCI-CAN
    Kernel modules: xeno_can_peak_pci

22:00.0 Network controller: PEAK-System Technik GmbH Device 0003 (rev 02)
    Subsystem: PEAK-System Technik GmbH Device 0014
    Flags: bus master, fast devsel, latency 0, IRQ 11
    Memory at dffe0000 (32-bit, non-prefetchable) [size=64K]
    Memory at dfff0000 (32-bit, non-prefetchable) [size=64K]
    Expansion ROM at <unassigned>
    Capabilities: <access denied>

Any help will be highly appreciated.

Thanks,

Harry

On Sun, Feb 8, 2015 at 9:42 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Sat, Feb 07, 2015 at 05:23:33PM -0800, Zhe Su wrote:
> > Dear all,
> >
> > I am running xenomai 2.6.3 on Ubuntu 12.04, and I would like use a
> > four-channel PCI express CAN board manufactured by PEAK system. The exact
> > model name and number are PCAN-PCI Express Four Channel galvanic isolated
> > IPEH-003040. I am wondering if xenomai 2.6.3 rtcan driver will be
> > compatible with this board?
>
> To check whether your board is compatible, get its ids with lspci.
>
> Then look at:
>
> https://git.xenomai.org/xenomai-jro.git/tree/kernel/drivers/can/sja1000/rtcan_peak_pci.c#n73
>
> To see if the pci ids of your card are supported. If they are not,
> you may be able to get the driver working for your board by adding
> you board's ids to the peak_pci_tbl array, if the board is
> compatible with the driver.
>
> --
>                                             Gilles.
>



-- 
Zhe Su (Harry Su), Ph.D. student
Research Assistant
Medical Device Development Facility
Department of Biomedical Engineering
University of Southern California
