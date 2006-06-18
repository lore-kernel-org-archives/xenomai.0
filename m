Subject: Re: [Xenomai-core] Buildbot progress: runs xeno-test on one board
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200606180138.20289.niklaus.giger@domain.hid>
References: <200606180138.20289.niklaus.giger@domain.hid>
Content-Type: text/plain
Date: Sun, 18 Jun 2006 15:30:10 +0200
Message-Id: <1150637410.4941.22.camel@domain.hid>
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

On Sun, 2006-06-18 at 01:38 +0200, Niklaus Giger wrote:
> I am just puzzled that during the test, I get
> >cat: /proc/xenomai/sched: No such process
> >Sat Jun 17 21:48:53 UTC 2006
> >running: cat /proc/xenomai/stat
> >cat: /proc/xenomai/stat: No such process
> Why do I get this answer? (xeno-test calls cat only for existing files?)
> 

CONFIG_XENO_OPT_STATS seems to be disabled in your configuration.

> Best regards
> 


