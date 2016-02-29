Date: Mon, 29 Feb 2016 21:29:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160229202909.GB26312@hermes.click-hack.org>
References: <56d4a8eb4617e0.42984600@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d4a8eb4617e0.42984600@wp.pl>
Subject: Re: [Xenomai] RTnet -- receive broadcast frame at the local machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Feb 29, 2016 at 09:24:11PM +0100, Mariusz Janiak wrote:
> Dear Xenomai users,
> 
> Since RTnet has been integrated with Xenomai I address this question to you. The question is, how to receive a broadcast frame at the local machine without using the localhost? The issue is following, we have two process with separate rtsockets at the single machine (of course we have different machines in the network but this is not a case). One process send a broadcast UDP frame to the specified UDP port -- we have one rteth device on the machine. The second process listen on that port 
> (receivefrom) and does not receive the broadcast frame sent by first process. I have found the following thread on the RTnet mailing list 
> 
> https://sourceforge.net/p/rtnet/mailman/message/6787561/
> 
> Could you please point me the place which should be hacked to duplicate outgoing packets if there are multiple
> matching routes?

I ma not sure I understand what you are looking for, but to receive
on a host the frames sent by that host, you need to enable and load
the loopback module. When you do that, no hack should be needed.

-- 
					    Gilles.
https://click-hack.org

