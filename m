Message-ID: <4E70AADF.6010201@domain.hid>
Date: Wed, 14 Sep 2011 15:23:43 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CANKLDms-kVpt6hk7adH880tK5xJL2=D9Y=M25Cn-0hBDueuUfQ@mail.gmail.com>
	<4E70A876.3020009@domain.hid>
In-Reply-To: <4E70A876.3020009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

On 2011-09-14 15:13, Gilles Chanteperdrix wrote:
> On 09/14/2011 02:18 PM, Henri Roosen wrote:
>> We'll start experiments running our Xenomai application on a
>> multi-core CPU (x86/ARM). I'm sure there are some Xenomai users who
>> already have experience with it.
>>
>> What I would like to do is to run the Xenomai realtime threads on one
>> core of the multi-core CPU. And I would like to reserve this core only
>> for the Xenomai realtime threads.
>>
>> I'm using the Native API, so I can pass the CPU affinity flags for the
>> Xenomai threads during task creation/shadow. But how can I make sure
>> other threads will not make use of the same processor? I cannot call
>> taskset for every task that is spawned... right?
>>
>> Are there any idea's on how this configuration could be made easier?
>> It would be nice if there was a kernel config option to reserve
>> core(s) for Xenomai that Linux will not use.
>>
>> Any ideas and help are welcome!
> 
> The kernel has an "isolcpus" option, which allows to specify which cpus
> should not be used by Linux.

...or cgroups. isolcpus is much simpler to set up, but less strict (any
process tuning its affinity is able to circumvent this, but not cgroup
isolations).

> 
> See Documentation/kernel-parameters.txt in the linux kernel sources for
> an explanation.

...but be warned that there is no 100% isolation. Quite a few Linux
kernel threads and IPIs are required to continue hitting any online CPU.
Things are improving to reduce those noise Linux-wise, but there is no
100% in sight yet.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

