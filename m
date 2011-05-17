Message-ID: <4DD2214A.6070404@domain.hid>
Date: Tue, 17 May 2011 09:18:34 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7999@domain.hid>
	<4DCD0DFC.7050506@domain.hid>
	<294B28951EBE8146839AF99A61CB5FCE6B3F1A7DDD@SI-MBX17.de.bosch.com>
In-Reply-To: <294B28951EBE8146839AF99A61CB5FCE6B3F1A7DDD@SI-MBX17.de.bosch.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Same problems with ipipe-2.6.37-x86-branch on
	Core 2 Duo E8400
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Benner Bernd (MH/EES)" <B.Benner@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2011-05-16 12:18, Benner Bernd (MH/EES) wrote:
> Hi,
> 
>    thank your for the support!
> 
>     I have upgraded to the ipipe-2.6.37-x86 branch. ( kernel-2.6.37.6,xenomai-2.5.6 )
>   The system will start on all computers I test it.
>   The latency application is running well on a Pentium-M- system and a Mobile Core 2 Duo 2,26 GHz -system.
>   On a HP and a Lenovo Desktop Core 2 Duo 3 Ghz system ( Core 2 Duo E8400 ), a start of latency will freeze the
>  system after output of the warmup console message.
> 
>     A start of cyclictest over ssh will not fully freeze the 3 GHz systems. cyclictest will not update the ssh console output.
>   On the local console the system will slow down and there are Kernel error messages from the SATA driver after input of a
>   command. With "slow keyboard inputs", I am able to kill cyclictest. There are some error messages from background file requests, but I am able to enter and execute commands.
> 
>     I have attached my kernel config.
> 
>    Is there a smp consistency problem on task creation ?
> 
>    Is there any way to find the reason of the problems on fast Core 2 Duo machines?
> 
>    Our older system with Kernel 2.6.29 and xenomai-2.4.10 has no problem on all this machines.
> 

I've tried your .config with xenomai-2.6 git without noticeable
problems. Could you try with that Xenomai version as well?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

