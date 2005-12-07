Message-ID: <4397030C.7060603@domain.hid>
Date: Wed, 07 Dec 2005 17:43:08 +0200
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai-PPC: One problem
References: <38086.128.93.12.158.1133967095.squirrel@domain.hid>
In-Reply-To: <38086.128.93.12.158.1133967095.squirrel@domain.hid>
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
To: smannori@domain.hid
Cc: xenomai@xenomai.org

smannori@domain.hid kirjoitti:
> Hi everybody,
> 
> thanks to your help now the interrupt shield option compile OK :)
> 
> Unfortunately, I must to leave the Xenomai FPU option disabled.
> 
> With this option active my PowerBook "Ubuntu-Xenomai" machine go crazy after
> few seconds after the launch of the the "latency" test.
> 
> Gilles suspects that there is a conflict with the Altivec FPU units inside
> the G4 CPU, because ADEOS does not save the Altivec FPU-exended register.

I find this very unlikely. Unlike Intel SSE stuff, ppc altivec is a 
separate unit from the fpu. If your compiler generates altivec code 
(instead of normal fpu code) from math functions in the xenomai 
executable, then it might be the issue. AFAIK gcc uses altivec only 
after release 4.0. In case you have gcc 4 (ubuntu 5.10), you might be 
able to turn altivec code generation off by, say, "-mno-altivec".

-- Heikki Lindholm


