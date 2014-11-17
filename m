Date: Mon, 17 Nov 2014 08:09:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141117070936.GN4656@sisyphus.hd.free.fr>
References: <9540924A-C2CD-4465-AA62-CD3E0DC6938D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9540924A-C2CD-4465-AA62-CD3E0DC6938D@gmail.com>
Subject: Re: [Xenomai] Remote debug question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Sun, Nov 16, 2014 at 04:16:51PM -0600, Mathew Benson wrote:
> First, I'm sorry if this has been asked and answered here before.
> I found a link to a page to search the archives but the link was
> broken.  So, I'm not sure how to search the archives without
> downloading them all.

In google, add site:xenomai.org at the end of the search, that is
what google custom search did.

> 
> I'm running xenomai 3 on a Beaglebone Black and my host is Mint
> 17. All the samples checkout. I can build and run my own code
> using xenomai extensions, but remote debugging seems to be
> erratic. First, I see two threads immediately at startup though I
> don't have symbols for the second read. I didn't create this
> thread, so I'm not sure why its there or where it came from.

This is xenomai logging thread. It allows printf in xenomai
applications to avoid switching to secondary mode.

> 
> Second, the debugger (dbgserver) seems to lose itself. I'll step
> through code and it will suddenly and at random locations just not
> break on the next line. Debugger says threads are still alive, but
> when I pause execution (though I shouldn't have to since I
> stepped) it appears all the threads are terminated.
> 
> Lastly, when I run without the debugger I get different behavior.

I am not sure what you mean by that, but yes, using gdb causes
threads to:
- be interrupted
- and switch to secondary mode to handle interactions with the
debugger.

So, your application should be prepared for some services to return
EINTR or -1 with errno set to EINTR, depending on which part of
Xenomai POSIX API you are using. For services that are not
automatically restarted upon signals that is.

> I never had a problem before I converted to xenomai, so I'm not
> sure if its a xenomai or dbg problem.
> 
> Basically, are there known problems with dbg and dbgserver? Is
> there something xenomai specific that I should put in my gdbinit?

There should not be. There is one big catch with gdb/gdbserver
though: the versions of the cross-gdb on host and gdbserver on the
target should correspond exactly, otherwise the two may not talk the
same protocol, and you end up with weird behaviours like what you
are describing.

Could you provide us with a simple self-contained test case, and a
description of the way to reproduce the problem?

Regards.

-- 
					    Gilles.

