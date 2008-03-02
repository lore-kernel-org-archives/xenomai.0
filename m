MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18378.50046.906228.646119@domain.hid>
Date: Sun, 2 Mar 2008 16:10:54 +0100
In-Reply-To: <47CA8934.3060405@domain.hid>
References: <47CA8934.3060405@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 0/6] Fix, refactor,
	and optimize xnlock services, v2
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
Cc: Xenomai-core@domain.hid

Jan Kiszka wrote:
 > Hi,
 > 
 > here comes version 2 of my xnlock rework. Changes since the first
 > release:
 > 
 >  - Moved xnlock_spin out-of-line instead uninlining the irqsave/restore
 >    services

The size changes are not as dramatic as with the first version. Did you
have any chance to test the latency with your first version?

 >  - Beautified xnlock_dbg interface (now only static-inlines)

Well, I am still not convinced, I still find the debugging version harder
to read. Is there a problem with implementing the two versions
separately with a unique #ifdef?

-- 


					    Gilles Chanteperdrix.

