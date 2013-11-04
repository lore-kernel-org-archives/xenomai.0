Message-ID: <5277CD7C.3050903@xenomai.org>
Date: Mon, 04 Nov 2013 17:38:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5277C86F.5070603@wanadoo.fr> <5277C73E.3020007@xenomai.org>
 <5277CC99.7050602@wanadoo.fr>
In-Reply-To: <5277CC99.7050602@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] big deviation on clock_nanosleep wait time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: Xenomai <xenomai@xenomai.org>

On 11/04/2013 05:34 PM, Thierry Bultel wrote:
> Le 04/11/2013 17:11, Gilles Chanteperdrix a écrit :
>> On 11/04/2013 05:16 PM, Thierry Bultel wrote:
>>> Hi,
>>>
>>> My configuration is
>>> xenomai-2.6.3 + ipipe-1.18-13, freescale kernel rel_imx_3.0.35_4.0.0, on
>>> the IMX6Q.
>>>
>>> I want to use CONFIG_HIGH_RES_TIMERS and CONFIG_HZ=100, which is the
>>> default value for the IMX.
>>
>> Do you observe the same issue without CONFIG_HIGH_RES_TIMERS?
>>
>>
> 
> Without CONFIG_HIGH_RES_TIMERS, the wait precision is dictated by
> CONFIG_HZ, in other words 10 ms.
> 
> FYI as I needed to wait 30ms with a 1 ms precision, I formerly had to
> hack Kconfig to allow CONFIG_HZ=1000 (and it worked fine).

It appeared to work fine, however Linux is not an RTOS, it can not
guarantee a 1ms latency. Why not using Xenomai for precise sleeps? Other
than that, I have no idea, I would use the I-pipe tracer to understand
what is going on in between the time when the timer ticks and the time
when the task is woken up.

-- 
                                                                Gilles.

