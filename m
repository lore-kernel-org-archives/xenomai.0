From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20091102095437.GA19825@domain.hid>
References: <4AE333E9.5040802@domain.hid> <1256422425.2862.538.camel@domain.hid>
	<20091102095437.GA19825@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Nov 2009 21:00:19 +0100
Message-ID: <1257192019.2210.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Virtual IRQ Numbers in powerpc?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2009-11-02 at 10:54 +0100, Richard Cochran wrote:
> On Sun, Oct 25, 2009 at 12:13:45AM +0200, Philippe Gerum wrote:
> > 
> > adeos-ipipe-2.6.30-powerpc-DENX-2.7-00:   fine
> > adeos-ipipe-2.6.30.3-powerpc-DENX-2.7-01: BROKEN
> > adeos-ipipe-2.6.30.3-powerpc-DENX-2.7-02: fine
> 
> I am using git to track ipipe, but these two commits
> 
>   da0e45d1e84389bdf5e750e9179767fd274f7031
>   9010961a407699a3908d7c2a842a8ece6084cee3
> 
> don't show up when I pull from
> 
>   git://git.denx.de/ipipe-2.6.git
> 
> I think that is because the commit are not in any branch. I think they
> should be in branch ipipe-2.6.30-powerpc.
> 
> See this:
> 
>   http://git.denx.de/?p=ipipe-2.6.git;a=shortlog;h=9010961a407699a3908d7c2a842a8ece6084cee3

Those commits seem to still be in flight from my remote staging tree to
the public one, waiting for a mirroring to happen. They are indeed part
of ipipe-2.6.30-powerpc; those are actually the latest commits on top of
2.7-01, leading to 2.7-02.

> 
> Richard
> 
> 
> 


-- 
Philippe.



