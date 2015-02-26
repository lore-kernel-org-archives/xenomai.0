Message-ID: <54EFA995.4010402@grinta.net>
Date: Fri, 27 Feb 2015 00:17:41 +0100
From: Daniele Nicolodi <daniele@grinta.net>
MIME-Version: 1.0
References: <44bnkqho7e.fsf@lowell-desk.lan>
 <20150218220804.GR30317@hermes.click-hack.org>
 <44pp9633yh.fsf@lowell-desk.lan> <447fvc5q6z.fsf@be-well.ilk.org>
 <20150220225712.GE2356@hermes.click-hack.org>
 <448ufmewxt.fsf@be-well.ilk.org>
 <20150224233439.GL14148@hermes.click-hack.org>
 <44siduq7us.fsf@be-well.ilk.org> <54EE07A9.4040702@xenomai.org>
 <444mq9lo5c.fsf@be-well.ilk.org> <44vbipk8m9.fsf@be-well.ilk.org>
 <54EF014A.9000902@xenomai.org> <447fv4sk55.fsf@lowell-desk.lan>
 <54EF5E45.30907@xenomai.org> <44a900eaqu.fsf@lowell-desk.lan>
 <54EF8115.6030200@xenomai.org> <44wq34cmfh.fsf@lowell-desk.lan>
In-Reply-To: <44wq34cmfh.fsf@lowell-desk.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] interrupt service
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Gilbert,

what I'm suggesting is maybe naive, but as the problem seems to origin
from the frequency of the interrupts, and since you have control over
the whole stack, can you try to lower the irq rate?

If things start to magically work at at lower rates, at least you would
have a known working configuration on which base optimization and design
decisions.

On 26/02/15 23:55, Lowell Gilbert wrote:
>> This is what bothers me. The CPU running the ISR code is likely unable
>> to handle any regular linux activity in this case.
> 
> There isn't any useful Linux activity happening there. I just need to
> keep it from interfering much with the *other* CPU.

This has been repeated many times now: even if the Linux kernel is not
doing anything useful, it needs to do some amount of housekeeping to
ensure that things keep working fine.

Cheers,
Daniele


