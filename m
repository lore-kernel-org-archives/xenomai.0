From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 2 Oct 2014 15:34:35 -0400
Message-ID: <20141002193435.GO4435@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <542C165E.6060809@xenomai.org>
 <20141001150206.GB4435@csclub.uwaterloo.ca>
 <542C1DA3.8080306@xenomai.org>
 <20141001154641.GC4435@csclub.uwaterloo.ca>
 <20141001155252.GD4435@csclub.uwaterloo.ca>
 <20141001160219.GE4435@csclub.uwaterloo.ca>
 <542C3A89.7000307@xenomai.org>
 <20141001174029.GF4435@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141001174029.GF4435@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Oct 01, 2014 at 01:40:29PM -0400, Lennart Sorensen wrote:
> So I found now that if I do request_irq first and then rt_intr_create,
> then if I pass TRIGGER_HIGH or TRIGGER_LOW, then the system hangs as
> soon as rt_intr_create is called (right after dumping the nice message
> from ipipe I had in the first email).  If I do request_irq without that,
> then it does not hang.  How odd.

Also interesting.  If I pass TRIGGER_RISING instead of HIGH or LOW,
then it does not hang (but also does not see any interrupts).

-- 
Len Sorensen

