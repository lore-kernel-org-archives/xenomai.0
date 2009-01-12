From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Mon, 12 Jan 2009 18:10:41 +0100
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<496B6B66.7070905@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2004DF7840E1@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2004DF7840E1@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901121810.42126.Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] [Socketcan-users] rtcanconfig rtcansend rtcanrecv
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Charlton, John" <john.charlton@domain.hid>
Cc: xenomai@xenomai.org, "socketcan-users@domain.hid" <socketcan-users@domain.hid>

Charlton, John wrote:
> root@domain.hid:~$ cat /proc/rtcan/rtcan1/registers
> SJA1000 registers
> 00: 00 00 0c 02 ff 00 03 1c 1a 00 00 00 00 60 00 00
> 10: 08 00 20 01 02 03 04 05 06 07 08 ff 20 00 00 c8
> root@domain.hid:~$ cat /proc/rtcan/rtcan0/registers
> SJA1000 registers
> 00: 00 00 0d 01 ff 00 03 1c 1a 00 00 00 00 60 00 00
> 10: 08 00 20 01 02 03 04 05 06 07 08 bf 00 01 00 c8

Register 0x03 reflects the exact interrupt bits. They mean that a RX interrupt 
occured on rtcan0 (0x01) and a TX interrupt on rtcan1 (0x02). Now this is 
interesting as it seems that your system does not get those interrrupts the 
SJA1000s generate. Are you sure your IRQs that you specify on insmod are 
really the correct ones?

-- 
Sebastian

