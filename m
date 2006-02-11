Message-ID: <43EE3380.7000905@domain.hid>
Date: Sat, 11 Feb 2006 19:57:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Errors compiling fpu.o (xenomai trunk)
	if	CONFIG_PPC601_SYNC_FIX=y
References: <200602082033.52077.niklaus.giger@domain.hid>
In-Reply-To: <200602082033.52077.niklaus.giger@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

Niklaus Giger wrote:
> Hi,
> 
> I got the following errors when my .config contained
> a CONFIG_PPC601_SYNC_FIX=y
>   AS      arch/ppc/xenomai/fpu.o
> /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xenomai/fpu.S: Assembler 
> messages:
> /mnt/data.ng/hcu/kernel/ppc/linux-2.6.14/arch/ppc/xenomai/fpu.S:54: Error: 
> Unrecognized opcode: `begin_ftr_section'
> <..>
> 
> After unsetting CONFIG_PPC601_SYNC_FIX, the compilation proceeded without any 
> problem.
>

Fixed, thanks.

> Best regards
> 


-- 

Philippe.

