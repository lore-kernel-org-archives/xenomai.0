Message-ID: <55772F6D.9090509@siemens.com>
Date: Tue, 09 Jun 2015 20:24:45 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CAJqUr7yMDB5eWEeKAPRVRNfX+GLXLdYeT9divj3Co_hd-u3ghw@mail.gmail.com>
 <CAJqUr7wNkKZAZzMWz6K4+ydBPiRyoWNZtA713WZLEehhUzNYig@mail.gmail.com>
In-Reply-To: <CAJqUr7wNkKZAZzMWz6K4+ydBPiRyoWNZtA713WZLEehhUzNYig@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] infinite loop/oops on cat /proc/xenomai/sched/stats
 when online cpus > present cpus
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Don Mahurin <don@mperpetuo.com>, xenomai@xenomai.org

On 2015-06-05 17:30, Don Mahurin wrote:
> On Thu, Jun 4, 2015 at 5:06 PM, Don Mahurin <don@mperpetuo.com> wrote:
> 
>> In the function xnintr_query_next in kernel/cobalt/intr.c,
>>
>> The iterator proceeds to the next entry when the next cpu is nr_cpus.
>> where nr_cpus is set to num_online_cpus().
>>
>> if (cpu + 1 == nr_cpus)
>>   iterator->prev = intr;
>> But if there are more cpus present than online, for the case for a timer
>> irq, this condition is never reached, as the following will cause cpu to be
>> reset to 0 if they are at the end of the list.
>>
>> for (cpu = iterator->cpu + 1; cpu < nr_cpus; ++cpu) {
>>   if (cpu_online(cpu))
>>     break;
>> }
>> if (cpu == nr_cpus)
>>    cpu = 0;
>> In our case, we have 8 cpus present, and 4 online.
>>
>> For a timer irq, this will loop 0,1,2,3 repeatedly for the same irq.
>>
>> Can we safely replace 'num_present_cpus' with 'num_online_cpus'?
>>
>> Or do we need another way of detecting the last online cpu for the next
>> entry?
>>
>>
> The attached patch is an alternate fix.  This skips past offline cpus when
> detecting last cpu, making no assumptions of the order of online/offline
> cpu's.

Note that Xenomai does not support hotplug for CPUs that are included in
its supported_cpus set. You have to exclude those CPUs by setting
xenomai.supported_cpus during boot accordingly. That should also resolve
the issue you have seen. Can you confirm this?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

