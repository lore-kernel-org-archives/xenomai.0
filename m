Message-ID: <1489817372.4278.44.camel@gmx.de>
From: Mike Galbraith <efault@gmx.de>
Date: Sat, 18 Mar 2017 07:09:32 +0100
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ipipe + PREEMPT_RT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

(oops, sent before subscription confirmation.. wash/rinse/repeat)

Greetings,

Seeing PREEMPT_RT in ipipe source, I got curious, extracted 4.4.43, and
wedged it into 4.4.54-rt, but there are a couple places that replace a
 spinlock_t (not raw) with an ipipe_spinlock_t, which cause build woes
for PREEMPT_RT.  I ifdefed those problematic spots back to spinlock_t
for grins, and surprisingly, my x64_64 desktop box booted, and does a
decent impersonation of a functional box.. which left me wondering
whether there's a preparatory patch for PREEMPT_RT somewhere, or
whether the PREEMPT_RT bits are WIP (or leftovers).

	-Mike   

