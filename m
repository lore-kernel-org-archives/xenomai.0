References: <9dee4e70-9bce-2fac-2aba-f27e65a9c1ba@tuebingen.mpg.de>
 <50805f15-f8c3-a47d-0b05-7b722d44a73e@xenomai.org>
 <9607c407-8524-0006-910d-941a07d1f9d8@tuebingen.mpg.de>
 <96be225a-62dd-0aca-91f5-d0efdd97307f@xenomai.org>
 <31cb225a-dd40-fa3a-37e9-139691ea01f4@tuebingen.mpg.de>
 <3e59ddd3-74dd-a0b5-5197-d748137dc296@xenomai.org>
From: Julian Viereck <jviereck@tuebingen.mpg.de>
Message-ID: <4f89e09b-dd7c-835c-c955-5cd810bfff59@tuebingen.mpg.de>
Date: Thu, 1 Mar 2018 13:40:50 -0500
MIME-Version: 1.0
In-Reply-To: <3e59ddd3-74dd-a0b5-5197-d748137dc296@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Low latency under stress, otherwise high latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

> What was the worst-case latency with HT enabled?
The largest value I've observed was 883 microseconds, which happend only 
once.

Typical values range around 120-150 microseconds. When running the 
stress test it goes < 20 microsecond.


Am 1.3.18 um 12:53 PM schrieb Philippe Gerum:
> On 03/01/2018 06:46 PM, Julian Viereck wrote:
>>> 1) disable hyperthreading and running a single core
>> Seems like the latency problem is due to enabled hyperthreading.
>>
>> I reran the latency tests with hyperthreading disabled and the latencies
>> stay below 20 microseconds now. This is with 1 and 8 cores. Sorry for
>> reporting something different yesterday.
>>
> What was the worst-case latency with HT enabled?
>


