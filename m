MIME-Version: 1.0
In-Reply-To: <9540924A-C2CD-4465-AA62-CD3E0DC6938D@gmail.com>
References: <9540924A-C2CD-4465-AA62-CD3E0DC6938D@gmail.com>
Date: Sun, 16 Nov 2014 18:22:22 -0600
Message-ID: <CA+C+_XQBJ21AuO-rzeia9tPvtkZV1CWcieJV43Tmr8pJnEaa4Q@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Remote debug question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

GDB:  GNU gdb (Ubuntu 7.7.1-0ubuntu5~14.04.2) 7.7.1
Target xeno-config:
xeno-config --verbose
        --version="2.6.3"
        --cc="gcc"
        --arch="arm"
        --prefix="/usr/xenomai"
        --xeno-cflags="-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__"
        --xeno-ldflags="-L/usr/xenomai/lib -lxenomai -lpthread -lrt "
        --posix-cflags=""
        --posix-ldflags="-Wl,@/usr/xenomai/lib/posix.wrappers
-L/usr/xenomai/lib -lpthread_rt -lxenomai -lpthread -lrt "
        --library-dir="/usr/xenomai/lib"

Target kernel:  Linux beaglebone 3.8.13xenomai-bone53 #2 Mon May 19
14:43:41 UTC 2014 armv7l GNU/Linux



On Sun, Nov 16, 2014 at 4:16 PM, Mathew Benson <mathew.benson@gmail.com>
wrote:

> First, I'm sorry if this has been asked and answered here before.  I found
> a link to a page to search the archives but the link was broken.  So, I'm
> not sure how to search the archives without downloading them all.
>
> I'm running xenomai 3 on a Beaglebone Black and my host is Mint 17.  All
> the samples checkout.  I can build and run my own code using xenomai
> extensions, but remote debugging seems to be erratic.  First, I see two
> threads immediately at startup though I don't have symbols for the second
> read.  I didn't create this thread, so I'm not sure why its there or where
> it came from.
>
> Second, the debugger (dbgserver) seems to lose itself.  I'll step through
> code and it will suddenly and at random locations just not break on the
> next line.  Debugger says threads are still alive, but when I pause
> execution (though I shouldn't have to since I stepped) it appears all the
> threads are terminated.
>
> Lastly, when I run without the debugger I get different behavior.  I never
> had a problem before I converted to xenomai, so I'm not sure if its a
> xenomai or dbg problem.
>
> Basically, are there known problems with dbg and dbgserver?  Is there
> something xenomai specific that I should put in my gdbinit?
>
> Sent from my Packard Bell 386
