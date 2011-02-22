Message-ID: <4D641ADF.1070802@domain.hid>
Date: Tue, 22 Feb 2011 21:21:51 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <274381298405447@domain.hid>
In-Reply-To: <274381298405447@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Interrupt handling problem on Compulab EM-X270.
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Nazarov Sergey <s-nazarov@domain.hid>
Cc: adeos-main@gna.org

Nazarov Sergey wrote:
> Hi! I'm trying to use i-pipe 1.18-01 on ARM XScale-PXA270 based
> Compulab EM-X270 board. Kernel version is 2.6.33. With kernel,
> patched by i-pipe patch, network controller Davicom DM9000 standing
> unstable: sometimes a lot of packets are losing. This happens with
> CONFIG_IPIPE disabled even. The reason is lost interrupts, I see.
> Network controller uses GPIO line to produce interrupts. I have found
> that i-pipe patch changing irq handler handle_irq_edge to
> handle_irq_level (arch/arm/plat-pxa/gpio.c: pxa_init_gpio) without
> any conditions. What's the reason for that changing? The back change
> to edge-type handler returns network controller to stable state. Best
> regards, Sergey.

Does it work with CONFIG_IPIPE enabled?

-- 
                                                                Gilles.

