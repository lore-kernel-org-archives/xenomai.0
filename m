Message-ID: <546344E2.1050502@xenomai.org>
Date: Wed, 12 Nov 2014 12:30:42 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54631EB1.1050900@sigmatek.at> <546323F9.9040608@xenomai.org>
 <5463264B.3090503@sigmatek.at> <54632D7C.5020409@xenomai.org>
 <54633C3D.1090503@sigmatek.at>
In-Reply-To: <54633C3D.1090503@sigmatek.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_nrtsig_pend FAQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at, xenomai@xenomai.org

On 11/12/2014 11:53 AM, Johann Obermayr wrote:
> Am 12.11.2014 um 10:50 schrieb Philippe Gerum:
>> On 11/12/2014 10:20 AM, Johann Obermayr wrote:
>>> Am 12.11.2014 um 10:10 schrieb Philippe Gerum:
>>>> nrt signals are based on I-pipe virtual irqs, which do not pile up:
>>>> there is a single signal pending until the irq can be delivered to the
>>>> handler, regardless of how many times it has been triggered.
>>> i know, if there is a big cpu load some virtual irqs can be lost, but we
>>> have cpu load smaller that 10 percent.
>>>
>> Did you try running vmstat with a one second delay while your
>> application runs?
>>
> vmstat is not running.
> we have a own proc_create("company/lrtdrv_timing", 0, NULL, &proc_fops);
> to show
> the counters.
> 
> 

I mean that relying on the load average won't get you much information
about potential high load spikes occurring regularly, but on large
intervals. Since your reasoning seems to be based on the load average
for assuming that virqs might be lost, I would recommend to check this
assumption first. Analyzing a vmstat log would give you a finer information.

Bottom line is that either the regular kernel is starved from IRQs long
enough to make a sequence of several virq triggers appear as a single
shot, or some virqs get lost in space.

Since virqs on the root domain are no different from regular linux IRQs
with respect to the way the pipeline handles them, option #2 would also
mean that device IRQs could be lost the same way, which is not the most
likely outcome. FWIW, a quick look at the legacy pipeline code for
kernel 3.0 did not reveal any arm-specific issue that might cause a virq
trigger to be lost.

Typically, I would inspect the system status when
(wait_domain_pend_count - wait_domain_call_count) >= 1, on entry to
period_update(). For this you can trigger a pipeline trace with a
backlog large enough to find out what the regular kernel was doing prior
to being preempted by the rt activity which called period_update().

-- 
Philippe.

