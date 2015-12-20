Date: Sun, 20 Dec 2015 16:03:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151220150333.GA25662@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Possible sync problem with timerfd and application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: Xenomai list =?utf-8?B?4oCOW3hlbm9tYWlAeGVub21haS5vcmdd4oCO?= <xenomai@xenomai.org>

On Thu, Dec 17, 2015 at 02:07:20PM +0000, Umair Ali wrote:
> Hello there,
> 
> I am using the timerfd to produce the required sleep function for
> sending the raw ethernet packets using rtnet driver periodically.
> I read the file using the mmap() function and
> mlockall(MCL_CURRENT|MCL_FUTURE). My code is attached with this
> email. Gilles have already explained me with the jitter problem
> with timerfd but it is acceptable so far with me. Now the problem
> is that the code runs ok for more or less 30 secs. For this period
> of running of code the jitter is acceptable. But after some time
> the jitter increases very much and causes problem. I thought that
> this may be because the timerfd has lost the synchronization with
> application.

The "read" call on a timerfd reads the number of timer ticks since
the last read, so you can know whether an overrun occurred by
checking the variable named "exp" in your program.

> Or timerfd is not working fine. I tried to use the
> poll() and epoll() also but the problem persist. Can you guide me

poll() is not a wrapped call, so causes a switch to secondary mode.
Did not you see that with slackspot? Xenomai only wraps the "select"
call.

Also note that by using the AF_INET family, you are no longer
sending raw packets but UDP packets.

And finally I do not know what your ugly memcpy with hardcoded
lengths do exactly, but the check (j < size) looks insufficient, 
as the memcpys are accessing data beyond j. If you receive a signal doing
this, this would certainly cause a switch to secondary mode.


-- 
					    Gilles.
https://click-hack.org

