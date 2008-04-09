Message-ID: <20080409202347.zr3fs5i3kk0ococ4@domain.hid>
Date: Wed, 09 Apr 2008 20:23:47 +0700
From: Urs Eichholzer <urs.eichholzer@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=TIS-620
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] CAN
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

Hi

We are using Linux 2.6.19.2 and Xenomai 2.3.0

The problem disapeared when we not changed the baudrate (we try to scan the
bus..). What shoult be the time between changing the baudrate?

Thank's

Urs

From: Wolfgang Grandegger [wg@domain.hid]
Sent: Wednesday, April 09, 2008 12:19 AM
To: Urs Eichholzer
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai-help] CAN Probleme

Hi Urs,

Urs Eichholzer wrote:
> Hello
>
> We are just start to use the setup...
> We try to read parameters from a device true the CAN. From some
> parameters we get proper replay and with other parameters we get the
> following message:
> rtcan0: btr0=0x05 btr1=0x4f
> rtcan0: btr0=0x0a btr1=0x6f
> rtcan_mscan_start_xmit: TX buffer not empty

Hm, this message is pretty fatal. What version of Linux and Xenomai do you use?
What type of parameters do you read when the error message shows up. Can you
reproduce the problem with a little example program?

Thanks,


----------------------------------------------------------------
This message was sent using Samart Web Mail 2005.


