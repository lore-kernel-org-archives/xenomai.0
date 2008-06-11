Message-ID: <484F88CB.4090902@domain.hid>
Date: Wed, 11 Jun 2008 10:11:55 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <2f7417810806110043o4fbac699h318f33b7b7359d88@domain.hid>
In-Reply-To: <2f7417810806110043o4fbac699h318f33b7b7359d88@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Help rtcan and MCP5200...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: quinty quinty <webquinty2@domain.hid>
Cc: xenomai@xenomai.org

quinty quinty wrote:
> Hello,
> 
> I have a MPX5200G develop board and I use xenomai to test real time task.
> My problem is that I do not know how to configurate RT-Can driver in
> kernel options.
> 
> ======================================
> *U-Boot 1.3.0 (Feb 13 2008 -
> 10:14:17)                                          
> CPU:   MPC5200B v2.2, Core v1.4 at 396 Mhz
> Bus 132 MHz, IPB 132 MHz, PCI 66 MHz                                    
> Board: MicroSys
> MPX5200R3/CRX02                                                
> I2C:   85 kHz,
> ready                                                           
> DRAM:  128
> MB                                                                  
> FLASH: 16
> MB                                                                   
> *======================================
> 
> An now, kernel options of RT-CAN:
> 
> ======================================
> *[x]MSCAN driver for MPC52xx
>      [x]Enable CAN 1
>      [x]Enable CAN 2
>      (132000000) Clock Frequency in Hz

Most probably, you need 33000000 here. Please read the help for thins
option.

>      Pin Configuration
>            [ ]CAN 1 on I2C1 pins, CAN 2 on TMR01 pins
>            [x]CAN 1 and 2 on PSC2 pins*
> ======================================
> 
> Well, I have connected a can device, and I executed ./rtcanrecv rtcan1
> --verbose, but I do not receive anything.
> But, If I used can without rtcan, for example,
> *ifconfig can0 up
> canconfig can0 --baudrate=500000 up
> candump can0
> *I received messages from device, then I understand that problem is in
> configuration of RT-CAN driver.

Oops, you can not use both, Socket-CAN and RT-Socket-CAN on the same CAN
device. Please disable Socket-CAN in you kernel configuration if you
want to use RT-Socket-CAN. What kernel version do you use?

Wolfgang.

