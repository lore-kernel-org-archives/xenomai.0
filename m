Message-ID: <5105484F.2020105@xenomai.org>
Date: Sun, 27 Jan 2013 16:31:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADyNBOrp7hhKd-rbyfFoykVgQmSKho93RzJ2rRahZw6DsLFEgA@mail.gmail.com>
In-Reply-To: <CADyNBOrp7hhKd-rbyfFoykVgQmSKho93RzJ2rRahZw6DsLFEgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (no subject)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Amit Bhaira <a.hearthacker.b@gmail.com>
Cc: tanmoybag@gmail.com, xenomai@xenomai.org

On 01/26/2013 10:44 AM, Amit Bhaira wrote:

> We are writing a rtdm driver for pci das card, its getting an irq line
> shared with a linux kernel device i.e uhci_hcd:usb3.
> Can we disable the irq line in our driver?


Yes, but what would be the purpose of doing that?

> Or shall we disable the particular usb driver?


If you want to use the IRQ in the RTDM driver, you will have to do that.

> Or would u suggest any other solution coz our driver is making the
> system unresponsive?. Or is there any way to get an independent irq
> line for my device.


See:
http://xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_devices_share_the_same_IRQ.3F

-- 
                                                                Gilles.

