Subject: Re: [Xenomai-core] Towards periodic mode over aperiodic timers
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17637.53630.902869.885922@domain.hid>
References: <44E46EDC.1000707@domain.hid> <1155899619.4326.56.camel@domain.hid>
	<44E5AF32.3020102@domain.hid> <1155911563.4326.96.camel@domain.hid>
	<17637.53630.902869.885922@domain.hid>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 17:05:00 +0200
Message-Id: <1155913500.4326.112.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Fri, 2006-08-18 at 16:41 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > Before we start implementing anything, there is still another issue (at
>  > least) to address: how do we deal with the wall clock time, basically
>  > xnpod_get_time/set_time, and the xnarch-level counterparts, after we
>  > move the logic from the central pod to a per-thread/per-timer view? E.g. what
>  > should xnpod_get_time() return when called over an ISR context? 
> 
> If we add an xntimer_base_t context, the each skin would initialize its
> context (or even contexts, if a skin has several time bases), and pass a
> pointer to a base to xnpod_get_time.

Looks good. This would also solve the issue of having different wall
clocks for concurrent skins, which is still something we can't have
right now.

-- 
Philippe.



