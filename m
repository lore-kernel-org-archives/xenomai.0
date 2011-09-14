Message-ID: <4E70E940.5010500@domain.hid>
Date: Wed, 14 Sep 2011 19:49:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDms-kVpt6hk7adH880tK5xJL2=D9Y=M25Cn-0hBDueuUfQ@mail.gmail.com>	<4E70A876.3020009@domain.hid>
	<CAAvA3H--++6D4MhP-EOcdV7mW8Dwje+OzhxRYxeNaPJY0d4ffA@mail.gmail.com>
In-Reply-To: <CAAvA3H--++6D4MhP-EOcdV7mW8Dwje+OzhxRYxeNaPJY0d4ffA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] multicore: reserving core(s) for Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

On 09/14/2011 05:00 PM, Jeff Weber wrote:
> On Wed, Sep 14, 2011 at 8:13 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 09/14/2011 02:18 PM, Henri Roosen wrote:
>> [snip]
>>>
>>> What I would like to do is to run the Xenomai realtime threads on one
>>> core of the multi-core CPU. And I would like to reserve this core only
>>> for the Xenomai realtime threads.
>>>
>> [snip]
>> The kernel has an "isolcpus" option, which allows to specify which cpus
>> should not be used by Linux.
>>
>> See Documentation/kernel-parameters.txt in the linux kernel sources for
>> an explanation.
>>
>>
> I tried to do this a year ago with the kernel isolcpus option, but could not
> get this to work:
> 
>> Gilles Chanteperdrix to Jeff, xenomai-help
>> Jeff  wrote:
>>> What is the best method for segregating Xenomai and Linux by CPU?  I was
>>> unable to do this cleanly using /proc/xenomai/affinity for Xenomai,
>>> together with the Linux isolcpus boot option.  Details below.
>>
>> I have no definite answer, I have not checked. What I suspect, however,
>> is that when you try and force an affinity for a Xenomai thread, it
>> tries and apply this affinity in secondary mode, i.e. as a plain Linux
>> thread. So, will fail if the target thread is not in the "isolcpus"
>> mask. In other words, a Xenomai thread can not run on a CPU where Linux
>> threads can not run.

This explanation sounds like crap: looking at the documentation, it
seems that when using the "isolcpus" option, threads can run on an
isolated cpu if they force their affinity.

-- 
                                                                Gilles.

