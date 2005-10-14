Message-ID: <434FB732.1020502@domain.hid>
Date: Fri, 14 Oct 2005 15:48:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai -> PPC
References: <22826.193.52.24.125.1129297430.squirrel@domain.hid>
In-Reply-To: <22826.193.52.24.125.1129297430.squirrel@domain.hid>
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

smannori@domain.hid wrote:
> Hi:
> 
> waiting some hints on x86 machine, I'm playing with may PowerBook 1.67 GHz.
> The 80GB is split equally bettewen MacOS X and Mandrake (Mandriva PPC 10.2).
> 
>>From xenomai/arc/ppc/patches and www.adeos.org I see that le latest kernel
> supported is the 2.6.10. Relase that I like BUT, unfortunately, there is NOT
> support for PowerBook audio and network. I tried anyway to install xenomai.
> The usal phase are OK but the /testsuite/latency/run is not stable: it kill
> itself after few second.
>

Any kernel message being displayed before chaos ?

> Maybe there is some residual bug inside the ADEOS patch ?
> 
> It wuold be a great news if someone will produce a patch for the latest
> 2.6.13, which support all the PowerBook peripherial.
> 
> At this momenent there is no realtime support for PowerBook using 2.6.x
> kernel, and I don't know if the latest Mandriva can run with 2.4 kernel or
> if an adeos-patched 2.4.x is able to run Xenomai.
> 
> All my previous effort to install RTAI 3.2 with kernel 2.6 was completely
> unsuccessfull.
> 
> Thanks in advance for your help
>

A port of the Adeos/I-pipe series to 2.6.13 for PPC is underway. I need it too 
actually.

-- 

Philippe.

