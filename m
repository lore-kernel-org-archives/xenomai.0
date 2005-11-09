Message-ID: <4371D12E.1000706@domain.hid>
Date: Wed, 09 Nov 2005 11:36:30 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Module loading problems
References: <009101c5e516$02bd2a80$1000000a@domain.hid>
In-Reply-To: <009101c5e516$02bd2a80$1000000a@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
To: "Hans-J. Ude" <ude@domain.hid>
Cc: Xenomai-help@domain.hid

Hans-J. Ude wrote:
> I've installed Xenomai 2.0.1 but can't load a module stack for the vxWorks
> skin. Kernel is 2.6.13 with the included ipipe patch and I'm getting the
> following results.
> 
> # insmod xeno_hal.ko
> # insmod xeno_nucleus.ko
> # insmod xeno_vxworks.ko
> # insmod xeno_uvm.ko
> insmod: error inserting 'xeno_uvm.ko': -1 Function not implemented
> 
> # insmod xeno_hal.ko
> # insmod xeno_nucleus.ko
> # insmod xeno_uvm.ko
> # insmod xeno_vxworks.ko
> insmod: error inserting 'xeno_vxworks.ko': -1 Device or resource busy
> 

Vxworks and UVM modules are mutually exclusive. The VxWorks emulation in 
user-space on top of the UVM does not need the former, and even conflicts with 
it when attempting to set up the real-time timer. IOW, just push xeno_hal.ko, 
xeno_nucleus.ko and xeno_uvm.ko.

> I've put some printk's into the nucleus modules and found that in the first
> case there are two pointers which are compared when a subsequent modules is
> loaded. Those pointers are expected to be equal but are unequal and the
> module is rejected. Can someone tell what I can do here? Maybe there is
> something wrong with the modules, with the distro (Suse 9.3) or maybe I'm
> doing something wrong. I think i'm gonna try the original gnu modutils next
> and get rid of that Suse stuff.
> 
> regards,
> Hans
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

