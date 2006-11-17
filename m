Message-ID: <455E16DD.4090804@domain.hid>
Date: Fri, 17 Nov 2006 21:09:01 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] VM killer
References: <DD39B5C3F4963040ADC9768BE7E430CB015D4828@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D4828@domain.hid>
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

Daniel Schnell wrote:
> Hi,
>  
> I know this is somewhat not related to Xenomai. But as I encountered 
> this while actually testing the memory allocation with Xenomai, maybe 
> there is some common sense here, as there are many people having to do 
> with embedded systems, where something like that matters.
>  
> Everytime the system comes to its limits and some process uses up all 
> the memory the vm systems kills (more or less randomly) one or more 
> processes. Even system processes. I would really like to get rid of this 
> behaviour, but having disabled CONFIG_OOM_KILLER inside the linux kernel 
> doesn't help.
>  
> I use ELDK4.0 with 2.4.25 Denx Kernel.

For 2.4 kernels you should use ELDK 3.1.1. Wolfgang, can you confirm that?

Wolfgang.


