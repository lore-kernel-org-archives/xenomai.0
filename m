From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.53630.902869.885922@domain.hid>
Date: Fri, 18 Aug 2006 16:41:02 +0200
Subject: Re: [Xenomai-core] Towards periodic mode over aperiodic timers
In-Reply-To: <1155911563.4326.96.camel@domain.hid>
References: <44E46EDC.1000707@domain.hid> <1155899619.4326.56.camel@domain.hid>
	<44E5AF32.3020102@domain.hid> <1155911563.4326.96.camel@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > Before we start implementing anything, there is still another issue (at
 > least) to address: how do we deal with the wall clock time, basically
 > xnpod_get_time/set_time, and the xnarch-level counterparts, after we
 > move the logic from the central pod to a per-thread/per-timer view? E.g. what
 > should xnpod_get_time() return when called over an ISR context? 

If we add an xntimer_base_t context, the each skin would initialize its
context (or even contexts, if a skin has several time bases), and pass a
pointer to a base to xnpod_get_time.

-- 


					    Gilles Chanteperdrix.

