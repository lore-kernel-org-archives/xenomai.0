Subject: Re: [Xenomai-help] VM killer
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D4828@domain.hid>
References: <DD39B5C3F4963040ADC9768BE7E430CB015D4828@domain.hid>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 19:52:23 +0100
Message-Id: <1163789543.4980.62.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-11-17 at 18:15 +0000, Daniel Schnell wrote:
> Hi,
>  
> I know this is somewhat not related to Xenomai. But as I encountered
> this while actually testing the memory allocation with Xenomai, maybe
> there is some common sense here, as there are many people having to do
> with embedded systems, where something like that matters.
>  
> Everytime the system comes to its limits and some process uses up all
> the memory the vm systems kills (more or less randomly) one or more
> processes. Even system processes. I would really like to get rid of
> this behaviour, but having disabled CONFIG_OOM_KILLER inside the linux
> kernel doesn't help.

What does the following say on your board?
cat /proc/sys/vm/overcommit_memory

>  
> I use ELDK4.0 with 2.4.25 Denx Kernel.
>  
> Any hints ?
>  
>  
> Best regards,
>  
> Daniel.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



