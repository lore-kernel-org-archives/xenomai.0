Message-ID: <455190DE.6030907@domain.hid>
Date: Wed, 08 Nov 2006 09:10:06 +0100
From: Philipp Keller <philipp.keller@domain.hid>
MIME-Version: 1.0
References: <E1Ghhup-00044v-VB@server-r004.hostpoint.ch>
In-Reply-To: <E1Ghhup-00044v-VB@server-r004.hostpoint.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Re: Xenomai-help Digest, Vol 14, Issue 11
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

xenomai-help-request@domain.hid wrote:

> Send Xenomai-help mailing list submissions to
> 	xenomai@xenomai.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://mail.gna.org/listinfo/xenomai-help
> or, via email, send a message with subject or body 'help' to
> 	xenomai-help-request@domain.hid
>
> You can reach the person managing the list at
> 	xenomai-help-owner@domain.hid
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Xenomai-help digest..."
>
>
> Today's Topics:
>
>    1. RT-SocketCan + Xenomai on MPC5200B (Daniel Schnell)
>    2. Re: RT-SocketCan + Xenomai on MPC5200B (Wolfgang Grandegger)
>    3. RE: RT-SocketCan + Xenomai on MPC5200B (Daniel Schnell)
>    4. Re: RT-SocketCan + Xenomai on MPC5200B (Wolfgang Grandegger)
>    5. RE: RT-SocketCan + Xenomai on MPC5200B (Daniel Schnell)
>    6. RE: RT-SocketCan + Xenomai on MPC5200B (Daniel Schnell)
>    7. Re: RT-SocketCan + Xenomai on MPC5200B (Wolfgang Grandegger)
>    8. Xenomai on Athlon XP (and PIII) (Wolfgang Grandegger)
>    9. Re: RT-SocketCan + Xenomai on MPC5200B  (Wolfgang Denk)
>   10. Re: Xenomai on Athlon XP (and PIII) (Jan Kiszka)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 7 Nov 2006 13:43:16 -0000
> From: "Daniel Schnell" <daniel.schnell@domain.hid>
> Subject: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
> To: <xenomai@xenomai.org>
> Message-ID:
> 	<DD39B5C3F4963040ADC9768BE7E430CB014DEFC4@domain.hid>
> Content-Type: text/plain; charset="us-ascii"
>
> Hi,
>  
> I am struggling with Xenomai latest SVN and RT-Socket-CAN on a MPC5200B
> with MSCAN driver inside a Denx 2.4.25 kernel.
>  
> Does anybody have this configuration actively running ? How do you use
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
>  
> Actually the first rtcansend command does not seem to work, because a
> connected CAN IO unit doesn't show any reaction.
>  
>  
> Any ideas ?
>   
With that configuration, one has to half the baudrate (at least that
helps in our case using the same HW). We are configuring for 500kbits in
a 1Mbits network.
>  
> Regards,
>  
> Daniel Schnell.
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: /public/xenomai-help/attachments/20061107/3a217ca5/attachment.htm
>
> ------------------------------
>
> Message: 2
> Date: Tue, 07 Nov 2006 15:03:12 +0100
> From: Wolfgang Grandegger <wg@domain.hid>
> Subject: Re: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
> To: Daniel Schnell <daniel.schnell@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID: <45509220.1050506@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Daniel Schnell wrote:
>   
>> Hi,
>>  
>> I am struggling with Xenomai latest SVN and RT-Socket-CAN on a MPC5200B 
>> with MSCAN driver inside a Denx 2.4.25 kernel.
>>  
>> Does anybody have this configuration actively running ? How do you use 
>>     
>
> Yes.
>
>   
>> the provided rtcansend/rtcanreceive functions, so they actually transfer 
>> data over the wires ?
>>  
>> I was doing the following:
>> rtcanconfig rtcan0 -b 125000 start
>> rtcansend rtcan0 -i 0 0x1 0x0
>> (returns)
>> rtcansend rtcan0 -i 0x1 0x0
>> (hangs, never comes back)
>>  
>> Actually the first rtcansend command does not seem to work, because a 
>> connected CAN IO unit doesn't show any reaction.
>>     
>
> The first message seems not to go out to the wire and the second send 
> blocks because the TX done interrupt of the first message has not yet 
> occured (no TX hardware slot free). Is there a CAN node able to receive 
> the message?
>
>   
>> Any ideas ?
>>     
>
> Likely, you have a problem with your clock setting, TX/RX routing or 
> cabeling (termination etc.).
>
> Wolfgang.
>
>
>
>
> ------------------------------
>
> Message: 3
> Date: Tue, 7 Nov 2006 14:22:10 -0000
> From: "Daniel Schnell" <daniel.schnell@domain.hid>
> Subject: RE: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
> Cc: <xenomai@xenomai.org>
> Message-ID:
> 	<DD39B5C3F4963040ADC9768BE7E430CB014DEFF0@domain.hid>
> Content-Type: text/plain;	charset="us-ascii"
>
> Wolfgang Grandegger wrote:
>  
>   
>> The first message seems not to go out to the wire and the second send
>> blocks because the TX done interrupt of the first message has not yet
>> occured (no TX hardware slot free). Is there a CAN node able to
>> receive the message?   
>>     
>
> Yes, there is an IO unit which normally reacts on that message
>  
>   
>> Likely, you have a problem with your clock setting, TX/RX routing or
>> cabeling (termination etc.). 
>>     
>
>
> I would suspect it is the clock setting, as we have also problems with
> clock_nanosleep() running 4 times too fast. I assume then that the IPB
> clock frequency is wrong ?
>
>
> How do you setup your CAN network for a test ? Which commands do you use
> ?
>
> Best regards,
>
> Daniel Schnell.
>
>
>
> ------------------------------
>
> Message: 4
> Date: Tue, 07 Nov 2006 15:35:30 +0100
> From: Wolfgang Grandegger <wg@domain.hid>
> Subject: Re: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
> To: Daniel Schnell <daniel.schnell@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID: <455099B2.5030402@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Daniel Schnell wrote:
>   
>> Wolfgang Grandegger wrote:
>>  
>>     
>>> The first message seems not to go out to the wire and the second send
>>> blocks because the TX done interrupt of the first message has not yet
>>> occured (no TX hardware slot free). Is there a CAN node able to
>>> receive the message?   
>>>       
>> Yes, there is an IO unit which normally reacts on that message
>>  
>>     
>>> Likely, you have a problem with your clock setting, TX/RX routing or
>>> cabeling (termination etc.). 
>>>       
>> I would suspect it is the clock setting, as we have also problems with
>> clock_nanosleep() running 4 times too fast. I assume then that the IPB
>> clock frequency is wrong ?
>>     
>
> On a Rev. B you normally set the CAN system clock to 33MHz via kernel 
> configuration parameter. Is CAN TX/RX on PSC2?
>
>
>   
>> How do you setup your CAN network for a test ? Which commands do you use
>> ?
>>     
>
> Your setup with rtcanconfig was OK, or what do you mean.
>
> Do you have terminators on both ends of the cable?
>
> Wolfgang.
>
>
>
>
> ------------------------------
>
> Message: 5
> Date: Tue, 7 Nov 2006 14:39:03 -0000
> From: "Daniel Schnell" <daniel.schnell@domain.hid>
> Subject: RE: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
> To: "Syed Amer Gilani" <amg@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID:
> 	<DD39B5C3F4963040ADC9768BE7E430CB014DF008@domain.hid>
> Content-Type: text/plain;	charset="us-ascii"
>
> Syed Amer Gilani wrote:
>  
>   
>> I had similar problems, but with a 2.6.18 Kernel. Check you Kernel
>> configurations of mscan. The default clock of 66Mhz is possibly
>> wrong, on my mpc5200b board it is 33Mhz. And also check the Pin
>> Configuration. I had also no termination on board, so i had to add it
>> to the cable.   
>>     
>
>
> Hi,
>
> This fixed it: setting it from 66MHz to 33MHz in the MSCAN
> configuration. At least the IOUnit gets messages now. Thanks a lot !!
>
> If now only the clock_nanosleep() would wait as long as expected and
> would not return after 1/4 of the time ....
>
>
>
> Best regards,
>
> Daniel.
>
>
>
> ------------------------------
>
> Message: 6
> Date: Tue, 7 Nov 2006 14:45:35 -0000
> From: "Daniel Schnell" <daniel.schnell@domain.hid>
> Subject: RE: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
> To: <xenomai@xenomai.org>
> Message-ID:
> 	<DD39B5C3F4963040ADC9768BE7E430CB014DF00D@is-hdq-exchange.marel.net>
> Content-Type: text/plain;	charset="us-ascii"
>
> Wolfgang Grandegger wrote:
>
>   
>> On a Rev. B you normally set the CAN system clock to 33MHz via kernel
>> configuration parameter. Is CAN TX/RX on PSC2? 
>>     
>
> Yes 33 MHz was the magic number. Hmmm, shouldn't that not be set
> automatically if MPC5200B is selected ?
> The CAN in our case is on I2C1/TMR01
>
>
>   
>>> How do you setup your CAN network for a test ? Which commands do you
>>> use ?
>>>       
>> Your setup with rtcanconfig was OK, or what do you mean.
>>     
>
> I mean physically. E.g. for a MPC5200B with two CAN ports you could make
> a send/receive ping/pong with a sort of nullmodem cable. Additionally
> you need a test case. Just wanted to know how your test setup looks
> like.
>
>
>   
>> Do you have terminators on both ends of the cable?
>>     
>
> Yes everything is fine here.
>
>
> Best regards,
>
> Daniel.
>
>
>
> ------------------------------
>
> Message: 7
> Date: Tue, 07 Nov 2006 16:02:40 +0100
> From: Wolfgang Grandegger <wg@domain.hid>
> Subject: Re: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
> To: Daniel Schnell <daniel.schnell@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID: <4550A010.3090103@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Daniel Schnell wrote:
>   
>> Syed Amer Gilani wrote:
>>  
>>     
>>> I had similar problems, but with a 2.6.18 Kernel. Check you Kernel
>>> configurations of mscan. The default clock of 66Mhz is possibly
>>> wrong, on my mpc5200b board it is 33Mhz. And also check the Pin
>>> Configuration. I had also no termination on board, so i had to add it
>>> to the cable.   
>>>       
>> Hi,
>>
>> This fixed it: setting it from 66MHz to 33MHz in the MSCAN
>> configuration. At least the IOUnit gets messages now. Thanks a lot !!
>>     
>
> I will make this the default on MPC5200B. You are not the first on 
> stumbling over this quirk.
>
>   
>> If now only the clock_nanosleep() would wait as long as expected and
>> would not return after 1/4 of the time ....
>>     
>
> Do you have a little demo program demonstrating the problem?
>
> Wolfgang.
>
>
>
> ------------------------------
>
> Message: 8
> Date: Tue, 07 Nov 2006 21:08:06 +0100
> From: Wolfgang Grandegger <wg@domain.hid>
> Subject: [Xenomai-help] Xenomai on Athlon XP (and PIII)
> To: xenomai@xenomai.org
> Message-ID: <4550E7A6.9090408@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Hello,
>
> I'm currently setting up a PC for Xenomai-Tests. I'm using my good old 
> PC with an Athlon XP (Thunderbird) for this purpose. The kernel hangs at 
> boot time when I enable APIC via boot argument (lapic). With local APIC 
> disabled the kernel boots but I see some Opps messages while running the 
> latency test and trying a slogin to the system (in the scheduler). Are 
> there any known issues with this X86 arch? I remember, that I have seen 
> similar problems with my (old) PIII-Notebook (lapic did not work).
>
> I will be more precise when time permits.
>
> Wolfgang.
>
>
>
> ------------------------------
>
> Message: 9
> Date: Tue, 07 Nov 2006 21:31:39 +0100
> From: Wolfgang Denk <wd@domain.hid>
> Subject: Re: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B 
> To: "Daniel Schnell" <daniel.schnell@domain.hid>
> Cc: xenomai@xenomai.org
> Message-ID: <20061107203139.00DAC353B57@domain.hid>
> Content-Type: text/plain; charset=ISO-8859-1
>
> In message <DD39B5C3F4963040ADC9768BE7E430CB014DEFF0@domain.hid> you wrote:
>   
>> I would suspect it is the clock setting, as we have also problems with
>> clock_nanosleep() running 4 times too fast. I assume then that the IPB
>> clock frequency is wrong ?
>>     
>
> As you can see from the U-Boot startup messages,  the  IPB  clock  on
> your board is set to 66 MHz.
>
> Best regards,
>
> Wolfgang Denk
>
>   


 
-- 
Philipp Keller
Software Development

Neuronics AG
Technoparkstrasse 1
8005 Zuerich / Switzerland
Tel +41 44 445 16 40
Fax +41 44 445 16 44
www.neuronics.ch
-- 



