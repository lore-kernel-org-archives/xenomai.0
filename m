Subject: Re: [Xenomai-core] [PATCH] prepare-kernel.sh breaks linux-2.4
	drivers/Makefile
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <54823def0610261823n4c24b6bal31afd74f3e0d962e@domain.hid>
References: <54823def0610261823n4c24b6bal31afd74f3e0d962e@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 18:43:35 +0200
Message-Id: <1161967416.4983.15.camel@domain.hid>
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
To: Andrew Dennison <andrewd.lists@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-10-27 at 11:23 +1000, Andrew Dennison wrote:
> Running prepare-kernel on the denx 2.4 kernel adds the following line
> 
> mod-subdirs := xenomai
> 
> This prevents all other mod-subdirs under drivers from building.
> 
> Patch is against r1273 but still seems to apply (and be required) on head.
> 

Applied, thanks.

> Andrew
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



