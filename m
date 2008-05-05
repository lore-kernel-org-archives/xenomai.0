Message-ID: <481F96B9.8050108@domain.hid>
Date: Mon, 05 May 2008 19:22:33 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <481F6C7D.1050908@domain.hid> <481F884E.5080201@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646F75@domain.hid>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646F75@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Loosing serial interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>


Hi Joshua,

my problem does not seem to be an overrun. UART reports an ordinary 
receive interrupt - 4, line status is 97 (data ready, both sending 
registers empty).

Tomas



Karch, Joshua wrote:
>
> Tomas,
>
> I assume you mean buffer overruns, right?  What type of CPU board are 
> you using?  I'm using a Geode and it is notoriously bad in terms of 
> non-maskable System Management Interrupts which cause overflows. I had 
> to lower the speed of transmission down to 57600 to avoid the overruns.
>
> Take care,
>
> Josh
>
>
> -----Original Message-----
> From: xenomai-help-bounces@domain.hid on behalf of Jan Kiszka
> Sent: Mon 5/5/2008 6:21 PM
> To: Tomas Kalibera
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Loosing serial interrupt
>
> Tomas Kalibera wrote:
> > Hi,
> >
> > I am having problems with lost serial interrupts. Could you please
> > explain to me why this happens ? I am probably missing something
> > regarding scheduling in Xenomai...
> > I prepared a program that triggers the problem, at least on my system.
> >
> > Thanks,
> >
> > Tomas
> >
> > The program works on my system as follows:
> >
> > 1. I run the program, it prints
> >
> > In interrupt, LStatus: 96
> > In interrupt, read char, LStatus: 96
> >
> > [which means that it received a serial interrupt, because the
> > transmitter receiver is empty]
> >
> > 2. I send a single character to the program over serial line
> >
> > 3. the program wakes up (10 seconds after (1))
> >
> > 4. the program prints
> >
> > I-NFO irq=4 hits=1
> > PIC-ISR:0 PIC-IRR:0 PIC-IMR:128 UART-IIR:4 UART-LSR:97 UART-MSR:176
> >
> > [which means the interrupt at Xenomai level hit only once, although it
> > should have twice, second time because of the received character
> >  these too lines that repeat indefinitely, the interrupt not coming.
> > although interrupts are enabled at PIC level]
> >
> > I use the "XT-PIC-XT" (8259A) interrupt controller. As far as I know,
> > Linux sets up the controller to "edge triggering", but uses
> > "handle_level_irq" for it. When received by Xenomai, the interrupt is
> > masked and acked at PIC level ( "ack" means EOI at 8259A). When the
> > interrupt handling in the program finishes, it unmasks the interrupt. I
> > verified  that my 8259A has a latch that can detect the UART interrupt
> > even if masked, so that when unmasked again, it can be delivered.
>
> Try to pass I_EDGE to rt_intr_create. The UART IRQs are edge-triggered,
> so you have to enable the appropriate handling at kernel IRQ handler 
> level.
>
> Jan
>
>


