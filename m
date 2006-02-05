Message-ID: <43E6861E.3000400@domain.hid>
Date: Mon, 06 Feb 2006 00:11:26 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] ... the rt-preempt patch once been in fusion
References: <43E668EF.4090306@domain.hid>
In-Reply-To: <43E668EF.4090306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hannes Mayer <h.mayer@domain.hid>
Cc: xenomai@xenomai.org

Hannes Mayer wrote:
> Hi all!
> 
> Well, subject says almost all.
> I remember there has been an effort to make a fusion/rt-preempt
> patch conglomerate back then.
> I'm just curious (as I've just been toying with the Molnar
> patch) - has that thing been dropped in xeno completely ?
> 

Clearly not, it is still on the project's agenda, but PREEMPT_RT has been too much 
of a moving target recently, not to speak of the vanilla 2.6 kernel itself. Even 
if Xeno's core has not changed in the same proportions, a large refactoring has 
taken place for 2.1 though.

Additionally, PREEMPT_RT's infrastructure has evolved a lot since Xeno was first 
ported over such kernel, and the way to interface both sub-systems likely needs to 
be re-thought. This combo cannot be done overnight, but I think that we are 
getting close to point where it would be possible to rework on this issue.

This work is likely going to start by a test campaign evaluating PREEMPT_RT's and 
Xeno's nucleus performances in a series of simple and relevant test cases over 
different ranges of platforms, so that we could measure up to which point (and 
under which condition) the real-time spectrum would be widened by using a 
combination of both.

-- 

Philippe.

