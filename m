Message-ID: <496B6B66.7070905@domain.hid>
Date: Mon, 12 Jan 2009 17:10:14 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>	<200901071828.31323.Sebastian.Smolorz@domain.hid>	<CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>	<4965D651.5010808@domain.hid>	<CF7FB0793253794F9F45991443E5FE2003E4EFB9BA@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2004DF784062@domain.hid>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2004DF784062@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "socketcan-users@domain.hid" <socketcan-users@domain.hid>

Charlton, John wrote:
> I am attaching an updated rtcan_tscan1.c driver for the TS_CAN1 PC-104 CAN interface.  I have only attempted to configure it for x86 so it is not configured for ARM or any other architecture.
> 
> I tried to build lincan-0.3.3 for linux-2.6.27.7 and so far have not
> succeeded so I have returned to testing the rtcan_tscan1.c module in
> xenomai-2.4.6.1.  I wait for input from rtcan0 in one terminal and
> send to rtcan1 in another terminal. From previous tests the send does not block the first time but always
> blocks on the second attempt (or in this case with multiple loops)
> with a socket filter of -1.  The details are below:
> 
> root@domain.hid:~$ rtcanconfig rtcan0 --verbose --baudrate=125000 start
> mode: start (0x1)
> baudrate: 125000
> root@domain.hid:~$ rtcanconfig rtcan1 --verbose --baudrate=125000 start
> mode: start (0x1)
> baudrate: 125000
> root@domain.hid:~$ cat /proc/rtcan/devices
> Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
> rtcan0             125000 active            0          0          0
> rtcan1             125000 active            0          0          0
> root@domain.hid:~$ cat /proc/rtcan/sockets
> fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX_Lo
> root@domain.hid:~$ rtcanrecv rtcan0 --verbose --error=0xffff
> interface rtcan0
> s=0, ifr_name=rtcan0
> Using err_mask=0xffff
> 
>>> Blocks waiting for input
> 
>>> In another terminal:
> rtcansend -d 500 -l 10 rtcan1 1 2 3 4 5 6 7 8
> 
> blocks waiting for transmit
> 
> In a third terminal:
> 
> root@domain.hid:~$ cat /proc/rtcan/sockets
> fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX_Lo
>  1                     -1 0x00000      infinite      infinite          0     1
>  0                      1 0x0ffff      infinite      infinite          0     1
> root@domain.hid:~$ cat /proc/rtcan0/info
> cat: /proc/rtcan0/info: No such file or directory
> root@domain.hid:~$ cat /proc/rtcan/rtcan0/info
> Device     rtcan0
> Controller SJA1000
> Board      TSCAN1-Board
> Clock-Hz   8000000
> Baudrate   125000
> Bit-time   brp=4 prop_seg=0 phase_seg1=13 phase_seg2=2 sjw=1 sam=0
> Ctrl-Mode
> State      active
> TX-Counter 0
> RX-Counter 0
> Errors     0
> Refcount   0
> root@domain.hid:~$ cat /proc/rtcan/rtcan1/info
> Device     rtcan1
> Controller SJA1000
> Board      TSCAN1-Board
> Clock-Hz   8000000
> Baudrate   125000
> Bit-time   brp=4 prop_seg=0 phase_seg1=13 phase_seg2=2 sjw=1 sam=0
> Ctrl-Mode
> State      active
> TX-Counter 1
> RX-Counter 0
> Errors     0
> Refcount   1
> root@domain.hid:~$
> 
> I am not sure what the 'Filter' parameter does.  in the send socket,
> it is -1 and in the receive socket it is 1. Since the receive socket
> doesn't receive anything it indicates that the send never goes out on
> the wire or the receive interrupt is not occurring.
> 
> If I do this:
> root@domain.hid:~$ rtcanrecv rtcan0 --verbose --error=0xffff --filter=-1:-1:1:1
> Filter #0: id=0xffffffff mask=0xffffffff
> Filter #1: id=0x00000001 mask=0x00000001
> interface rtcan0
> s=0, ifr_name=rtcan0
> Using err_mask=0xffff
> 
> The filter parameter is set to 2 for the receiver socket:
> root@domain.hid:~$ cat /proc/rtcan/sockets
> fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX_Lo
>  0                      2 0x0ffff      infinite      infinite          0     1
>  1                     -1 0x00000      infinite      infinite          0     1
> root@domain.hid:~$
> 
> Both send and receive sockets remain blocked.

The TX done interrupt does not come indicating that the hardware is not
configured or handled correctly. To simplify debugging

- connect an external known-to-work node your CAN bus, preferably a
  CAN bus analyzer, to receive and send CAN messages.

- To inspect the SJA1000 registers und /proc/rtcan/rtcan[01]/registers,
  enable the Kconfig option XENO_DRIVERS_CAN_DEBUG:

  http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/Kconfig#009

Wolfgang.



