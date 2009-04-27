Message-ID: <49F5D8DC.60706@domain.hid>
Date: Mon, 27 Apr 2009 18:10:04 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <37f89760904270553s1d862905l5c3c4df01ce0d984@domain.hid>	
	<49F5B322.3040709@domain.hid>	
	<37f89760904270652i6b8b1d6dq2ecef27d3e3a550@domain.hid>	
	<49F5BDBA.5050200@domain.hid>
	<37f89760904270737u622ea8c7vcbddec702e2348c1@domain.hid>
In-Reply-To: <37f89760904270737u622ea8c7vcbddec702e2348c1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Try to get recption on driver CAN
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Marcel Soulot <msoulot@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Marcel Soulot wrote:
> 
> 
> 2009/4/27 Wolfgang Grandegger <wg@domain.hid <mailto:wg@domain.hid>>
> 
>     Marcel Soulot wrote:
>     >
>     >
>     > 2009/4/27 Wolfgang Grandegger <wg@domain.hid
>     <mailto:wg@domain.hid> <mailto:wg@domain.hid
>     <mailto:wg@domain.hid>>>
>     >
>     >     Marcel Soulot wrote:
>     >     > Hi,
>     >     >
>     >     > I try to receive data from CAN network. I got a PCI card
>     with a FPGA
>     >     > which emulates the SJA1000.
>     >     > So I load the following modules :
>     >     > insmod ./xeno_can.ko
>     >     > insmod ./xeno_can_sja1000.ko
>     >     > insmod ./xeno_can_mem.ko mem=0xe0000800 irq=5 can_clock=80000000
>     >     cdr=0x8F
>     >     >
>     >     > then I configure with :
>     >     > ./rtcanconfig rtcan0 -v --baudrate=125000 start
>     >     >
>     >     > and launch the receive test application :
>     >     > ./rtcanrecv rtcan0 -v
>     >     >
>     >     > The task is running but nothing happen in reception.
>     >     > I could just say that the transmitter was blocked before I
>     load the
>     >     > driver. After all the upon configuration, I can check that the
>     >     > connection with transmitter is now enabled and the data are
>     sent.
>     >
>     >     Do you get interrupts for out-going messages? What does
>     "/proc/xeno/irq"
>     >     report?.
>     >
>     >
>     > I sent the data from another computer so I can check the flow data
>     on my
>     > CAN device (CANcaseXL). when the driver is unloaded I got the
>     error led
>     > and when I loaded and configured the driver the led transmit start to
>     > blink and the error led is off.
> 
>     Well, I don't understand what that means. Is RT-Socket-CAN working on
>     you PCI card. If not, what does not work? RX? TX?
> 
> 
> yes RT-Socket-CAN works on my PCI card but I don't send any data with
> it, just try to receive data.

You say it works but you do not receive an data with rtcanrecev.Hm, try
to send data with rtcansend, monitor the CAN bus and check
/proc/xenoma/irq. What do you get?

>     >     > First, my question is this procedure have any chance to work
>     ? or I
>     >     > missed something in the configuration ?
>     >
>     >     I think you need a PCI driver to support your card properly.
>     >
>     >
>     > I also already manage a GPIO driver for the same card and it works
>     fine.
> 
>     Does it use interrupts?
> 
> 
> No, it doesn't use interrupts, why ?  Does the problem can come from the
> interrupt management ? I Notice that nothing happen in interrupt task.

What I observed in the past is that xeno_can_mem.ko has problems
handling the interrupts properly.

>     > The driver xeno_can_mem.ko is not designed to access register with
>     > memory address ? What are the risk espacially if I have to manage
>     > several differents driver with the same card?
> 
>     The accesses from and to the device should not be a problem but
>     interrupt handling might be.
> 
> 
> Why the interrupt handling is not able to manage sharing between
> different driver (all the driver are running with Xenomai)?

Hm, what hardware is on your PCI card? How are interrupts routed?

Wolfgang.


