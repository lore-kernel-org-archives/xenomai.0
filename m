Date: Tue, 23 Oct 2018 00:44:41 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Reply-To: Alec Ari <neotheuser@ymail.com>
Message-ID: <1232841437.65519.1540255481466@mail.yahoo.com>
In-Reply-To: <1269128408.13364854.1540082580679@mail.yahoo.com>
References: <1051803715.13351499.1540072998520.ref@mail.yahoo.com>
 <1051803715.13351499.1540072998520@mail.yahoo.com>
 <1269128408.13364854.1540082580679@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 4.14 IPIPE kernel results - Interesting bug?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Using the server preemption model (CONFIG_PREEMPT_NONE) seemed to have fixed it. I am unable to reproduce the stack trace, using either Xenomai branches (`master` or `next`)
It might be best to blacklist CONFIG_PREEMPT (and maybe CONFIG_PREEMPT_VOLUNTARY as well) until this problem is fixed.
I would suggest using !XENOMAI instead of !IPIPE when modifying kernel/Kconfig.preempt as using CONFIG_PREEMPT is a Xenomai-specific bug, not an issue directly related to IPIPE itself. CONFIG_PREEMPT does not cause problems with RTAI. The trace only appears when running the Xenomai latency test (~/xenomai/testsuite/latency/latency) and xeno-test (/usr/xenomai/bin/xeno-test)

Cheers!

Alec
