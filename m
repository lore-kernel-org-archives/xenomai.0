Message-ID: <4FC86C79.9050507@xenomai.org>
Date: Fri, 01 Jun 2012 09:17:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ9tDsgAYo1dJOc7CxoAEnLLkFqnQBL8QbO8Wb=K2yY4wg@mail.gmail.com>
	<4FC86B6E.6050705@xenomai.org>
In-Reply-To: <4FC86B6E.6050705@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] CONFIG_CPU_FREQ, CONFIG_APM. kernel - 2.6.38.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anisha Kaul <born.rebel.83@gmail.com>
Cc: xenomai@xenomai.org

On 06/01/2012 09:12 AM, Gilles Chanteperdrix wrote:
> On 06/01/2012 07:54 AM, Anisha Kaul wrote:
>> Greetings,
>>
>> W.r.t kernel - 2.6.38.8
>>
>> This page http://www.xenomai.org/documentation/xenomai-2.6/TROUBLESHOOTING
>> asks us to disable "CONFIG_CPU_FREQ".
>>
>> (...)
>>   Has some names been changed or I am simply missing some point?
>>   Please guide.
> 
> No, all the options are still there in linux 2.6.38.8. I am a bit
> surprised that given the time you have spent been asking questions on
> this list you still have not built and run Xenomai.
> 
> The real hard part of the job using Xenomai is to start writing
> applications using it and debugging them, not installing, compiling and
> configuring it.
> 

Forgot that:

$ find linux -name '*Kconfig*' | xargs grep 'config \(APM$\|CPU_FREQ$\|ACPI_PROCESSOR$\)'
linux/drivers/cpufreq/Kconfig:config CPU_FREQ
linux/drivers/acpi/Kconfig:config ACPI_PROCESSOR
linux/arch/x86/Kconfig:menuconfig APM

-- 
                                                                Gilles.

