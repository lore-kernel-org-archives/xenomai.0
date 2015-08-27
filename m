References: <55DF2471.6030006@cern.ch>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55DF2868.2070804@xenomai.org>
Date: Thu, 27 Aug 2015 17:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <55DF2471.6030006@cern.ch>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cyclictest in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Konstantinos Chalas <konstantinos.chalas@cern.ch>, xenomai@xenomai.org

On 08/27/2015 04:53 PM, Konstantinos Chalas wrote:
> Hello everyone,
> 
> Is there any plans to port cyclictest over at xenomai-3 for the Cobalt
> kernel? I compiled the original source file from the rt-tests repo my
> self for xenomai-3,. For reference i used to get around 70 us worst case
> with the Beaglebone black using Xenomai-2, but it goes up to 200 us
> immediatly with the one i compiled. By the way, i followed the
> xeno-config procedure. Is there anyone who cares to provide an explanation?
> 

Any information about the exact build command used, the clock
calibration from /proc/xenomai/clock/coreclk, and the options passed to
cyclictest?

Btw, the vanilla cyclictest code had to be adapted for running over
Xenomai 2.

-- 
Philippe.

