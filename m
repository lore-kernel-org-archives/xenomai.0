Message-ID: <539204D5.6000100@xenomai.org>
Date: Fri, 06 Jun 2014 20:13:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140606135912.GJ5765@lukather> <5391FFCD.3010505@xenomai.org>
 <20140606180357.GE5594@piout.net>
In-Reply-To: <20140606180357.GE5594@piout.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Atmel SAMA5D3 with a 3.14 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Michael Opdenacker <michael@free-electrons.com>, Thomas Petazzoni <thomas@free-electrons.com>, Boris Brezillon <boris@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, xenomai@xenomai.org, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine@free-electrons.com>

On 06/06/2014 08:03 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 06/06/2014 at 19:52:13 +0200, Gilles Chanteperdrix wrote :
>> On 06/06/2014 03:59 PM, Maxime Ripard wrote:
>>> Hi Gilles,
>>>
>>> I've been experimenting these days with the i-pipe 3.14 kernel,
>>> and current xenomai master branch on the Atmel SAMA5D3 SoC.
>>>
>>> There's a few issues there, the first one being that 
>>> at91_ipipe_early_init crashes because of a NULL pointer 
>>> dereference. This is due to the clk_get_rate call on the clock 
>>> returned by clk_get(NULL, "mck").
>>>
>>> This clk_get call cannot since 3.14 because the clock code has
>>> been rewritten, and you can't use clkdev anymore.
>>
>> Well, it works on AT91. (RM9200 and SMA9263). What you are doing with
>> SAMA5D3 here is actually a port to a new platform.
>>
> 
> Hum, I'm currently finishing to port both rm9200 and 9263 to the common
> clock framework. It is then totally possible that this will also break
> on those platforms...

We will cross that bridge when we come to it. Adapting to this kind of
changes is what means maintaining the I-pipe for an architecture. Doing
a one-shot port of the I-pipe patch is easy, maintaining it is the hard
part of the job, not hard as in tricky, but hard as in boringly Sisyphean.

> 
> Side question: do you actually own/have access to an rm9200 based board?
> 
Yes, I do, a Cogent CSB637 which was donated by Bill Gatliff. Every
Xenomai release is tested on it.

-- 
                                                                Gilles.

