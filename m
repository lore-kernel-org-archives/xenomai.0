From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Message-Id: <595E8529-F95D-4AF7-990C-1E513191EC3B@mah.priv.at>
Date: Wed, 22 May 2013 12:01:26 +0200
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: [Xenomai] kernel equivalent of SIGXCPU
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm trying to trap scheduling violations through an exception handler

in user RT it's straightforward - use the SIGXCPU handler

is rthal_trap_catch() the way to go?=20

or is it just evaluating the rt_task_wait_period() returns ?=20

I'm a bit fuzzy as to the relation between these two - the manual says =
for rthal_trap_catch() '...uncontrolled exception or fault is caught at =
machine level.'; does this include scheduling overruns? it seems not to =
I guess

I have both in place but unsure atm what rthal_trap_catch() would buy me =
ontop

thanks in advance

- Michael

ps: I know that stuff is deprecating, it's all about a first-class =
funeral ;)=

