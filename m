From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <459D14C4.40300@domain.hid>
References: <459D14C4.40300@domain.hid>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 11:17:17 +0100
Message-Id: <1167992238.6702.34.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [BUG] timerbench tests don't work with SVN
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

On Thu, 2007-01-04 at 15:52 +0100, Jan Kiszka wrote:
> Hi Philippe,
> 
> likely a regression of latest timer base patches: with periodic support
> enabled (haven't tested the off case yet), latency -t1/2 no longer work.
> I have no time to look at this, so I just dump my report here. :)

Ok, fixed by #2054.

-- 
Philippe.



