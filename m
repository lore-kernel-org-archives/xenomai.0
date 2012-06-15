Message-ID: <4FDBABEB.90300@xenomai.org>
Date: Fri, 15 Jun 2012 23:40:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAAvA3H9r3kdS-ayZRP-Je==d_ditwyXj43v=6XVB4rSPLiOHtA@mail.gmail.com>
In-Reply-To: <CAAvA3H9r3kdS-ayZRP-Je==d_ditwyXj43v=6XVB4rSPLiOHtA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] x86 MSI support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Weber <jwamsc@gmail.com>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On 06/15/2012 08:44 PM, Jeff Weber wrote:
> Is the FAQ line:
>
> "The I-pipe patch currently does not support MSI interrupts."
>
> still true?  This FAQ is dated to 2008.
>

In retrospect, this FAQ entry is somewhat misleading. As Jan pointed out 
a couple of times already, the I-pipe does handle MSI interrupts 
properly, but doesn't allow non-root domains to call the IRQ 
masking/unmasking code for MSI. Since unmasking is usually paired with 
requesting an IRQ, and masking is paired with releasing it, the 
restriction should include the request/free calls as well.

There is no reason to mask MSI in the pre-handling code due to their 
semantics, and therefore no reason to unmask them upon return from the 
handler, so the restriction turns out to be a non-issue for most use 
cases. If a primary domain handler really wants to prevent more MSI to 
come from a given source, then it should quiesce the issuing device.

> I've been using MSIs and adeos-ipipe-2.6.38.8-x86-2.10-01.patch and haven't
> seen a problem yet.
>

-- 
Philippe.

