MIME-Version: 1.0
Sender: szhe.bme@gmail.com
In-Reply-To: <20150220052215.GB16978@hermes.click-hack.org>
References: <CAAg8yo2U6Djk+myWxLJ+rBqEfoy0z3pZhZQMbPDUyi17jH-B+w@mail.gmail.com>
 <20150208174239.GB2014@hermes.click-hack.org>
 <CAAg8yo2Nx-PFM3Fm5bjeCfROrNq5yaicx-ewcQnj9qfVNHFErA@mail.gmail.com>
 <20150220052215.GB16978@hermes.click-hack.org>
Date: Thu, 19 Feb 2015 22:26:44 -0800
Message-ID: <CAAg8yo2nAj1Bk+J15jms8goZqFP7SASoo-h9kzORZwZM_5snEw@mail.gmail.com>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Dear Gilles,

Thanks for your prompt reply. In my last email, it already included the pci
ids, shown in the bold letters:

lspci -nn
02:00.0 Network controller [0280]: PEAK-System Technik GmbH PCAN-PCI
CAN-Bus controller *[001c:0001]* (rev 02)
22:00.0 Network controller [0280]: PEAK-System Technik GmbH Device
*[001c:0003]* (rev 02)

001c is the manufacturer id, and 0001 and 0003 is the 2-channel PCI
and 4-channel
PCI express, respectively.

Harry

On Thu, Feb 19, 2015 at 9:22 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Thu, Feb 19, 2015 at 04:05:22PM -0800, Zhe Su wrote:
> > Dear Gilles and Konrad,
> >
> > Thanks for your reply. As you suggested, I confirmed the ids of
> > four-channel PCI express CAN board is in the rtcan_peak_pci.c file. I
> just
> > got my new four-channel PCI express CAN board yesterday; however, none of
> > the channel is working on my xenomai.  It did recognize there is a
> > PEAK-System Device plugged in the PCI express slot, but it is not working
> > with the can driver. Here are the results of the comparison between a
> > two-channel PEAK-System PCI CAN board and a four-channel PEAK-System PCI
> > express CAN board.
> >
> > lspci -nn
> > 02:00.0 Network controller [0280]: PEAK-System Technik GmbH PCAN-PCI
> > CAN-Bus controller [001c:0001] (rev 02)
> > 22:00.0 Network controller [0280]: PEAK-System Technik GmbH Device
> > [001c:0003] (rev 02)
> >
> > lspci -v
> >
> > 02:00.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus
> > controller (rev 02)
> >     Subsystem: PEAK-System Technik GmbH 2 Channel CAN Bus SJC1000
> > (Optically Isolated)
> >     Flags: medium devsel, IRQ 28
> >     Memory at f3ee0000 (32-bit, non-prefetchable) [size=64K]
> >     Memory at f3ef0000 (32-bit, non-prefetchable) [size=64K]
> >     Kernel driver in use: PEAK-PCI-CAN
> >     Kernel modules: xeno_can_peak_pci
> >
> > 22:00.0 Network controller: PEAK-System Technik GmbH Device 0003 (rev 02)
> >     Subsystem: PEAK-System Technik GmbH Device 0014
> >     Flags: bus master, fast devsel, latency 0, IRQ 11
> >     Memory at dffe0000 (32-bit, non-prefetchable) [size=64K]
> >     Memory at dfff0000 (32-bit, non-prefetchable) [size=64K]
> >     Expansion ROM at <unassigned>
> >     Capabilities: <access denied>
> >
> > Any help will be highly appreciated.
>
> Neither of these two commands is showing the pci ids.
>
> Try lspci -n
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
