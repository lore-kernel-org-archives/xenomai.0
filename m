Message-ID: <43F2521E.7040200@domain.hid>
Date: Tue, 14 Feb 2006 22:56:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Handling PCI MSI interrupts
References: <fd6a47a90602140744lc1d4365q@domain.hid>	
	<43F21867.8070002@domain.hid>	
	<fd6a47a90602141007g7830d31fu@domain.hid>	
	<43F21ED7.3030501@domain.hid> <43F220D7.6040705@domain.hid>	
	<fd6a47a90602141052u1e136db8y@domain.hid>	
	<fd6a47a90602141133v6aeae6e1n@domain.hid>
	<fd6a47a90602141341j21ce1b77l@domain.hid>
In-Reply-To: <fd6a47a90602141341j21ce1b77l@domain.hid>
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
> I've got some bad news.
> 
> I've rewritten (parts of) my driver to operate in native Linux (i.e. no 
> RTDM, no Xenomai). When I run this in a Xenomai-augmented kernel (with 
> Adeos, evidently), the machine hangs. However, when the same code is run 
> in the same but unmodified kernel, the code works as expected. Therefore 
> it seems that Adeos is to blame here.

Yes, as usual with MSI support, unfortunately.

> 
> Now, I could try to write a small driver program illustrating the 
> problem. Of course, it is impossible for you to test on my board. Maybe 
> we could agree on an MSI capable piece of hardware, that I could write 
> the code for ?
>

The problem is that I need to put my hands on a new set of MSI capable hw first 
and divert it for debugging Adeos. The box I've used to fix the first round of MSI 
issues a few months ago does not exhibit such issues anymore, so I can't reproduce 
the problem here yet. The only good news for now, is that I won't give up on 
fixing all of the MSI issues in Adeos.

> The reason I would very much like to test this setup is that I look upon 
> MSI as a very viable alternative to these ever-damned interrupt sharing 
> mechanisms. It is becoming more and more difficult to find computers 
> that allow you to reserve (a few) IRQ-lines these days (especially 
> notebooks and OEM desktops). Additionally, MSI is capable of bypassing 
> the IO-APIC entirely (although the Linux kernel needs that APIC support 
> to enable MSI - I've still got to find out why that is).
> 
> Jeroen.


-- 

Philippe.

