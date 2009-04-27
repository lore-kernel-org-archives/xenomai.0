Message-ID: <49F5B322.3040709@domain.hid>
Date: Mon, 27 Apr 2009 15:29:06 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <37f89760904270553s1d862905l5c3c4df01ce0d984@domain.hid>
In-Reply-To: <37f89760904270553s1d862905l5c3c4df01ce0d984@domain.hid>
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
> Hi,
> 
> I try to receive data from CAN network. I got a PCI card with a FPGA
> which emulates the SJA1000.
> So I load the following modules :
> insmod ./xeno_can.ko
> insmod ./xeno_can_sja1000.ko
> insmod ./xeno_can_mem.ko mem=0xe0000800 irq=5 can_clock=80000000 cdr=0x8F
> 
> then I configure with :
> ./rtcanconfig rtcan0 -v --baudrate=125000 start
> 
> and launch the receive test application :
> ./rtcanrecv rtcan0 -v
> 
> The task is running but nothing happen in reception.
> I could just say that the transmitter was blocked before I load the
> driver. After all the upon configuration, I can check that the
> connection with transmitter is now enabled and the data are sent.

Do you get interrupts for out-going messages? What does "/proc/xeno/irq"
report?.

> First, my question is this procedure have any chance to work ? or I
> missed something in the configuration ?

I think you need a PCI driver to support your card properly.

Wolfgang.

