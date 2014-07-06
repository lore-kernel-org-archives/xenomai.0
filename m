Message-ID: <53B974A3.5010004@xenomai.org>
Date: Sun, 06 Jul 2014 18:09:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1404640109.73994.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B964DC.1020004@xenomai.org>
 <1404662453.79446.YahooMailNeo@web171601.mail.ir2.yahoo.com>
In-Reply-To: <1404662453.79446.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] issue with cobalt/timer: avoid periodic timer drift
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 07/06/2014 06:00 PM, Matthias Schneider wrote:
>> You seem to have created a periodic timer with a null period. Could you
>> post a sample code allowing to reproduce this issue?
>>  
> 
> 
> This happens in most of my freertos apps (e.g. demo, etc.). However, 
> I have not put any effort in narrowing the problem down, in the hope
> the problem would be deductible from the kernel state. Maybe you could
> give a few hints where a periodic timer could come into play? In the
> freertos skin there are only tasks, queues and semaphores, so I
> am not creating any periodic timer explicitly. Are there occasiosn
> when periodic timers are being created implicitly using the three
> primitives mentioned above? Or can I configure an intelligent
> breakpoint to catch the creation of a periodic timer?

Maybe you could put a breakpoint to see where xntimer_start is called?


-- 
                                                                Gilles.

