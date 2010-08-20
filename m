From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <181804936ABC2349BE503168465576460FB0A22E@exchserver.basler.com>
References: <181804936ABC2349BE503168465576460F9E6D9C@exchserver.basler.com>
	<181804936ABC2349BE503168465576460F9E6DA5@domain.hid>
	<4C66939A.1060509@domain.hid> <4C6697F8.1090409@domain.hid>
	<181804936ABC2349BE503168465576460FA508FF@exchserver.basler.com>
	<181804936ABC2349BE503168465576460FAB4A0C@exchserver.basler.com>
	<1282197537.1730.411.camel@domain.hid>
	<181804936ABC2349BE503168465576460FB0A22E@exchserver.basler.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Aug 2010 10:09:48 +0200
Message-ID: <1282291788.1730.535.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Page fault in real time task causes lockup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2010-08-19 at 12:05 -0500, Steve Deiters wrote:
> > Make sure to have CONFIG_IPIPE_TRACE_VMALLOC enabled. You may 
> > also want to check whether disabling CONFIG_IPIPE_TRACE_IRQSOFF helps.
> > 
> > --
> > Philippe.
> > 
> > 
> 
> I got the tracer working.  It was crashing when using insmod to insert a
> module.  I recompiled the module and it stopped crashing.  Should I have
> to recompile the kernel modules after I enable the tracing?

No, not if you don't care about tracing the module itself. 

-- 
Philippe.



