Message-ID: <44144469.5060508@domain.hid>
Date: Sun, 12 Mar 2006 16:55:21 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] PRNG not seeded on AMD K7
References: <fd6a47a90603120709k2dcc2a4h@domain.hid>
In-Reply-To: <fd6a47a90603120709k2dcc2a4h@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jeroen Van den Keybus wrote:
> When I try to open an ssh connection to or from a PC running Xenomai, I 
> get a 'PRNG not seeded' error. However, it only occurs when an RT 
> application is running (such as 'latency'). The computer on which this 
> occurs is an AMD K7-650. I've tested on a Pentium III 500 as well 
> (nearly same .config) and this error doesn't show up then.
>  
> Any idea of where I should start debugging ? I assume that PRNG stands 
> for 'Programmable Random Number Generator' or something like that.

First guess: something might be perturbated by Xeno's FPU management on AMD; the 
fact that /dev/random might be involved in the issue would tend to confirm this.
Does disabling CONFIG_XENO_HW_FPU on the AMD box change anything?

>  
> Jeroen.
>  
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

