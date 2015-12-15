Date: Tue, 15 Dec 2015 18:09:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151215170918.GA5162@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716140@mb2010-1.intra.tut.fi>
 <20151215135934.GA30622@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A716185@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A716185@mb2010-1.intra.tut.fi>
Subject: Re: [Xenomai] Switching to secondary mode despite of use of mmap
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Dec 15, 2015 at 04:03:58PM +0000, Umair Ali wrote:
> Thanks Gilles for the reply.
> 
> >  The slackspot trace you show only contains calls to timerfd_create
> and socket. Yes, timerfd_create and socket cause a switch to
> secondary mode.
> 
> The slackspot output file shows that socket and timerfd_create is
> called again and again. But i have used these two once and then in
> the "while loop" timer is read and packet is send.

>From the look of the trace, the calls to timerfd_create and socket
belong to different processes. So, I would say that the multiple
instances correspond to multiple instances of your program. Have you
not launched the program multiple times?

If that is the case, and you only get in fact two modes switches due
to timerfd_create() and socket(), are you sure you still have a
problem? Are you sure your problem is not simply the jitter?

> Does it mean
> that timerfd_create and socket is calling every time once the one
> loop finish and start other loop until while loop condition is
> satisfied.

I am sorry, I do not really understand this question, but I believe
the above explanation should be sufficient.

> Is there any way i can avoid the transition to
> secondary mode without using timerfd_create and socket.

There should be no problem using timerfd_create and socket. 

> Can i use
> cobalt kernel timers service direclty in user space. Please guide
> me thanks.

No, kernel space timers are used in kernel space, that is why they
are called "kernel-space timers". But a timerfd is a user-space
interface to a kernel-space timer. I believe I already gave you link
on how to use kernel-space timers if you wish to do so.

-- 
					    Gilles.
https://click-hack.org

