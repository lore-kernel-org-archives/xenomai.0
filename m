MIME-Version: 1.0
Date: Fri, 27 Feb 2015 23:17:34 -0600
Message-ID: <CA+C+_XSjnuBf84XeKz-sS7uqTfe8oqxR1pY8=Tq4nrdhthK4Mw@mail.gmail.com>
From: Mathew Benson <mathew.benson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rt_task_create hangs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

When I run my code without a debugger, everything seems to work fine.  When
I run my code with a debugger and no breakpoints, it works fine.  I can
interrupt a thread and everything looks good.  However, I have problems
with breakpoints.  When I step over, into, or continue from rt_task_create,
my code seems to hang and the debugger stops working.  I'm using the same
gdb and gdbserver version.

I found it doesn't really matter too much where I put the breakpoints.  It
looks like any xenomai call after I've hit at least one breakpoint, results
in locking up.
