Date: Wed, 1 Jul 2015 19:54:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150701175446.GL13256@hermes.click-hack.org>
References: <CA+K1mPFgcxF5UAkMNXzit34sPHNWc+uzPTT45bngA6dd0wAyTw@mail.gmail.com>
 <20150630001953.GA2038@hermes.click-hack.org>
 <CA+K1mPG9OKH9FReQoC8jLRAipJ3F=vSdRMmtrxFaZEJjyfHArg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+K1mPG9OKH9FReQoC8jLRAipJ3F=vSdRMmtrxFaZEJjyfHArg@mail.gmail.com>
Subject: Re: [Xenomai] Unable to Read from Pipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Jul 01, 2015 at 10:44:53AM -0700, C Smith wrote:
> I tried xenomai stable 2.6.4 on a 3.14.17 kernel today. I get the same
> result,

What about the other tests? Xenomai testing? and XDDP sockets?

> the rt task pipe read results in errno 11 -EWOULDBLOCK.  Here is a clue:
> a blocking read in the periodic task works OK and reads the bytes from the
> pipe - but I can't allow my periodic thread to block.
> 
> The nonblocking pipe API should work in xenomai 2.6.4, right? Perhaps there
> is something I'm doing wrong in my code or my compile?
> I have attached my test code for you to look at, in case I am doing
> something wrong.

There is no doubt that it should be working. But maybe it does not,
and understanding why would be a waste of time if it has been fixed
in Xenomai testing.

Please stay on the lit.
-- 
					    Gilles.
https://click-hack.org

