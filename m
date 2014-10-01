Message-ID: <542C748E.7080706@xenomai.org>
Date: Wed, 01 Oct 2014 23:39:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <542C165E.6060809@xenomai.org> <20141001150206.GB4435@csclub.uwaterloo.ca>
 <542C1DA3.8080306@xenomai.org> <20141001154641.GC4435@csclub.uwaterloo.ca>
 <20141001155252.GD4435@csclub.uwaterloo.ca>
 <20141001160219.GE4435@csclub.uwaterloo.ca> <542C3A89.7000307@xenomai.org>
 <20141001174029.GF4435@csclub.uwaterloo.ca> <542C3DF7.90804@xenomai.org>
 <20141001175437.GG4435@csclub.uwaterloo.ca>
In-Reply-To: <20141001175437.GG4435@csclub.uwaterloo.ca>
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

On 10/01/2014 07:54 PM, Lennart Sorensen wrote:
> On Wed, Oct 01, 2014 at 07:46:31PM +0200, Gilles Chanteperdrix wrote:
>> Are you sure you are not simply getting an interrupt and failing to
>> clear the interrupt condition?
> 
> I won't claim to be sure yet.

Well, what is on the other end of the GPIO ? If this is a button, you
may want to set the interrupt type to edge, otherwise the interrupt will
remain asserted as long as you press the button, and you will get an
interrupt storm. If it is another GPIO, then you should reset that GPIO
state in the irq handler.

Also, it may actually be simpler to write an RTDM driver than to use the
deprecated, error-prone rtintr API.

-- 
                                                                Gilles.

