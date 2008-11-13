Message-ID: <491C5B24.60202@domain.hid>
Date: Thu, 13 Nov 2008 17:51:48 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <223a70540811122148o73ae3d2ex1689b5d03f77f825@domain.hid>
In-Reply-To: <223a70540811122148o73ae3d2ex1689b5d03f77f825@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem compiling patched kernel: multiple
	definitions of mcount
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: James Doebbler <jamesdoebbler@domain.hid>
Cc: xenomai@xenomai.org

James Doebbler wrote:
> Hello,
>  I am trying to patch and install a kernel using Xenomai (on Ubuntu
> 8.10).  I am using a vanilla linux-2.6.27 kernel and the latest
> xenomai version (2.4.6.1).  I had some earlier problems that I
> resolved by using the latest adeos patch (now I see that has been
> fixed in 2.4.6.1), but I've been running into another problem.  I get
> an error when compiling due to multiple definitions of mcount in the
> entry_32.S and mcount_32.S files.  I looked at the code and decided
> that disabling function tracing (CONFIG_FTRACE) in the kernel config
> would eliminate the kernel function tracing and the ipipe function
> tracing from stepping on each others' toes.  The kernel seems to be
> compiling okay now (still in progress).  I just wanted to ask if this
> is a bug or expected, and if the action I took was appropriate.  Do I
> lose anything by disabling kernel function tracing?

OK, that experience confirms my first glance on the latest patch /wrt
FTRACE integration: unfinished. The solution will be using the FTRACE
mcount functions for the ipipe tracer - should be feasible, except for
dynamic FRTRACE, ie. the thing that killed puppies and e1000 NICs. :)

Hope I'll find some time to look into this, but I can't promise when.
For now, if you want FTRACE (probably not, when you don't know it yet),
disable CONFIG_IPIPE_TRACE.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

