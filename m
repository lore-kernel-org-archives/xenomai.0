Message-ID: <43FDD2E7.9080705@domain.hid>
Date: Thu, 23 Feb 2006 16:21:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai patch packaging concerns
References: <200602231224.38519.rlenglet@domain.hid>
In-Reply-To: <200602231224.38519.rlenglet@domain.hid>
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
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:
> Hi,
> 
> 
> I understand that the prepare-kernel.sh script is a kind of 
> "smart patch" program. It is very nice, but for packaging for 
> Debian we need a real diff file. So I am currently modifying 
> prepare-kernel.sh to be even smarter, so that it can optionally 
> generate a diff file instead of actually modifying the Linux 
> tree. This is done efficiently in terms of disk space, i.e. it 	
> does not duplicate the Linux tree to generate the diff file.
> I will send a patch for prepare-kernel.sh once I have finished.
> 
> 
> However, I have a problem: some files are copied (linked) several 
> times into the Linux tree. As a consequence, in a generated diff 
> file those files would be duplicated. And I believe that such a 
> duplication is unecessary.
> 
> Here are the sets of links that are currently made by 
> prepare-kernel.sh (on every line: Linux tree -> Xeno tree):
> 
> 1- arch/<arch>/xenomai/* -> ksrc/arch/<arch>/*
> 2- kernel/xenomai/* -> ksrc/*
> 3- kernel/xenomai/arch/* -> ksrc/arch/<arch>/*
> 4- kernel/xenomai/drivers/*... -> ksrc/drivers/*...
> 5- kernel/xenomai/nucleus/*... -> ksrc/nucleus/*...
> 6- kernel/xenomai/skins/*... -> ksrc/skins/*...
> 7- drivers/xenomai/*... -> ksrc/drivers/*...
> 8- include/asm-<arch>/xenomai/* -> include/asm-<arch>/*
> 9- include/asm-generic/xenomai/* -> include/asm-generic/*
> 10- include/xenomai/* -> include/*
> 11- include/xenomai/asm-<arch>/* -> include/asm-<arch>/*
> 12- include/xenomai/asm-generic/* -> include/asm-generic/*
> ...
> 
> 1- and 3- are redundant: I guess that 3- is not required?
> 4- and 7- are redundant: I guess that 4- is not required?
> 8- and 11- are redundant: I guess that 11- is not required?
> 9- and 12- are redundant: I guess that 12- is not required?
> I everybody agrees, I will modify prepare-kernel.sh to not 
> generate the 3-, 4-, 11- and 12- sets of links.
> 
> Note that removing the 3- and 4- sets of links would also require 
> to modify the ksrc/Makefile file, so that the line:
> obj-$(CONFIG_XENOMAI) += arch/ nucleus/ skins/
> becomes:
> obj-$(CONFIG_XENOMAI) += nucleus/ skins/
> and the following line should be suppressed:
> subdir-$(CONFIG_XENOMAI) += arch
> Is that OK?
> 

Entering arch/ from the kernel section is needed to compile the generic HAL part; 
this is why 3- is currently needed. How would this fit into your new layout?
Filtering out the rest looks ok though.

> It would even be better and easier to modify the Xenomai source 
> tree to match better the Linux tree:
> ksrc/
>     L arch
>     L drivers
>     L kernel
>         L nucleus
>         L skins
>

We could do that for later versions, but the generic HAL issue needs to be 
addressed first.

> And I also will make prepare-kernel.sh not link (or generate 
> diff) for the asm-<arch> and arch/<arch>/ directories for 
> architectures that are different from the built architecture.
> 


-- 

Philippe.

