From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17432.6129.478721.712374@domain.hid>
Date: Wed, 15 Mar 2006 14:34:41 +0100
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
In-Reply-To: <4417C14A.2010900@domain.hid>
References: <44172B67.2000609@domain.hid>
	<4417C14A.2010900@domain.hid>
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
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Likely too simple: The periodic IRQ seems to pop up on every CPU so that
 > the TSC could be recorded, but will this happen synchronously? At least
 > we will see (IRQ) jitters, and those jitters could already create in the
 > single-CPU case a non-monotonic clock...

I do not know how this issue is solved in Linux, but there seem to be a
simple solution: before adding the tsc offset to the last tick time,
this tsc offset should be compared with the tick duration in tsc
counts; if it is greater, then replace with the tick duration in tsc.

-- 


					    Gilles Chanteperdrix.

