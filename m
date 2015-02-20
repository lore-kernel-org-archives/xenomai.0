Date: Fri, 20 Feb 2015 23:57:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150220225712.GE2356@hermes.click-hack.org>
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan> <447fvc5q6z.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447fvc5q6z.fsf@be-well.ilk.org>
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: xenomai@xenomai.org

On Fri, Feb 20, 2015 at 02:38:12PM -0500, Lowell Gilbert wrote:
> Lowell Gilbert <kludge@be-well.ilk.org> writes:
> 
> > Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
> >
> >> On Wed, Feb 18, 2015 at 05:03:33PM -0500, Lowell Gilbert wrote:
> >>> Hi.
> >>> 
> >>> I have a kernel task created with rtdm_task_init(). I can wake it up
> >>> from my ioctl handler in non-RT, but not from inside my ISR, which was
> >>> hooked with rtdm_irq_request(). I tried it with a semaphore, with an
> >>> event, and then with just rtdm_task_unblock(). I'm probably doing
> >>> something silly here; are there any obvious places to look?
> >>
> >> Are you sure the irq handler is actually called ?
> >
> > Yes.
> >
> > [I increment a variable every time the IRQ runs, just to be sure.]
> 
> The mailing list stripped my code, so I'll attach it inline.

It does not strip it, it puts it on a server that can be accessed
with http, so that only the people who want to see it download it,
instead of forcibly sending it to all the subscribers.

Will look at your code later. But at a quick glance I see nothing
wrong.


-- 
					    Gilles.

