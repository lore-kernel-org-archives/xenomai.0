Message-ID: <54EFAA88.3020303@xenomai.org>
Date: Fri, 27 Feb 2015 00:21:44 +0100
From: Philippe Gerum <rpm@xenomai.org>
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
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 02/26/15 23:55, Lowell Gilbert wrote:

> I really wouldn't mind letting the kernel get time more frequently; I just
> need to be sure that my real time task gets at least 8 microseconds out
> of every fifteen. Would I be able to guarantee that in a polled
> architecture? What would be involved: short sleeps from a high-priority
> realtime task?
> 

Yes, I'd think so.

I don't have the context switch time figures in mind on a typical Cortex
A9 (assuming 1Ghz or close to), but the main issue boils down to cache
pollution with a dual kernel system in this case. If the real-time task
sleeps/blocks, then linux may run and cause cache lines used by the rt
code to be evicted, raising the latency.

Now, with such a fast rate (assuming 15 us), there would not be much
time for linux to run and pollute the cache anyway. But this is all so
close to the limit that I can't say that linux could run reliably either.

-- 
Philippe.

