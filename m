Subject: Re: [Xenomai-core] [PATCH 2/2] /proc output - add CPU usage stats
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44AF7644.40506@domain.hid>
References: <44AECB5F.1080100@domain.hid> <1152348554.5065.5.camel@domain.hid>
	<44AF7644.40506@domain.hid>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 11:16:25 +0200
Message-Id: <1152350185.5065.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sat, 2006-07-08 at 11:09 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2006-07-07 at 23:00 +0200, Jan Kiszka wrote:
> >> Yet another (hopefully the final) version of my attempt to add simple per-thread CPU
> >> usage statistics. This variant now prints the usage in percent directly via
> >> /proc/xenomai/stat.
> > 
> > Merged, thanks.
> > 
> 
> Tabs seems to got lost on merge (I think my posted patches where ok).

Looking at the mail archive on GNA, it seems they were not. I've planned
to rerun Lindent over the sources anyway.

> 
> Jan
> 
-- 
Philippe.



