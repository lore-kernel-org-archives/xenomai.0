From: Bernhard Walle <bernhard.walle@domain.hid>
Date: Tue, 8 Aug 2006 16:45:32 +0200
Message-ID: <clkmq3-vuf.ln1@domain.hid>
References: <eba3t8$i1q$1@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Re: rtdm xeno_16550A and usb-serial converter
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

Marco Jackel <ich@domain.hid> [2006-08-08]:
> Is it possible to use an usb-serial converter with the rtdm serial
> driver? Is there a difference between RS422 and RS232?

No. The RTDM Serial driver communicates with the UART of the PC. For a
usb-serial converter you would need a USB real-time stack (which is
available with usb4rt). And not all usb-serial converters are the same,
I know at least two types: ftdi_sio and pl2303 which seems to be most
common. In linux/drivers/usb/serial there are quite more. So you need a
driver for each converter based on usb4rt.

I think it's easier to buy a serial PCI card. :)


Regards,
  Bernhard
-- 
"My great concern is not whether you have failed, but whether
 you are content with your failure." 
         -- Abraham Lincoln


