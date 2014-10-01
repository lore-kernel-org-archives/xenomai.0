From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 1 Oct 2014 12:02:19 -0400
Message-ID: <20141001160219.GE4435@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <542C165E.6060809@xenomai.org>
 <20141001150206.GB4435@csclub.uwaterloo.ca>
 <542C1DA3.8080306@xenomai.org>
 <20141001154641.GC4435@csclub.uwaterloo.ca>
 <20141001155252.GD4435@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141001155252.GD4435@csclub.uwaterloo.ca>
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

On Wed, Oct 01, 2014 at 11:52:52AM -0400, Lennart Sorensen wrote:
> That didn't seem to make any difference except of course now the IRQ
> doesn't get listed in /proc/interrupts anymore.

Question:

When I do request_irq I can specify IRQF_TRIGGER_HIGH.  How does one do
the same thing for rt_intr_create?  After all that is an important thing
to tell the irq controller in this case.

-- 
Len Sorensen

