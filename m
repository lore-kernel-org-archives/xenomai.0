Date: Mon, 24 Nov 2014 19:13:45 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141124181345.GC26532@sisyphus.hd.free.fr>
References: <CAKKWdtfZm+F3M+VtD2zG=JMun1GYtNDOAbzYvVUDXxq5B8qsMw@mail.gmail.com>
 <53F30622.4050605@xenomai.org>
 <CAKKWdtfjaZcjX0q0W0kJQSeJiNCssYE21hrbzR4PseXr1MOzfw@mail.gmail.com>
 <5473636E.6030206@xenomai.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5473636E.6030206@xenomai.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] a question about interrupts
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jorge Ramirez Ortiz <jro@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 24, 2014 at 11:57:18AM -0500, Jorge Ramirez Ortiz wrote:
> On 11/24/2014 11:38 AM, ali hagigat wrote:
> > Please answer the following questions. I am much appreciated.
> > 
> > 1) does ISR(interrupt service routine) have priority over the Xenomai
> > real-time tasks? any ISR defined for root or head domain? are executed
> > in the middle of the real-time tasks?
> > 
> > 2) if there is a linux thread and a regular interrupt happens and then
> > a timer interrupt happnes, means , xnintr_clock_handler(), the
> > xnpod_schedule() function will suspend the linux thread? and the linux
> > thread is suspended with two nested interrupt?
> > 
> > I wonder if you could answer yourself, mailing list is escaping from
> > answering these questions. thank you
> > 
> 
> 
> hi Ali,
> 
> Let me share this with the mailing list.
> I am sure these questions can be resolved in the open - actually I think Gilles
> might have already addressed them.

Yes, the answer to the first question was given here:
https://xenomai.org/pipermail/xenomai/2014-August/031492.html

Since the answer to the question is just one word. I do not
understand what is so hard to understand about that answer.

The second question seems to be Ali's latest stupidity. Yes, xenomai
preeempt Linux whatever Linux is doing, even in the middle of an
interrupt. That is the point of virtualizing its interrupts.

-- 
					    Gilles.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: Digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141124/cd178dee/attachment.sig>
