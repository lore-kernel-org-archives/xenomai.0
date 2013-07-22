Message-ID: <51ECE69D.4090008@bollue.de>
Date: Mon, 22 Jul 2013 10:00:29 +0200
From: Kai Bollue <mlist1@bollue.de>
MIME-Version: 1.0
References: <C83BFA2D-B71C-4494-B6F8-931A2F0EE44E@imag.fr>
	<51EA4243.4020904@web.de>
In-Reply-To: <51EA4243.4020904@web.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: xenomai@xenomai.org

On 20.07.2013 09:54, Jan Kiszka wrote:
> On 2013-07-19 11:17, Skander Bahloul wrote:
>> Dear Xenomai list members,
>>
>> On a successful instal (but without NVIDIA driver, cf my previous message), I am now starting using Xenomai.
>>
>> We need to :
>> 1* shield fully a CPU or core, against the scheduler, interruption, etc
>> 2* run a single thread on this isolated CPU or core
>>
>> Step 2 is OK with the Xenomai API.
>> But how should I achieve step 1 ?
>>
>> I did not find advice in the Xenomai documentation.
>> I guess it should be done with :
>> 	$ sudo shield -a 0-3 -m -1
>>
>> Do you agree ?
>> When may I find detailed info on CPU shielding ?
> With "shield fully", do you mean 99,9...% or true 100%? The latter is
> not possible with current Linux kernels, thus also not with Xenomai. For
> the former, try kernel parameter isocpus (to keep Linux off certain
> cores), possibly in combination with xeno_hal.rthal_supported_cpus (to
> limit Xenomai to those cores).

If you use an AMD CPU with "Bulldozer" / "Piledriver" architecture, for 
better latencies, it helps to keep Linux off of both cores on one 
module, as they share certain ressources. E.g. use isolcpus=0,1 and bind 
your Xenomai task to CPU0.


Regards,
Kai

