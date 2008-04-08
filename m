Message-ID: <47FBA907.10603@domain.hid>
Date: Tue, 08 Apr 2008 19:19:03 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <20080408223922.nvcellilwc8wccsg@domain.hid>
In-Reply-To: <20080408223922.nvcellilwc8wccsg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] CAN Probleme
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Urs Eichholzer <urs.eichholzer@domain.hid>
Cc: xenomai@xenomai.org

Hi Urs,

Urs Eichholzer wrote:
> Hello
> 
> We are just start to use the setup...
> We try to read parameters from a device true the CAN. From some parameters we
> get proper replay and with other parameters we get the following message:
> rtcan0: btr0=0x05 btr1=0x4f
> rtcan0: btr0=0x0a btr1=0x6f
> rtcan_mscan_start_xmit: TX buffer not empty

Hm, this message is pretty fatal. What version of Linux and Xenomai do
you use? What type of parameters do you read when the error message
shows up. Can you reproduce the problem with a little example program?

Thanks,


