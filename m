Message-ID: <52F3BF00.3010405@marel.com>
Date: Thu, 6 Feb 2014 16:57:36 +0000
From: Marcel van Mierlo <marcel.vanmierlo@marel.com>
MIME-Version: 1.0
References: <52F3B77F.3020405@marel.com> <52F3B9D2.9070205@xenomai.org>
In-Reply-To: <52F3B9D2.9070205@xenomai.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] High CPU load using q_send under pSOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles, I appreciate the input:

By observation, it is 100ms (using a trace function it looks nice and 
stable):

common_io.c cio_watchdog_kick +280 036.726273s: "WAKING"
common_io.c cio_watchdog_kick +280 036.826273s: "WAKING"
common_io.c cio_watchdog_kick +280 036.926272s: "WAKING"
common_io.c cio_watchdog_kick +280 037.026272s: "WAKING"
common_io.c cio_watchdog_kick +280 037.126272s: "WAKING"

so I am confident it is running at 100ms. The pSOS documentation refers 
to kc_ticks2sec to verify frequency, but I am not sure where to look 
under Xenomai to double check...not sure if this is relevant from 
.config, but anyway the trace comes every 100ms.

/CONFIG_XENO_OPT_TIMING_VIRTICK/=1000.

Marcel.


On 06/02/14 16:35, Gilles Chanteperdrix wrote:
> On 02/06/2014 05:25 PM, Marcel van Mierlo wrote:
>> Hi,
>>
>> I've been investigating this for a couple of days and would really
>> appreciate some insight
>> on what might be going on or what I can do to progress this...
>>
>> I am porting a legacy pSOS application - to Xenomai on BeagleBoard Black
>> 3.8 kernel
>> and have noticed %CPU (via. top) of MAIN around 40% when using q_send,
>> and doing no "work".
>>
>> Surprisingly,  if I add a printf() and fflush() to the task body then
>> the CPU drops down to < 1%.
>>
>> I've checked compile options, nothing obviously wrong. Here is the
>> (abridged) body of the task.
>> It just provides a periodic message for watchdog purposes.
>>
>>
>> [%CPU ~%40]
>> while{1}
>> {
>>       q_send(ulCanTQid, (INT32 *)&oCanMsg);
>>       tm_wkafter(100);  // ~100ms
>
> Have you checked that the comment is right? Are you sure you are not 
> sleeping 100ns ?
>

