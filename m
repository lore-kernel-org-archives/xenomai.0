Message-ID: <439AB42F.3040303@domain.hid>
Date: Sat, 10 Dec 2005 11:55:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Boot problem V2.0.1 with Kernel 2.6.12
References: <439995C0.6030006@domain.hid>
	<200512091658.39610.s.zimmermann@domain.hid>
In-Reply-To: <200512091658.39610.s.zimmermann@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: s.zimmermann@domain.hid
Cc: xenomai@xenomai.org

Stephan Zimmermann wrote:
> Hello all,
> I am facing a Problem with Xenomai 2.0.1 on Kernel 2.6.12. Based on my working 
> config, I have patched the Kernel and recompiled. Now the System hangs at 
> startup. There is no errormessage or so.
>

The Adeos patch for 2.6.12 is an oldgen one; it is known to be bugous 
for certain hw configurations, causing boot lockup. The best way to 
solve this is to upgrade to 2.6.13 or preferably 2.6.14, and use a 
recent newgen (ipipe) patch available here: 
http://download.gna.org/adeos/patches/v2.6/adeos/i386/


> ---snip---
> Starting hotplug subsystem
> 	pci
> ---snap---
> 
> It is a Debian 3.1 system, running on a Centrino Notebook. 
> 
> I tried to disable PCI Hotplugging, but it gives me the same result. Disabling 
> ADEOS Support gives me back my working System. 
> And there is also something confusing the kernel build system, since patching 
> it always recompiles every single file, making debugging not much fun :(
> 
> Are there any suggestions on tracking this down?
> 
> 
> Have a nice Weekend,
> Stephan
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

