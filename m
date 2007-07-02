Message-ID: <4689092B.6020903@domain.hid>
Date: Mon, 02 Jul 2007 16:18:19 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
References: <4688E0BD.40709@domain.hid> <1183377266.19565.14.camel@domain.hid>
In-Reply-To: <1183377266.19565.14.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Switch to secondary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid

Philippe,

Philippe Gerum wrote:
> Late binding to functions performed on behalf of the dynamic loader
> against shared libraries shall need the kernel during symbol resolution
> (internal syscalls) or execution (e.g. demand loading, COW), hence the
> switch. Unfortunately, the I-pipe patch for PPC does not support
> disabling all on-demand memory mappings for selected Linux tasks (only
> the x86 and ARM patches support this feature so far).
>   

Thank you for you answer.

Just for me to make sure I understand this correctly:
We are not using shared libraries for our application, our applications 
are linked against .a files, which are included in the final application 
(all symbols are resolved and available in the executable, so I expected 
that all symbols would have been resolved. This does apply to that as 
well to this type of applications?
(I tried linking using -static,  but that does still give the same problem.)

How can I avoid this problem? Is there a way to make sure all symbols 
are available in memory, or is there a way to instruct the 
compiler/linker/loader to perform the symbol-resolving during 
compile-time or on load?
One thing I am thinking of (but this may be completely wrong) is to have 
a Init function in all modules that are part of the library. When a 
library module is used, this Init function needs to be called before 
switching to RT-mode, so the symbols are made available to the 
application. Would this work (and solve the problem), or would this 
create a lot of other problems?

Where can I find some more information on this issue?

Kind regards,
    Johan Borkhuis

