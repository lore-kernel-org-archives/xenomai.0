Mime-Version: 1.0
Date: Fri, 15 Jun 2007 22:17:31 -0800
Message-ID: <DB21A0DD952.000005E0ejr@domain.hid>
From: Junior <ejr@domain.hid>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-core] HZ, tick timer and scheduler relation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi all,
It was suggested that I ask this question on this list.
If I have the wrong list please let me know.

I'm using ARM linux kernel 2.6.18 on a custom board and on my
development board the scheduler timeslice was 10ms and
on my custom board it's 100ms. I had HZ up'ed to 400 instead of
the 200 ARM default.
I've tried repeatedly to reduce this to 10ms but for some reason
changing HZ has no effect as the scheduler timeslice hovers around
100ms +/- 10ms. My clock tick timer is set the same =40 =7E3.6MHz.
On the 2.6.18 kernel, Changing HZ does have the expected effect but
perhaps something changed in 2.6.18.

I'm trying to understand what the relation is between HZ, the clock tick =
timer
and the scheduler timeslice.
Could anyone help me understand this? or suggest some good reading =
materials?

Thank You.
--Jr.

