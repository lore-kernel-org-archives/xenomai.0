Message-ID: <52D3017F.9030304@xenomai.org>
Date: Sun, 12 Jan 2014 21:56:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52D1B083.5090709@steinkuehler.net>
In-Reply-To: <52D1B083.5090709@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] BeagleBone Xenomai Latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 01/11/2014 09:58 PM, Charles Steinkuehler wrote:
> (Starting a new thread)
> On 1/7/2014 5:13 PM, Gilles Chanteperdrix wrote:
>> On 01/07/2014 11:55 PM, Charles Steinkuehler wrote:
>>> On 1/7/2014 4:47 PM, Gilles Chanteperdrix wrote:
>>>> Is there any chance you could trigger a trace with the I-pipe 
>>>> tracer?
>>
>>> I can try...give me a while to sort through the I-pipe:Tracer wiki
>>> page (or are there better instructions?).
>>
>> Enable I-pipe tracer in kernel configuration, especially
>> IPIPE_TRACE_MCOUNT, and IPIPE_TRACE_VMALLOC.
>>
>> When the system has booted, do:
>>
>> echo 1 > /proc/ipipe/trace/enable
>> echo 1000 > /proc/ipipe/trace/back_trace_points
>>
>> Then launch latency -p 200 -f
>>
>> Run the load you usually run (for instance dohell).
>>
>> When the test is finished, do
>> cat /proc/ipipe/trace/frozen > /tmp/frozen.txt
>>
>> then post the resulting frozen.txt to this list.
>>
>> Expect the latency found by the test to be double the latency you get
>> without the I-pipe tracer.
> 
> OK, I tested a variety of kernels.  Simply enabling the ipipe trace
> options on the otherwise unchanged kernel configuration I'm using
> resulted in a system that was *EXTREMELY* slow and unresponsive, even
> before I enabled the iPipe trace.  After waiting the better part of a
> day for a GUI application to launch, I gave up on this kernel and tested
> one with the recommended performance options:
> 
> 
> Already in the BeagleBone Xenomai kernels I've been building:
>> optimize for size
>> disable CONFIG_PREEMPT
>> enable stack unwinding
>> disable root thread priority coupling (xenomai option)

The .config you attached to the mail I am answering has CONFIG_PREEMPT
enabled.
You may want to select CONFIG_PREEMPT_NONE.

I also do not really understand the trace you have attached. Are you
running other real-time tasks than the latency test? Because to get
accurate results, you should run the latency test without any other
programs using xenomai.



-- 
                                                                Gilles.

