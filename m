MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17570.30602.344459.631443@domain.hid>
Date: Wed, 28 Jun 2006 14:35:22 +0200
Subject: Re: [Xenomai-core] [PATCH 6/6] Introduce IRQ latency benchmark
In-Reply-To: <44A275DE.5080500@domain.hid>
References: <20060626172116.019532000@domain.hid> <20060626172120.322015000@domain.hid>
	<17570.29185.754625.871443@domain.hid>
	<44A275DE.5080500@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > > 
 > > Also note that calling printf from a signal handler risk deadlocking if
 > > the signal handler get called on the return path of the write call that
 > > take place in the middle of a printf call on the main thread.
 > > 
 > 
 > Ok, then we also need a fix for the latency test (this is where I
 > grabbed that pattern from). Is there a high risk that this locks up? I
 > wonder why I never observed or heard of problems with latency.

The mutex used by the stdio lib depends on the file descriptor, so, it
is possible to use a different file descriptor in the signal handler and
on the interrupted context.

-- 


					    Gilles Chanteperdrix.

