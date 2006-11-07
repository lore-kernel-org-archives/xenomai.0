Message-ID: <45509220.1050506@domain.hid>
Date: Tue, 07 Nov 2006 15:03:12 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
References: <DD39B5C3F4963040ADC9768BE7E430CB014DEFC4@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB014DEFC4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Hi,
>  
> I am struggling with Xenomai latest SVN and RT-Socket-CAN on a MPC5200B 
> with MSCAN driver inside a Denx 2.4.25 kernel.
>  
> Does anybody have this configuration actively running ? How do you use 

Yes.

> the provided rtcansend/rtcanreceive functions, so they actually transfer 
> data over the wires ?
>  
> I was doing the following:
> rtcanconfig rtcan0 -b 125000 start
> rtcansend rtcan0 -i 0 0x1 0x0
> (returns)
> rtcansend rtcan0 -i 0x1 0x0
> (hangs, never comes back)
>  
> Actually the first rtcansend command does not seem to work, because a 
> connected CAN IO unit doesn't show any reaction.

The first message seems not to go out to the wire and the second send 
blocks because the TX done interrupt of the first message has not yet 
occured (no TX hardware slot free). Is there a CAN node able to receive 
the message?

> Any ideas ?

Likely, you have a problem with your clock setting, TX/RX routing or 
cabeling (termination etc.).

Wolfgang.


