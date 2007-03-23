From: xenomai@domain.hid
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
Date: Fri, 23 Mar 2007 17:21:53 +0000
Message-Id: <032320071721.22696.46040CB10009C87B000058A82216557996070E0301020A98@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: xenomai@xenomai.org

RE Previous message : hanging daemons


I just started removing modules.  First timerbench, then native, then rtdm.... That did it.  When I remove rtdm the daemon drops to normal cpu usage.

Mike

