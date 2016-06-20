From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <447fdp9oue.fsf@be-well.ilk.org>
 <0b7ab1b8-8d53-069a-49b6-a3f289c0b43c@xenomai.org>
 <441t3rlwfe.fsf@be-well.ilk.org>
 <20160620152246.GA18662@hermes.click-hack.org>
Date: Mon, 20 Jun 2016 13:15:38 -0400
In-Reply-To: <20160620152246.GA18662@hermes.click-hack.org> (Gilles
 Chanteperdrix's message of "Mon, 20 Jun 2016 17:22:46 +0200")
Message-ID: <44wpljkchx.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] slackspot
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:

> There is one possibility: if your thread runs with the
> SCHED_OTHER/SCHED_WEAK scheduling policy, I would not expect the
> relaxes to trigger anything, as you have been asking for them by
> choosing to use these policies.

Yes, I should have mentioned that topic. I have run this under both
SCHED_FIFO and SCHED_RR.

