Message-ID: <4550A010.3090103@domain.hid>
Date: Tue, 07 Nov 2006 16:02:40 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RT-SocketCan + Xenomai on MPC5200B
References: <DD39B5C3F4963040ADC9768BE7E430CB014DF008@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB014DF008@domain.hid>
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
> Syed Amer Gilani wrote:
>  
>> I had similar problems, but with a 2.6.18 Kernel. Check you Kernel
>> configurations of mscan. The default clock of 66Mhz is possibly
>> wrong, on my mpc5200b board it is 33Mhz. And also check the Pin
>> Configuration. I had also no termination on board, so i had to add it
>> to the cable.   
> 
> 
> Hi,
> 
> This fixed it: setting it from 66MHz to 33MHz in the MSCAN
> configuration. At least the IOUnit gets messages now. Thanks a lot !!

I will make this the default on MPC5200B. You are not the first on 
stumbling over this quirk.

> If now only the clock_nanosleep() would wait as long as expected and
> would not return after 1/4 of the time ....

Do you have a little demo program demonstrating the problem?

Wolfgang.

