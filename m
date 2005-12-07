Message-ID: <4397067A.9010206@domain.hid>
Date: Wed, 07 Dec 2005 17:57:46 +0200
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
> 
> I think that I can live and prosper without FPU support in the kernel, but I
> suppose also that someone is interested in this - possibile - limitation e/o
> potential bug.

Be a bit more specific, please:
- compiler version,
- kernel version,
- i-pipe version,
- xenomai version,
- environment where the bug happens (what else is running, like 
X11/glQuake...)
I could take a look at this, if I can reproduce it.

-- Heikki Lindholm

