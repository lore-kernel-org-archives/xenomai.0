Message-ID: <455E025B.7060708@domain.hid>
Date: Fri, 17 Nov 2006 19:41:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] VM killer
References: <DD39B5C3F4963040ADC9768BE7E430CB015D4828@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB015D4828@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
>  
> Any hints ?

There is no way the system can run properly if there is not enough RAM.
Add some RAM to your board, or decrease the memory used by applications.

-- 
                                                 Gilles Chanteperdrix

