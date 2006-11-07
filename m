Message-ID: <455099B2.5030402@domain.hid>
Date: Tue, 07 Nov 2006 15:35:30 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
References: <DD39B5C3F4963040ADC9768BE7E430CB014DEFF0@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB014DEFF0@domain.hid>
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
> Wolfgang Grandegger wrote:
>  
>> The first message seems not to go out to the wire and the second send
>> blocks because the TX done interrupt of the first message has not yet
>> occured (no TX hardware slot free). Is there a CAN node able to
>> receive the message?   
> 
> Yes, there is an IO unit which normally reacts on that message
>  
>> Likely, you have a problem with your clock setting, TX/RX routing or
>> cabeling (termination etc.). 
> 
> 
> I would suspect it is the clock setting, as we have also problems with
> clock_nanosleep() running 4 times too fast. I assume then that the IPB
> clock frequency is wrong ?

On a Rev. B you normally set the CAN system clock to 33MHz via kernel 
configuration parameter. Is CAN TX/RX on PSC2?


> How do you setup your CAN network for a test ? Which commands do you use
> ?

Your setup with rtcanconfig was OK, or what do you mean.

Do you have terminators on both ends of the cable?

Wolfgang.


