Message-ID: <529B2FFD.7000702@xenomai.org>
Date: Sun, 01 Dec 2013 13:47:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAB8-diJhHwSrKa1zYmSCGowOXVN_Rb2e2wPU0WkkLR+29pgV1g@mail.gmail.com>
In-Reply-To: <CAB8-diJhHwSrKa1zYmSCGowOXVN_Rb2e2wPU0WkkLR+29pgV1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Fail to load the xeno_16550A real time serial port
 driver on Beaglebone Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: sf sdf <amfarmr@gmail.com>
Cc: xenomai@xenomai.org

On 12/01/2013 01:25 PM, sf sdf wrote:
> Hello,
> 
> I am using debian(3.8.13xenomai-bone28) on Beaglebone Black. I got some
> errors in loading the xeno_16550A real time serial port driver on
> Beaglebone Black.
> 
> dmesg|grep tty
> 
>> [    0.000000] Kernel command line: console=ttyO0,115200n8
>> capemgr.enable_partno=BB-UART1,BB-UART2,BB-UART5,BB-SPIDEV0,BB-SPIDEV1,BB-CANBUS1
>> root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait fixrtc ip=
>> [    0.880381] 44e09000.serial: ttyO0 at MMIO 0x44e09000 (irq = 88) is a
>> OMAP UART0
>> [    1.689899] console [ttyO0] enabled
>> [    2.583705] 48022000.serial: ttyO1 at MMIO 0x48022000 (irq = 89) is a
>> OMAP UART1
>> [    2.700468] 48024000.serial: ttyO2 at MMIO 0x48024000 (irq = 90) is a
>> OMAP UART2
>> [    2.824139] 481aa000.serial: ttyO5 at MMIO 0x481aa000 (irq = 62) is a
>> OMAP UART5
> 
> 
> According to the information above, uart2's mmio is 0x48024000 and irq =
> 90.
> 
> From other documentations, I found this definition:
> 
> Pin Name         DT Offset
> UART2_TXD    0x154
> UART2_RXD    0x150
> 
> 
> Then I execute some commands below according to
> http://www.xenomai.org/index.php/16550A, but it dosen't work!
> 
> 
> *setserial /dev/ttyO2*
> 
>> /dev/ttyO2, UART: undefined, Port: 0x0000, IRQ: 90
> 
> 
> *setserial /dev/ttyO2 uart none*
> 
>> Cannot set serial info: Invalid argument

Stop right there, everything which happens after is meaningless: the
driver does not seem to support the ioctls supported by setserial. You
should try to turn off CONFIG_SERIAL_OMAP in kernel configuration and
turn on CONFIG_SERIAL_8250 instead but beware, the console will change
name from /dev/ttyO2 to /dev/ttyS2.

Regards.

-- 
                                                                Gilles.

