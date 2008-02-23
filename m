MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18368.26112.776987.660255@domain.hid>
Date: Sat, 23 Feb 2008 19:29:20 +0100
In-Reply-To: <47C06052.2020406@domain.hid>
References: <47C020A9.3050704@domain.hid> <47C02113.7070005@domain.hid>
	<18368.23256.85461.492726@domain.hid>
	<47C06052.2020406@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH 2/4] Fix and optimize xnlock_put
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
 > >  > As the #ifdef forest was cut down, I once again looked at xnlock_put.
 > >  > Why do you have this safety check for the owner also in production code?
 > > 
 > > Because only one broken xnlock_put could entail a chain reaction of
 > > broken xnlock sections with code on multiple CPU violating critical
 > > sections. With the test, we prevent the chain reaction. But I agree this
 > > check should not be silent.
 > 
 > When there is a bug, then there is bug and we are hosed. That's why we
 > have debug checks for finding such cases in advance. Here I was talking
 > about such a debug check in a hot path on a _production_ system, and
 > that check even had no fault recovery. That appeared pointless to me.
 > 
 > Just to avoid misunderstandings: This version is not different from the
 > old one if XENO_OPT_DEBUG_NUCLEUS is on, the switch which was introduced
 > to cover specifically lock debugging.
 > 
 > Do you have an idea for some cheap fault recovery for broken locking
 > that we should put in instead?

The fault recovery is to leave the xnlock untouched, in order to avoid
the chain reaction I was talking about. Anyway, I think even production
code should contain some sanity checks, and this one looks cheap.


-- 


					    Gilles Chanteperdrix.

