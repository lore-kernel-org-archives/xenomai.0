Date: Fri, 8 Jan 2010 11:59:25 +0100
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20100108105925.GA14163@domain.hid>
References: <4B209B9C.7010309@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B209B9C.7010309@domain.hid>
Subject: Re: [Adeos-main] I-pipe for 2.6.32 PPC
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Bernhard Pfund <bernhard@domain.hid>
Cc: adeos-main@gna.org

On Thu, Dec 10, 2009 at 07:56:28AM +0100, Bernhard Pfund wrote:
> I'm currently working with a fairly new ppc development board (P2020RDB) by 
> Freescale. The board's BSP went mainline with 2.6.32 and I'd like to deploy an 
> I-pipe enabled DENX kernel for testing. Now, is there an I-pipe patch for said 
> kernel on the release schedule anywhere soon?

I got ipipe-2.6.30 running the p2020ds with minimal effort. I can post
a diff if that might help you.

I should have my own p2020rdb soon...

I have noticed some unexplained freezes running xenomai programs on
the p2020ds in SMP mode, but I have not yet had time to look into
it. I hope we can work together to get SMP working reliably.

Richard

