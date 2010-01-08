Message-ID: <4B470580.3060607@domain.hid>
Date: Fri, 08 Jan 2010 11:14:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Latency spots due to involuntary mode switches to
	secondary mode.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>


Hi,

due to bugs, it may happen that the latency test spots are due to
involuntary mode switches to secondary mode. This is bad, because users
testing xenomai quickly on their platform may find a bad latency, and go
quickly to conclusions without even posting a mail on the mailing lists.

Avoiding this looks simple: we should enable T_WARNSW on the sampling
thread, and make it the default behaviour. But unfortunately, there are
platforms around such as some low-end ppc where switches to secondary
mode are normal, so stopping the test when hitting such mode switches
may not be the best thing to do.

So, what do you think should be done?

-- 
					    Gilles.

