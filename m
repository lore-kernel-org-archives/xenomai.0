Message-ID: <542C3A89.7000307@xenomai.org>
Date: Wed, 01 Oct 2014 19:31:53 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <542C165E.6060809@xenomai.org> <20141001150206.GB4435@csclub.uwaterloo.ca>
 <542C1DA3.8080306@xenomai.org> <20141001154641.GC4435@csclub.uwaterloo.ca>
 <20141001155252.GD4435@csclub.uwaterloo.ca>
 <20141001160219.GE4435@csclub.uwaterloo.ca>
In-Reply-To: <20141001160219.GE4435@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 10/01/2014 06:02 PM, Lennart Sorensen wrote:
> On Wed, Oct 01, 2014 at 11:52:52AM -0400, Lennart Sorensen wrote:
>> That didn't seem to make any difference except of course now the IRQ
>> doesn't get listed in /proc/interrupts anymore.
> 
> Question:
> 
> When I do request_irq I can specify IRQF_TRIGGER_HIGH.  How does one do
> the same thing for rt_intr_create?  After all that is an important thing
> to tell the irq controller in this case.
> 
I guess you have to manually call irq_set_irq_type, that being said, if
you used request_irq, the GPIO should be configured and the type set. If
you register the Xenomai interrupt after that, it should get the
interrupt, if it does not get it, it probably means that you have an
issue in the gpio demuxing code.

-- 
                                                                Gilles.

