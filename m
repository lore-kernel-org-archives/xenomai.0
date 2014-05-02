Message-ID: <536356E2.30308@xenomai.org>
Date: Fri, 02 May 2014 10:27:14 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1398944548.9186.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53624421.8090903@xenomai.org>
 <1398954230.40374.YahooMailNeo@web171605.mail.ir2.yahoo.com>
In-Reply-To: <1398954230.40374.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue in __threadobj_unlock_sched (forge/mercury)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/01/2014 04:23 PM, Matthias Schneider wrote:

> b) threadobj_lock_sched() saves prio and policy and sets it to
> SCHED_RT/threadobj_lock_prio

Forcing SCHED_RT in threadobj_lock() is the core issue. Doing so allows 
SCHED_OTHER callers to hold that lock: does it make sense? Maybe it's 
handy so that client code does not have to care, on the other hand, this 
very much sounds like introducing priority inversion by design.

What would be the use case for holding the sched lock over SCHED_OTHER?

-- 
Philippe.

