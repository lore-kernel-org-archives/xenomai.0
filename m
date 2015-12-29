MIME-Version: 1.0
In-Reply-To: <CANOAZgyVur3nUyowUGWe4k4RnhkSFQtiDMY5tMoD1muPStuNbA@mail.gmail.com>
References: <CANOAZgyVur3nUyowUGWe4k4RnhkSFQtiDMY5tMoD1muPStuNbA@mail.gmail.com>
From: Wuwei He <whe@neocisinc.com>
Date: Tue, 29 Dec 2015 11:44:32 -0500
Message-ID: <CANOAZgw5LuJS6aq2tFXKNk035F3LUiSUW13apJ5=Roko6oD8fQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] RTCAN problem with PEAK PCIe & miniPCIe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

PS.

Also, the same results with the one channel PCIe card.



On Tue, Dec 29, 2015 at 11:16 AM, Wuwei He <whe@neocisinc.com> wrote:

> Hello, all
>
> I have a problem with the PEAK PCIe card: I could never receive CAN
> messages and can only send one message.
>
>
> Using /usr/xenomai/bin/rtcansend and rtcanrecv:
> When receiving, RX_Counter does not increase.
> When sending, TX_Counter increase to 1, and message is received from the
> receive end. Then sending a second message, it gets blocked and no
> response. Checking with /proc/rtcan/devices, no error status though.
>
> I am using Xenomai 2.6.3, Linux kernel 3.5.7, under Ubuntu 12.04.
> Same results for two different PC -- hardware. Tested with PEAK dual PCIe
> and dual miniPCIe.
> Tried with SHARED_IRQ enabled. When not enabled, the devices won't be
> loaded.
> Also, when using dual PCI card, no such problems. Same error behavior with
> dual PCIe and miniPCIe.
>
> Would any one knows what kind of problem I am in?
>
> Any information or links could be very much helping.
> Thanks!
>
> Wuwei "Will" He
> Miami FL
> US
>
