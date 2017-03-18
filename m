References: <1489817372.4278.44.camel@gmx.de>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e2bd4e1a-cbd8-20de-4b95-576926bf2d78@xenomai.org>
Date: Sat, 18 Mar 2017 12:05:18 +0100
MIME-Version: 1.0
In-Reply-To: <1489817372.4278.44.camel@gmx.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe + PREEMPT_RT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mike Galbraith <efault@gmx.de>, xenomai@xenomai.org

On 03/18/2017 07:09 AM, Mike Galbraith wrote:
> (oops, sent before subscription confirmation.. wash/rinse/repeat)
> 
> Greetings,
> 
> Seeing PREEMPT_RT in ipipe source, I got curious, extracted 4.4.43, and
> wedged it into 4.4.54-rt, but there are a couple places that replace a
>  spinlock_t (not raw) with an ipipe_spinlock_t, which cause build woes
> for PREEMPT_RT.  I ifdefed those problematic spots back to spinlock_t
> for grins, and surprisingly, my x64_64 desktop box booted, and does a
> decent impersonation of a functional box.. which left me wondering
> whether there's a preparatory patch for PREEMPT_RT somewhere, or
> whether the PREEMPT_RT bits are WIP (or leftovers).

As Jan pointed out already, those reverts may well cause havoc when some
code attempts to traverse such critical sections from a co-kernel
context (aka "head stage"), since the purpose of the original change is
precisely to allow this, i.e. we have to switch the spinlock construct
from virtual IRQ disabling to real disabling.

FWIW, since commit 18aaf9db, Xenomai 3 is assuming that only raw
spinlocks may be converted to hard pipeline locks, which is only
partially the case for the current pipeline architecture though; however
this is fully enforced by the next one I'm working on (i.e. dovetail).

-- 
Philippe.

