Message-ID: <51EA4E3F.2070006@xenomai.org>
Date: Sat, 20 Jul 2013 10:45:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <C83BFA2D-B71C-4494-B6F8-931A2F0EE44E@imag.fr>
	<51EA4243.4020904@web.de> <51EA4AF7.2060008@xenomai.org>
	<51EA4CAA.4040605@web.de>
In-Reply-To: <51EA4CAA.4040605@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] shielding fully CPU or CORE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Skander Bahloul <skander.bahloul@imag.fr>, xenomai@xenomai.org

On 07/20/2013 10:39 AM, Jan Kiszka wrote:

> On 2013-07-20 10:31, Gilles Chanteperdrix wrote:
>> On 07/20/2013 09:54 AM, Jan Kiszka wrote:
>>
>>> On 2013-07-19 11:17, Skander Bahloul wrote:
>>>> Dear Xenomai list members,
>>>>
>>>> On a successful instal (but without NVIDIA driver, cf my previous
>>>> message), I am now starting using Xenomai.
>>>>
>>>> We need to :
>>>> 1* shield fully a CPU or core, against the scheduler, interruption, etc
>>>> 2* run a single thread on this isolated CPU or core
>>>>
>>>> Step 2 is OK with the Xenomai API.
>>>> But how should I achieve step 1 ?
>>>>
>>>> I did not find advice in the Xenomai documentation.
>>>> I guess it should be done with :
>>>>      $ sudo shield -a 0-3 -m -1
>>>>
>>>> Do you agree ?
>>>> When may I find detailed info on CPU shielding ?
>>>
>>> With "shield fully", do you mean 99,9...% or true 100%? The latter is
>>> not possible with current Linux kernels, thus also not with Xenomai. For
>>> the former, try kernel parameter isocpus (to keep Linux off certain
>>> cores), possibly in combination with xeno_hal.rthal_supported_cpus (to
>>> limit Xenomai to those cores).
>>
>>
>> Maybe a stupid idea, but can we not shutdown linux cpus, using cpu
>> hotplug, so as to have full isolation?
>
> We can, but we will also have to
>   - reboot those CPUs
>   - handle switches to Linux on the isolated cores (e.g. by migrating
>     the task to a Linux core)
>   - handle changes to the mm that is in use on isolated cores (TLB
>     shotdowns)
>   - handle Linux signals sent to Xenomai tasks on isolated cores

 >

> And there might be more subtle traps when using a core under Xenomai
> that is offline for Linux. Nothing is impossible, but this is surely not
> straightforward.


Indeed, it was a stupid idea.

-- 
                                                                 Gilles.

