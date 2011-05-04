Message-ID: <4DC0FEDD.8080304@domain.hid>
Date: Wed, 04 May 2011 09:23:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTikzGAMXZ--TaxmxXZDsoYJSesC26g@domain.hid>	<4DC03D39.2040305@domain.hid>
	<BANLkTi=Pj2Rk0u_ih7zKx+pmyhSTGM3Y-Q@mail.gmail.com>
In-Reply-To: <BANLkTi=Pj2Rk0u_ih7zKx+pmyhSTGM3Y-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] reading/writing registers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Aurele Traynard <aurele.traynard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 05/04/2011 09:11 AM, Aurele Traynard wrote:
> Ok I will explain more things :
> My software makes the system freezing, when my interrupt handler is called
> for the first time I think that he is called again and again and again and
> this never stops. And so this freeze the system
> but I am not totaly sure.
> I'm sure that it is not Xenomai's fault it is just mine. I think I don't use
> Xenomai correctly...
> That's why I am asking if "ioremap" "readl/writel" is the best way to
> read/write CPU registers and if there are other ways.

Yes they are. But if your aim is to acknowledge/mask the interrupt line
at the interrupt controller level, this should not be done in the
interrupt handler, it is supposed to be done in the irqchip callbacks
for the interrupt controller you use.

-- 
                                                                Gilles.

