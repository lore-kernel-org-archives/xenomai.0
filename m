Message-ID: <51113539.1070700@xenomai.org>
Date: Tue, 05 Feb 2013 17:37:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAFv1zn7-zGPw71e4fFJAdf9FodKskesq1NRXooY4AOZ0Bojo5g@mail.gmail.com>
In-Reply-To: <CAFv1zn7-zGPw71e4fFJAdf9FodKskesq1NRXooY4AOZ0Bojo5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] PandaBoard related issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: RAGHAVENDRA GANIGA <ravi23ganiga@gmail.com>
Cc: xenomai@xenomai.org

On 02/05/2013 02:17 PM, RAGHAVENDRA GANIGA wrote:

> Sir i have compiled the linux 3.5.7 with xenomai 2.6.2.1 using
> toolchain arm-none-linux-gnueabi from codesourcery and we were
> testing the code which i have attached with the mail the non real
> time tasks are working properly but the real time tasks are
> giving some unexpected results like the code which i have attached
> , in that when i execute the code the task gets registered in
> /proc/xenomai/sched but there is no output from the tasks routine
> like the first thing it should print is "in real time task" but
> it is not printing, i have also attached the dmesg and the latency
> test result from user space and kernel space.


I could reproduce this issue. I am working on it (it seems to happen
only on panda, when the kernel is compiled with CONFIG_SMP, so, I would
bet on an IPI issue).

-- 
                                                                Gilles.

