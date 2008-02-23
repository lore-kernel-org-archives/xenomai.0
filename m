MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18368.23071.202085.682705@domain.hid>
Date: Sat, 23 Feb 2008 18:38:39 +0100
In-Reply-To: <47C02194.6010607@domain.hid>
References: <47C020A9.3050704@domain.hid>
	<47C02194.6010607@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 1/4] Refactor generic system.h
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
 > In order to allow further optimizations of xnlock, I started with
 > refactoring the related system.h. This improves the readability
 > significantly, IMHO. It also happen to reduce the text size of
 > __xnlock_get a bit by avoid redundant rthal_processor_id read-outs.
 > 
 > Another quirk I happen to remove: xnlock debugging depends on
 > XENO_OPT_DEBUG_NUCLEUS, but needlessly we used to pick the debug version
 > of xnlock_t already with XENO_OPT_DEBUG.

There is a lot of whitespace change in this patch, which make it hard to
read.

Anyway, there are a few things I do not like in this patch:
- macro which make reference to symbols defined elsewhere
- functions arguments as macro, I find more readable the #ifdef with the
  different function prototypes, the code can be read without having to
  look at a different place.

Something we could be interesting would be to be able to enable
spinlocks debug in UP, which would enable real debugging xnlocks in this
case. I made an attempt of doing this on ARM some time ago, this
generated a kernel that would lockup at boot. But I think this is
something we should sort out.

-- 


					    Gilles Chanteperdrix.

