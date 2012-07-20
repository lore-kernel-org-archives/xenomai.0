Message-ID: <5009A598.3090706@xenomai.org>
Date: Fri, 20 Jul 2012 20:38:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C1A3774592D24248BC23BD4FA9550B9AB1811C@VYTRONUS-SBS.vytronus.local>
	<50099556.50807@xenomai.org>
	<C1A3774592D24248BC23BD4FA9550B9AB181FA@VYTRONUS-SBS.vytronus.local>
In-Reply-To: <C1A3774592D24248BC23BD4FA9550B9AB181FA@VYTRONUS-SBS.vytronus.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Intel MKL library fault when running as a xenomai
	task.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Bruce Director <bruce@vytronus.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/20/2012 08:31 PM, Bruce Director wrote:
> Sorry,  I don't have the code.   Intel doesn't supply source code for
> this library.  The reason I know the segmentation  fault occurs in
> get_N_cores is that the debugger gives me a stack trace.  If you
> could tell me which CPU parameters xenomai does change, I could pass
> that info to Intel and see what they say.

Xenomai does not change anything, not that I know of. But there are a
lot of possible issues.

First issue to check is to see if the segmentation fault is due to a
stack overflow. In which case the stack of the thread calling that
function is too small for that function, simply increase the thread
stack size. You can also check the disassembly of the faulting function
to see how much room it allocates on stack.

Another reason for stack overflow could be linking with the libc in its
static version (libc.a), using xenomai posix skin, and not linking with
the wrap-link.sh script.

Please no top-posting.

-- 
                                                                Gilles.

