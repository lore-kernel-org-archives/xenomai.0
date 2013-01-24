MIME-Version: 1.0
In-Reply-To: <CAD1EtogPNsGWkA0_puttwFTGMfZ6aW1_1WniND0GRJYRba389Q@mail.gmail.com>
References: <CAD1EtogQBZ5f=7w5mZz19rrnQVB_BP=t-f4rKtq12wKn9cd1Yw@mail.gmail.com>
	<50FF1249.2070807@xenomai.org>
	<CAD1EtoiMKsipxzaDZOHFHfzQWRX1Oub=HspCCn01UNC3C9e53A@mail.gmail.com>
	<50FF16E9.7050902@xenomai.org>
	<CAD1EtogPNsGWkA0_puttwFTGMfZ6aW1_1WniND0GRJYRba389Q@mail.gmail.com>
Date: Thu, 24 Jan 2013 17:22:04 -0500
Message-ID: <CAD1Etohk3SO-dtSOUSPrwgA-oDFfQAMt_eJK9PYMrVWhO=SJjw@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] x86 Linux with xenomai and i915 graphics stall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org
Cc: Andrew Tannenbaum <trb@interactive-motion.com>

Hi Gilles et al.,

We tried setting processor type more correctly, turning off CONFIG_M686 and
turning on CONFIG_MCORE2, and also turned off CONFIG_X86_GENERIC.

That change has caused our worst latencies to drop to around 200us, but
those are actually rare - we can only [but reliably] trigger that by using
glxgears with a very large (1200x700 or larger or so) window size. (Other
things we tried had no latency-increasing effects - we tried heavy disk and
network activity, playing youtube videos, etc.)''

/proc/ipipe/trace/frozen, without glxgears running: http://ix.io/46I
with glxgears running: http://ix.io/46J

Log of latency: http://ix.io/46L

And.... here is a video of the problem:
http://www.youtube.com/watch?v=l4rYvhqZql8
 (problem starts at about 0:41)

Can you think of anything else we could try? We've tried enabling SMI
workaround, disabling PM_RUNTIME, disabling MTRR, and disabling X86_PAT,
and none of these have solved this issue.

Thanks so much for your help,
Daniel and Andy
Interactive Motion
