MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17481.417.382690.108221@domain.hid>
Date: Fri, 21 Apr 2006 18:00:33 +0200
Subject: Re: [Xenomai-core] [RFC] shadow threads with prio 0 / SCHED_NORMAL
In-Reply-To: <4448FE86.4050503@domain.hid>
References: <4446B348.10403@domain.hid> <4448B81E.3090605@domain.hid>
	<17480.63623.600656.828303@domain.hid>
	<4448FE86.4050503@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > > What about keeping SCHED_RR as the default scheduling policy and
 > > requiring users to manually select SCHED_NORMAL in thread creation
 > > attributes in order to create hybrid threads with pthread_create ?
 > > 
 > 
 > No objection a priori, but what would this buy us?

As a user, I would expect pthread_create and pthread_setschedparam to
allow the same scheduling policies and priorities.

-- 


					    Gilles Chanteperdrix.

