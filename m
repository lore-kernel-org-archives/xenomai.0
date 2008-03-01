MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18377.42613.595681.980063@domain.hid>
Date: Sat, 1 Mar 2008 19:54:45 +0100
In-Reply-To: <47C05FE8.4090908@domain.hid>
References: <47C020A9.3050704@domain.hid> <47C02194.6010607@domain.hid>
	<18368.23071.202085.682705@domain.hid>
	<47C05FE8.4090908@domain.hid>
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
 > Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > In order to allow further optimizations of xnlock, I started with
 > >  > refactoring the related system.h. This improves the readability
 > >  > significantly, IMHO. It also happen to reduce the text size of
 > >  > __xnlock_get a bit by avoid redundant rthal_processor_id read-outs.
 > >  > 
 > >  > Another quirk I happen to remove: xnlock debugging depends on
 > >  > XENO_OPT_DEBUG_NUCLEUS, but needlessly we used to pick the debug version
 > >  > of xnlock_t already with XENO_OPT_DEBUG.
 > > 
 > > There is a lot of whitespace change in this patch, which make it hard to
 > > read.
 > 
 > Well, this patch is mostly about whitespace and formatting fixes (among
 > which ifdef reduction falls for me as well). But I can split it up if
 > desired.
 > 
 > > 
 > > Anyway, there are a few things I do not like in this patch:
 > > - macro which make reference to symbols defined elsewhere
 > 
 > You mean XNLOCK_DBG_PREPARE_ACQUIRE vs. XNLOCK_DBG_SPINNING/ACQUIRED?
 > Granted, not nice but so far the most compact approach I found. My goal
 > was to keep the lock implementations as pure as possible (you can easily
 > ignore the debug stuff now when reading xnlock_get/put).
 > 
 > > - functions arguments as macro, I find more readable the #ifdef with the
 > >   different function prototypes, the code can be read without having to
 > >   look at a different place.
 > 
 > I'm open to learn a third way to achieve what we need. I'm just
 > convinced that the old way was far worse.
 > 
 > Please consider for a better suggestion that the number of variants
 > increase with my ticket lock. That's why I tried to stuff things in
 > macros. Hmm, maybe we should simply get rid of the file/line/function
 > stuff completely and switch to IP + ksyms. What do you think?

I do not want to leave this in a dead end. IMO, your approach make
xnlock_get readable in the non debugging case at the expense of its
readability in the debugging case. I would better see the two
implementations with a unique ifdef. Granted, there will be some code
duplication, but it will not be that much, and this allows us to move
the debugging version out of line while keeping the non debugging case
inline.

-- 


					    Gilles Chanteperdrix.

