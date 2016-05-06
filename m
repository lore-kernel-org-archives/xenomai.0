Date: Fri, 6 May 2016 18:03:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160506160336.GG13285@hermes.click-hack.org>
References: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
 <20160504210030.GK1761@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A733219@mb2010-3.intra.tut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A733219@mb2010-3.intra.tut.fi>
Subject: Re: [Xenomai] mmap a file in rtdm moudle without switching the mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, May 06, 2016 at 03:04:03PM +0000, Umair Ali wrote:
> Hello gilles,
> 
> Thanks for the patience and the reply. I am sorry for asking such
> questions. I am newbie so need some guidance. I have searched for
> linux device drivers on the internet and I found the book
> (https://lwn.net/Kernel/LDD3/) . Can you recommend me which
> chapter will be very helpful for me.

All of it. It is not that big, and it contains valuable information
on about every topic important when developing a driver. The details
of the APIs have changed over time, so they will no longer match
what you will find, but you are going to use the RTDM API which is
also a little bit different anyway, but the principles remain
relevant, and getting familiar with them is mandatory if you want to
be able to do better than cutting and pasting from stack overflow or
mailing list posts.

-- 
					    Gilles.
https://click-hack.org

