Message-ID: <4350D182.5060608@domain.hid>
Date: Sat, 15 Oct 2005 11:53:06 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] XenoPPC:NoAltivec
References: <13527.193.52.24.125.1129367011.squirrel@domain.hid>
In-Reply-To: <13527.193.52.24.125.1129367011.squirrel@domain.hid>
Content-Type: text/plain; charset=us-ascii
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

On 10/15/2005 11:03 AM smannori@domain.hid wrote:
> Hi:
> 
> disabling the Altivec in the kernel "kill" the X server. Anywai I completd
> the Xenomai installation (make menuconfig). Without FP support.

I also observed big latencies with X running on my iBook2.

> Now the latency test works (26 min) no overrun, max latency = 17us.
> I will leave the PPC machine running ...

Is this figure with load, e.g. using "ping -f" of some kind of disk access?

> I will test the new adeos patch for kernel 2.6.13 this night.
> 
> Thanks to everybody
> 
>     Simone
> 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 
> 


