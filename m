Message-ID: <5343BEFB.7050402@xenomai.org>
Date: Tue, 08 Apr 2014 11:18:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1396407588.27578.5.camel@localhost.localdomain>
 <533BBB11.5090808@xenomai.org>
 <1396848843.2481.15.camel@localhost.localdomain>
In-Reply-To: <1396848843.2481.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] OMAP L138
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Howard <pjh@northern-ridge.com.au>
Cc: xenomai@xenomai.org

On 04/07/2014 07:34 AM, Peter Howard wrote:
> 
> On Wed, 2014-04-02 at 09:24 +0200, Gilles Chanteperdrix wrote:
>> On 04/02/2014 04:59 AM, Peter Howard wrote:
>>> Hi,
>>>
>>> I'm interested in running xenomai on a TI-OMAP L138 board.  I found the
>>> following thread in the archives:
>>>
>>> http://www.xenomai.org/pipermail/xenomai/2010-January/018898.html
>>>
>>> where someone was working on porting ipipe and xenomai to that board.
>>> However, the thread ended with problems still unresolved, and the patch
>>> in the thread (just the changes for ipipe) isn't in the ipipe
>>> repository.
>>>
>>> Does anyone know if this work was completed or just faded into the
>>> ether?
>>
>> We never merged a patch for this processor. And a lot of things changed
>> since that time. If you are interested in porting the I-pipe patch to
>> this processor, see:
>>
>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting
>>
> 
> Contrary to what I said last week, I'm working on a patch off the head
> of the ipipe repo.  I have built a kernel with an ipipe port and with
> xenomai patched in.  However the latency results are bad right now:
> 
> root@arago:~# xeno latency -T 25
> == Sampling period: 1000 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
> RTD|      3.541|      8.833|     60.749|       0|     0|      3.541|     60.749
> RTD|      3.499|     13.583|     93.916|       0|     0|      3.499|     93.916
> RTD|      3.666|     88.999|    109.708|       0|     0|      3.499|    109.708
> RTD|      3.541|     14.958|     95.374|       0|     0|      3.499|    109.708
> RTD|      3.541|      9.333|     77.583|       0|     0|      3.499|    109.708
> RTD|      4.041|     88.416|    109.791|       0|     0|      3.499|    109.791
> RTD|      3.499|      8.958|     72.791|       0|     0|      3.499|    109.791
> RTD|      3.499|     26.041|    106.874|       0|     0|      3.499|    109.791
> RTD|      3.874|     82.708|    107.916|       0|     0|      3.499|    109.791
> RTD|      3.499|      9.083|     73.708|       0|     0|      3.499|    109.791
> RTD|      3.333|      8.874|     62.458|       0|     0|      3.333|    109.791
> RTD|      3.333|      8.749|     62.208|       0|     0|      3.333|    109.791 
> RTD|      3.416|     12.708|     99.416|       0|     0|      3.333|    109.791 
> RTD|      3.499|     14.249|    106.749|       0|     0|      3.333|    109.791 
> RTD|      3.541|      9.083|     76.499|       0|     0|      3.333|    109.791 
> RTD|      3.249|      8.791|     63.499|       0|     0|      3.249|    109.791 
> RTD|      3.416|      8.999|     62.499|       0|     0|      3.249|    109.791 
> RTD|      3.541|     26.166|    101.208|       0|     0|      3.249|    109.791 
> RTD|      3.583|     13.624|     92.458|       0|     0|      3.249|    109.791 
> RTD|      3.541|      8.916|     73.708|       0|     0|      3.249|    109.791 
> RTD|      3.541|      8.999|     64.291|       0|     0|      3.249|    109.791 
> RTT|  00:00:22  (periodic user-mode task, 1000 us period, priority 99)          
> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst 
> RTD|      3.499|      8.874|     61.374|       0|     0|      3.249|    109.791 
> RTD|      3.499|     13.833|    100.749|       0|     0|      3.249|    109.791 
> RTD|      3.541|     13.083|     99.249|       0|     0|      3.249|    109.791 
> ---|-----------|-----------|-----------|--------|------|------------------------
> RTS|      3.249|     21.458|    109.791|       0|     0|    00:00:25/00:00:25   
> root@arago:~# 

Note that if the OMAPL138 is an armv4 or armv5, you may want to enable
the FCSE in order to reduce context switch time (and latencies).


-- 
                                                                Gilles.

