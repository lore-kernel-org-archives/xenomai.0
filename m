From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4c583de0.5396cc0a.3011.ffffd8a9@domain.hid>
References: <4c583de0.5396cc0a.3011.ffffd8a9@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Aug 2010 18:26:42 +0200
Message-ID: <1280852802.6700.107.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Some questions about Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Kremenak <m.kremenak@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-08-03 at 18:03 +0200, Martin Kremenak wrote:
> Hi, 
> 
>  
> 
> I want to realize control system based on real time Linux. So I decide
> me for Xenomai. 
> 
> After some research I found a Code Generator for Xenomai from
> Evidence: http://www.evidence.eu.com/content/view/175/216 which I can
> generate Code from Scilab/Scicos for Xenoami.
> 
> I read the readme-file from Evidence and the recommended Xenomai
> 2.4.3.
> 
>  
> 
> So I tried to install Xenomai 2.4.3 with Kernel
> 2.6.24/2.6.24.2/2.6.24.1 on my System. 
> 
> I tried this quick build guide:
> http://www.xenomai.org/index.php/Xenomai_quick_build_quide
> 
> On the point where I compile the Kernel I got following error:
> 
> debXenomai:/usr/src/linux-2.6.24.2# make 
> scripts/kconfig/conf -s arch/x86/Kconfig 
>    CHK     include/linux/version.h 
>    CHK     include/linux/utsrelease.h 
>    CALL    scripts/checksyscalls.sh 
>    CHK     include/linux/compile.h 
>    AS      arch/x86/kernel/entry_32.o 
>  arch/x86/kernel/entry_32.S: Assembler messages: 
>  arch/x86/kernel/entry_32.S:270: Error: invalid character '_' in mnemonic 
>  arch/x86/kernel/entry_32.S:321: Error: invalid character '_' in mnemonic 
>  arch/x86/kernel/entry_32.S:351: Error: invalid character '_' in mnemonic 
>  arch/x86/kernel/entry_32.S:521: Error: invalid character '_' in mnemonic 
>  arch/x86/kernel/entry_32.S:536: Error: invalid character '_' in mnemonic 
>  make[1]: *** [arch/x86/kernel/entry_32.o] Fehler 1 
>  make: *** [arch/x86/kernel] Fehler 2 
> 
> Have anybody the same problem or a solution to fix the problem?

This is an old cranky Adeos/I-pipe patch with a silly glitch in it,
disabling CONFIG_PARAVIRT should help. Normally, you should be able to
pick the latest 2.4.x official release (2.4.10) instead of 2.4.3. All
releases within a major series are guaranteed to be API and ABI backward
compatible.

In any case, unless the code generator itself has (weird) kernel
dependencies, you don't need to stick with 2.6.24 for Xenomai 2.4.x to
work, you may upgrade up to 2.6.30.8 with Xenomai 2.4.10.

> 
>  
> 
> Maybe anyone have experience with the Code Generator from Evidence and
> newer versions from Xenomai? It is possible to use a newer version?
> 

I did not know this generator existed, so ...

> The Evidence wiki and forum is down. Maybe the project is adjusted, so
> I can not ask some people from Evidence. 
> 
>  
> 
> I also searched for Kernel-Configs for an x86 Intel-System (CoreDuo2),
> please post your experience. 
> 
>  
> 
> Another open point is the graphical interface. I search for something
> like xrtailab or  something else. 
> 
>  
> 
> Regards,
> 
>  
> 
> Martin K.
> 
>  
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



