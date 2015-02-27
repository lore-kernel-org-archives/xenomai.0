Message-ID: <54F01982.20902@optusnet.com.au>
Date: Fri, 27 Feb 2015 18:15:14 +1100
From: Tom Evans <tom_usenet@optusnet.com.au>
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
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] interrupt service
Reply-To: tom_usenet@optusnet.com.au
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 27/02/15 09:55, Lowell Gilbert wrote:
> There isn't any useful Linux activity happening there. I just need to
> keep it from interfering much with the *other* CPU.

You may wish to check this where I remember a problem that may be related:

https://community.freescale.com/thread/328465

Points to:

http://www.arm.com/files/pdf/cachecoherencywhitepaper_6june2011.pdf

Contains:

     Measurements taken on a dual core Cortex-A9 at 1GHz
     with a 256K L2 cache showed that cache flushing can
     take of the order of 100us.

If one core flushes the L2 cache and the other core has a miss and goes to try 
and read from the L2, then I think it can be stalled for all that period. I 
seem to remember from when I read this that a cache flush can stall the other 
core even when it doesn't need to access L2.

A driver on the Linux core could lock the whole system up.

Tom


