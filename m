From: Dirk Roloff <roloff@domain.hid>
Subject: Re: [Adeos-main] 260 uSec latency and no idea why
Date: Fri, 12 Mar 2004 18:15:12 +0100
References: <200403120744.i2C7iI725496@domain.hid> <4052104E.8020308@domain.hid> <16465.34899.374768.946617@domain.hid>
In-Reply-To: <16465.34899.374768.946617@domain.hid>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200403121815.12694.roloff@domain.hid>
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Am Freitag, 12. M=E4rz 2004 10:52 schrieb Gilles Chanteperdrix:
> Paolo Mantegazza wrote:
>  > Der Herr Hofrat wrote:
>  > Yours is the first case I step on such a problem with Celerons.
>
> What about IDE controllers bus mastering DMA ? Can't this be the cause
> of big bus locks ?

Not if i understand the pci latency timer right.
its 32 PCI-Cycles in my case - this time after the grant a DMA master had t=
o give away the bus.
So the maximum latency is number of posible dma-masters * latency timer.
calculating this on a 33 MHz bus is under 1 microsecond.

I am unsure for how long the CPU can hold the Bus.

And my IDE controler is not using DMA.=20
And on the other Hand what has the ParPort to do with teh PCI bus ?

Dirk


