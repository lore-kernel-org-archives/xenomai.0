Date: Mon, 20 Jun 2016 19:18:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160620171848.GB18662@hermes.click-hack.org>
References: <447fdp9oue.fsf@be-well.ilk.org>
 <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
 <441t3rlwfe.fsf@be-well.ilk.org>
 <20160620152246.GA18662@hermes.click-hack.org>
 <44wpljkchx.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44wpljkchx.fsf@be-well.ilk.org>
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

On Mon, Jun 20, 2016 at 01:15:38PM -0400, Lowell Gilbert wrote:
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
> 
> > There is one possibility: if your thread runs with the
> > SCHED_OTHER/SCHED_WEAK scheduling policy, I would not expect the
> > relaxes to trigger anything, as you have been asking for them by
> > choosing to use these policies.
> 
> Yes, I should have mentioned that topic. I have run this under both
> SCHED_FIFO and SCHED_RR.

Ok. Could you post an example allowing us to reproduce the issue ?


-- 
					    Gilles.
https://click-hack.org

