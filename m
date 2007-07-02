From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4689092B.6020903@domain.hid>
References: <4688E0BD.40709@domain.hid>
	<1183377266.19565.14.camel@domain.hid>  <4689092B.6020903@domain.hid>
Content-Type: text/plain
Date: Mon, 02 Jul 2007 16:48:07 +0200
Message-Id: <1183387687.19565.56.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Switch to secondary mode
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
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

On Mon, 2007-07-02 at 16:18 +0200, Johan Borkhuis wrote:
> Philippe,
> 
> Philippe Gerum wrote:
> > Late binding to functions performed on behalf of the dynamic loader
> > against shared libraries shall need the kernel during symbol resolution
> > (internal syscalls) or execution (e.g. demand loading, COW), hence the
> > switch. Unfortunately, the I-pipe patch for PPC does not support
> > disabling all on-demand memory mappings for selected Linux tasks (only
> > the x86 and ARM patches support this feature so far).
> >   
> 
> Thank you for you answer.
> 
> Just for me to make sure I understand this correctly:
> We are not using shared libraries for our application, our applications 
> are linked against .a files, which are included in the final application

In such a case, you have likely hit an illustration of the latter issue
which the I-pipe/ppc implementation still suffers from: some page table
entries are missed during real-time operations. As a consequence of
this, the nucleus catches page faults on behalf of RT threads in primary
mode, then switches these threads back to secondary in order to process
the faults, and eventually wire the missing PTEs in. This is something
calling mlockall() does not prevent the application from (like COW).

The shared lib problem would be another issue, even if it relates to the
same general topic (i.e. lazy/on-demand mapping of memory resources the
kernel performs).

>  
> (all symbols are resolved and available in the executable, so I expected 
> that all symbols would have been resolved. This does apply to that as 
> well to this type of applications?

> (I tried linking using -static,  but that does still give the s
> ame problem.)
> 

That is expected. If you switch the nucleus debug option on, you should
see Xenomai whining about secondary mode switches from code locations in
kernel space. This would confirm the fact that you have been hitting
this problem.

> How can I avoid this problem?

There is not much to be done except improving the I-pipe/ppc support so
that it provides a way to pin down any PTE an application might refer
to. There might be other related issues beyond this one though.
Fortunately, mode transitions for dealing for such faults normally don't
lead to bad latencies on this arch. Do you confirm that, or are you
unlucky regarding this?

>  Is there a way to make sure all symbols 
> are available in memory, or is there a way to instruct the 
> compiler/linker/loader to perform the symbol-resolving during 
> compile-time or on load?
> One thing I am thinking of (but this may be completely wrong) is to have 
> a Init function in all modules that are part of the library. When a 
> library module is used, this Init function needs to be called before 
> switching to RT-mode, so the symbols are made available to the 
> application. Would this work (and solve the problem), or would this 
> create a lot of other problems?
> 

The answer is not at user-space level, unfortunately.

> Where can I find some more information on this issue?
> 
> Kind regards,
>     Johan Borkhuis
-- 
Philippe.



