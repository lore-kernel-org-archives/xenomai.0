Date: Mon, 21 Dec 2015 21:07:53 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20151221200753.GA29679@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A716241@mb2010-1.intra.tut.fi>
 <20151220150333.GA25662@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A7163B0@mb2010-1.intra.tut.fi>
 <20151221124007.GA20764@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A7163DD@mb2010-1.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A7163DD@mb2010-1.intra.tut.fi>
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

On Mon, Dec 21, 2015 at 02:29:07PM +0000, Umair Ali wrote:
> I am very sorry for disturbing you for many basic and stupid questions. Actually i am new to linux and xenomai therefore i really appreciate you patience. Please forgive me.
> 
> >The problem is not the type of j. The problem is that if you test
> >j < size
> >
> >and then use j + something
> >
> >j + something may well be above size.
> 
> I have printed the value of j in every turn of the while loop. I
> have found that the j has a value always less than size. the
> maximum size is 602198442 and the last value of j is 602198334.
> Therefore i dont think the value of j is higher or above the size
> at any time.

The problem is that your code does not dereference j, but j plus
some offset. So I can see that j < size is always true, thanks to
the while loop. What I tell you is that this does not guarantee that
j + offset is less than size. This is an obvious, trivial flaw,
really.

> 
> >As far as I know, there is no problem with sending UDP packets over
> >RTnet, actually, I verified the round trip time of two machines
> >running RTnet over several hours, and it did not have any issue.
> >Neither has the timerfd system, as tested by the latency test.
> 
> >I was just trying to signal you that you came on that list asking
> >for a way of sending raw packets, I replied you with an example
> >program doing exactly that, but now you have rewritten a program
> >using UDP packets (keeping some parts of the program I sent you
> >which are now useless, namely retrieving the MAC address of the
> >network card). You are not sending raw packets.
> 
> Its true that i have just modified same code, as you send me for
> raw ethernet packets, for UDP packets. i have a UDP server running
> in embedded hardware named dSPACE. When i run the code i can see
> the UDP traffic and the server (in dSPACE) is able to receive the
> packets also.

I do not care why you send UDP packets. The point is I wanted to be
sure that you understood that you were no longer sending raw
packets.

> Therefore i was sure that it is also the way to send
> UDP packets. Do you think this can still be the problem. I have
> gone through the link (https://xenomai.org/rtnet-programming/).
> This is for xenomai 2 but not for xenomai 3. Is there any similar
> link for programming Rtnet with xenomai 3.
> 
> I am very confused what can be problem. Do you have idea how to
> trace back the problem.
> 
> I think i should now work in the kernel space and take the advice
> of the kernel timers. Please guide me to use the RTnet module in
> kernel space app.

To be frank, I do not understand what your problem is. You tell us
that you have timing problems, but at the same time the timerfd does
not return you any overruns. How do you know you have timing
problems them? Is the receiving computer running RTnet? Because if
it is not running RTnet, you have no way of knowing if the problem
is not on the receiving side.

Also, it would be nice if you could avoid top-posting, as is
traditional on mailing lists.

-- 
					    Gilles.
https://click-hack.org

