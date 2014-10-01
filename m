Message-ID: <542C3DF7.90804@xenomai.org>
Date: Wed, 01 Oct 2014 19:46:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <542C165E.6060809@xenomai.org> <20141001150206.GB4435@csclub.uwaterloo.ca>
 <542C1DA3.8080306@xenomai.org> <20141001154641.GC4435@csclub.uwaterloo.ca>
 <20141001155252.GD4435@csclub.uwaterloo.ca>
 <20141001160219.GE4435@csclub.uwaterloo.ca> <542C3A89.7000307@xenomai.org>
 <20141001174029.GF4435@csclub.uwaterloo.ca>
In-Reply-To: <20141001174029.GF4435@csclub.uwaterloo.ca>
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

On 10/01/2014 07:40 PM, Lennart Sorensen wrote:
> On Wed, Oct 01, 2014 at 07:31:53PM +0200, Gilles Chanteperdrix wrote:
>> I guess you have to manually call irq_set_irq_type, that being said, if
>> you used request_irq, the GPIO should be configured and the type set. If
>> you register the Xenomai interrupt after that, it should get the
>> interrupt, if it does not get it, it probably means that you have an
>> issue in the gpio demuxing code.
> 
> So I found now that if I do request_irq first and then rt_intr_create,
> then if I pass TRIGGER_HIGH or TRIGGER_LOW, then the system hangs as
> soon as rt_intr_create is called (right after dumping the nice message
> from ipipe I had in the first email).  If I do request_irq without that,
> then it does not hang.  How odd.

Are you sure you are not simply getting an interrupt and failing to
clear the interrupt condition?

Are you sure that the GPIO demuxing code calls ipipe_handle_demuxed_irq
instead of generic_handle_irq?

-- 
                                                                Gilles.

