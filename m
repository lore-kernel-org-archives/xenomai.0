From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan>
Date: Fri, 20 Feb 2015 14:38:12 -0500
In-Reply-To: <44pp9633yh.fsf@lowell-desk.lan> (Lowell Gilbert's message of
 "Wed, 18 Feb 2015 23:44:38 -0500")
Message-ID: <447fvc5q6z.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

Lowell Gilbert <kludge@be-well.ilk.org> writes:

> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> writes:
>
>> On Wed, Feb 18, 2015 at 05:03:33PM -0500, Lowell Gilbert wrote:
>>> Hi.
>>> 
>>> I have a kernel task created with rtdm_task_init(). I can wake it up
>>> from my ioctl handler in non-RT, but not from inside my ISR, which was
>>> hooked with rtdm_irq_request(). I tried it with a semaphore, with an
>>> event, and then with just rtdm_task_unblock(). I'm probably doing
>>> something silly here; are there any obvious places to look?
>>
>> Are you sure the irq handler is actually called ?
>
> Yes.
>
> [I increment a variable every time the IRQ runs, just to be sure.]

The mailing list stripped my code, so I'll attach it inline.

According to the statistics that get printed, he bottom half never
executes, although the top half does.

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: tut02-skeleton-drv.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150220/6ada56c5/attachment.c>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: tut02-skeleton-app.c
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20150220/6ada56c5/attachment-0001.c>
