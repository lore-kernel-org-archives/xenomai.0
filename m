Message-ID: <2ff1a98a0801300740r513a119axc02896fe2c113f2@domain.hid>
Date: Wed, 30 Jan 2008 16:40:21 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <OPEMLLGLICPDOMGAPGNBIEBACAAA.jpdublon@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <OPEMLLGLICPDOMGAPGNBIEBACAAA.jpdublon@domain.hid>
Subject: Re: [Xenomai-help] shared interrupt again and again
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jpdublon <jpdublon@domain.hid>
Cc: xenomai@xenomai.org

On Jan 30, 2008 4:25 PM, jpdublon <jpdublon@domain.hid> wrote:
>
> Hello,
>
> When I disable and shut down (in cleanup_module) an IRQ shared (with ata!)
> in linux domain ,
> it seems to also shut down (or disable?) the linux IRQ.
>
> Is there a special way to unregister shared IRQs?

Are you trying to share an IRQ between linux and Xenomai domain ? If
yes, you should be aware that it will not work out of the box.

To get it to work, you will have to move the small part of code which
reads and clears the device status from Linux domain interrupt handler
to a Xenomai domain interrupt handler, where you will then need to
post the Linux domain interrupt if the device has an interrupt
pending. This is something that must be done for any driver which IRQ
line needs to be shared with a Xenomai driver.

If doing this is impossible for you (for instance because you intend
to run your driver on multiple boxes with different driver/IRQ
assignment), then you should read Xenomai FAQ.

-- 
                                               Gilles Chanteperdrix

