References: <20160628092955.GL18662@hermes.click-hack.org>
 <577248AB.5070601@sigmatek.at> <20160628095543.GM18662@hermes.click-hack.org>
 <57724CFE.2050401@sigmatek.at> <20160628101957.GO18662@hermes.click-hack.org>
 <5772520E.8010407@sigmatek.at> <20160628103925.GP18662@hermes.click-hack.org>
 <577265AF.9080300@sigmatek.at> <20160628120119.GT18662@hermes.click-hack.org>
 <57728A71.6010205@sigmatek.at> <20160628144159.GZ18662@hermes.click-hack.org>
From: Wolfgang Netbal <wolfgang.netbal@sigmatek.at>
Message-ID: <5774E3C7.9090207@sigmatek.at>
Date: Thu, 30 Jun 2016 11:17:59 +0200
MIME-Version: 1.0
In-Reply-To: <20160628144159.GZ18662@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Performance impact after switching from 2.6.2.1 to
 2.6.4
Reply-To: wolfgang.netbal@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



Am 2016-06-28 um 16:42 schrieb Gilles Chanteperdrix:
> On Tue, Jun 28, 2016 at 04:32:17PM +0200, Wolfgang Netbal wrote:
>>
>> Am 2016-06-28 um 14:01 schrieb Gilles Chanteperdrix:
>>> On Tue, Jun 28, 2016 at 01:55:27PM +0200, Wolfgang Netbal wrote:
>>>> Am 2016-06-28 um 12:39 schrieb Gilles Chanteperdrix:
>>>>> On Tue, Jun 28, 2016 at 12:31:42PM +0200, Wolfgang Netbal wrote:
>>>>>> Am 2016-06-28 um 12:19 schrieb Gilles Chanteperdrix:
>>>>>> min: 10, max: 677, avg: 10.5048 -> 0.0265273 us
>>>>>>
>>>>>> Here are the output for Kernel 3.0.43 and Xenomai 2.6.2.1
>>>>>>
>>>>>> #> ./tsc
>>>>>> min: 10, max: 667, avg: 11.5755 -> 0.029231 us
>>>>> Ok. So, first it confirms that the two configurations are running
>>>>> the processor at the same frequency. But we seem to see a pattern,
>>>>> the maxima in the case of the new kernel seems consistently higher.
>>>>> Which would suggest that there is some difference in the cache. What
>>>>> is the status of the two configurations with regard to the L2 cache
>>>>> write allocate policy?
>>>> Do you mean the configuration we checked in this request
>>>> https://xenomai.org/pipermail/xenomai/2016-June/036390.html
>>> This answer is based on a kernel message, which may happen before
>>> or after the I-pipe patch has changed the value passed to the
>>> register, so, essentially, it is useless. I would not call that
>>> checking the L2 cache configuration differences.
>>>
>> I readed the values from the auxiliary control register,
>> when the system is up and running.
>> I get the same values like I see in the Kernel log.
>>
>> Kernel 3.10.53 [0xa02104]=0x32c50000
>> Kernel 3.0.43    [0xa02104]=0x2850000
> Ok, so, if I read this correctly both values have 0x800000 set,
> which means "force no allocate", and is what we want. But there are
> a lot of other questions in my answer which you avoid to answer (and
> note that that one was only relevant in one of two cases, which I
> believe is not yours).
>
Dear Gilles,

your first intention was correct, that the L2 cache configuration may be
the reason for our issue.
I disabled the instruction and data prefetching and my customer application
is as fast as in our old kernel.
It was a change in the Kernel file arch/arm/mach-imx/system.c where the 
prefetching
was activated.

We will additional replace the function rt_timer_tsc() by __xn_rdtsc() 
as you recommended.

In our customer applications every millisecond the xenomai task with 
priority 95
is called and works on different objects that are located on different 
memory locations.
When the objects are finished we leave the xenomai domain and let work 
Linux.

Do you have any additional hints for me what configrations L2 cache or 
other that can
speed up this use case ?

Thanks a lot for you support and patience. 
<http://dict.leo.org/ende/index_de.html#/search=patience&searchLoc=0&resultOrder=basic&multiwordShowSingle=on&pos=0>

Kind regards
Wolfgang


