From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Date: Thu, 19 Nov 2009 19:09:52 +0100
References: <4B058624.6000401@domain.hid>
In-Reply-To: <4B058624.6000401@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200911191909.52793.Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] problem with RT-Socket-CAN xeno_can_isa module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Alessio Margan @ IIT" <alessio.margan@domain.hid>
Cc: xenomai@xenomai.org

Alessio Margan @ IIT wrote:
> Hi,
>
> I've got a problem using RT-Socket-CAN with module xeno_can_isa.
> The system has a pcan-pc/104 board with a sja1000
> The first tme I load to module with
> sudo modprobe xeno_can_isa io=0x300,0x320 irq=10,11
> everything work fine, then if I try to unload the module seems that the
> ioport region remain allocated from xeno_can_isa
> but the module is unloaded and if I try to load it again the command
> fail with "Device or resource busy" and I have to reboot.
> I miss something ?

You are right, the IO regions are not released properly at module unload time. 
I will prepare a patch tomorrow (if Wolfgang does not do it before).

-- 
Sebastian

