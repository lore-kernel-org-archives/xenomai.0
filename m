Message-ID: <532605BE.3060101@xenomai.org>
Date: Sun, 16 Mar 2014 21:12:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1394996997.10478.YahooMailNeo@web171605.mail.ir2.yahoo.com>
In-Reply-To: <1394996997.10478.YahooMailNeo@web171605.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue suspending threads on mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/16/2014 08:09 PM, Matthias Schneider wrote:
> Hi all,
> 
> I am experiencing a problem with xenomai-forge (recent "next" checkout) on 
> Mercury (on top of a 3.12.9+CONFIG_PREEMPT_RT on x86) when suspending 
> tasks/threads.
> 
> As far  as I understand, the mercury implementation sends a signal to the thread 
> to be suspended, with that threads signal handler setting the suspended state, 
> i.e. the setting of __THREAD_S_SUSPENDED happens in notifier_callback, which 
> seems to be different from the cobalt implementation.
> 
> The problem I am experiencing is that sometimes the signal handler never seems 
> to get called in a thread that should be suspended,  i.e. that thread suspension 
> sometimes simply does not work.
> The following example code (for the vxworks skin) reproduces the issue (it gets 
> stuck in the loop waiting for the WIND_SUSPEND flag): 
> 
> http://www.pastebin.ca/2667435
> 
> Any hints on how I can continue investigating this issue?

Have you tried checking taskSpawn and taskSuspend return values? To see
if the calls are successful?


-- 
                                                                Gilles.

