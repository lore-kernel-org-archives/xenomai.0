From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100108105925.GA14163@domain.hid>
References: <4B209B9C.7010309@domain.hid>
	<20100108105925.GA14163@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jan 2010 12:10:18 +0100
Message-ID: <1262949018.2455.5.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] I-pipe for 2.6.32 PPC
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: adeos-main@gna.org

On Fri, 2010-01-08 at 11:59 +0100, Richard Cochran wrote:
> On Thu, Dec 10, 2009 at 07:56:28AM +0100, Bernhard Pfund wrote:
> > I'm currently working with a fairly new ppc development board (P2020RDB) by 
> > Freescale. The board's BSP went mainline with 2.6.32 and I'd like to deploy an 
> > I-pipe enabled DENX kernel for testing. Now, is there an I-pipe patch for said 
> > kernel on the release schedule anywhere soon?
> 
> I got ipipe-2.6.30 running the p2020ds with minimal effort. I can post
> a diff if that might help you.
> 
> I should have my own p2020rdb soon...
> 
> I have noticed some unexplained freezes running xenomai programs on
> the p2020ds in SMP mode, but I have not yet had time to look into
> it. I hope we can work together to get SMP working reliably.

I'm working on fixing the pipeline for 2.6.32/ppc64, which includes SMP
mode. 32bit looks ok in UP mode, but I still need to validate SMP there.
So it would be great if you could hammer that patch over your P2020 as
well once it's ready. ETA, early next week. I'll keep you informed about
this.

> 
> Richard
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 
Philippe.



