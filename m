Message-ID: <4FC8CCC2.9010103@xenomai.org>
Date: Fri, 01 Jun 2012 16:08:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ9tDsgAYo1dJOc7CxoAEnLLkFqnQBL8QbO8Wb=K2yY4wg@mail.gmail.com>	<4FC86B6E.6050705@xenomai.org>
	<CAM1yFZ-KEO3Z7K+YXDBZdZExrYe3jffd6jfS-FM7W=8Zu2jdsA@mail.gmail.com>
In-Reply-To: <CAM1yFZ-KEO3Z7K+YXDBZdZExrYe3jffd6jfS-FM7W=8Zu2jdsA@mail.gmail.com>
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
Cc: Xenomai <xenomai@xenomai.org>

On 06/01/2012 10:39 AM, Anisha Kaul wrote:
> On 1 June 2012 12:42, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> 
>> I am a bit surprised that given the time you have spent been asking questions on
>> this list you still have not built and run Xenomai.
> 
> I did install Xenomai quite a time back, even ran "hello world" and
> xeno-test on it, but with a different kernel version.
> Then I had to format the harddisk and all over again.
> Now, I don't know why I am having a hard time configuring the things
> on this new kernel. :(
> 
>> Forgot that:
>> $ find linux -name '*Kconfig*' | xargs grep 'config \(APM$\|CPU_FREQ$\|ACPI_PROCESSOR$\)'
>> linux/drivers/cpufreq/Kconfig:config CPU_FREQ
>> linux/drivers/acpi/Kconfig:config ACPI_PROCESSOR
>> linux/arch/x86/Kconfig:menuconfig APM
> 
> Thankful to you for the hint.
> The problem was that I am configuring the kernel through the "make
> menuconfig" command.
> That command presents a "GUI". The APM option is simply not visible in
> that GUI. I looked again.

The GUI has a "research" function. I believe in make menuconfig it is
the '/' character.

> 
> Now, I'll figure out the modification of those Kconfig files directly.

The Kconfig are the data used by make menuconfig to build the menu. You
do not want to modify them.

This said, this list may not be the best place to ask questions about
configuration/compilation of the Linux kernel.

Please no private mails.

-- 
					    Gilles.

