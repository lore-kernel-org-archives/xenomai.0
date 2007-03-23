Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17
	kernel.... Various problems
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46040E1D.50709@domain.hid>
References: <032320071721.22696.46040CB10009C87B000058A82216557996070E0301020A98@domain.hid>
	<46040E1D.50709@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 18:48:57 +0100
Message-Id: <1174672137.4606.64.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, xenomai@domain.hid

On Fri, 2007-03-23 at 18:27 +0100, Jan Kiszka wrote:
> xenomai@domain.hid wrote:
> > RE Previous message : hanging daemons
> > 
> > 
> > I just started removing modules.  First timerbench, then native, then rtdm.... That did it.  When I remove rtdm the daemon drops to normal cpu usage.
> 
> That sounds a bit like we have some issue with the host timer of Linux
> once Xenomai takes over.
> 

Just loading the native skin over the nucleus would confirm this or not.

> A lot changed during your last tests. To make sure we are discussing the
> same setup, could you re-post your current .config and the used versions
> of Xenomai, kernel, and ipipe patch to the list?
> 
> TiA,
> Jan
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



