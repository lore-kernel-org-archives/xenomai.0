Message-ID: <4C061EC8.3010507@domain.hid>
Date: Wed, 02 Jun 2010 11:05:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikm9draDOStz8YfJCxtWb14pvMMfXjpMItjE8mu@domain.hid>
In-Reply-To: <AANLkTikm9draDOStz8YfJCxtWb14pvMMfXjpMItjE8mu@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Dating problem with the trivial-periodic example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Divi Oillo <divi.oillo@domain.hid>
Cc: xenomai@xenomai.org

Divi Oillo wrote:
> 
> Hi all,
> 
> I'm trying to install Xenomai-2.5.3 with Linux 2.6.31.12 on my PC
> (Pentium M Dell Latitude 810).
> First, I have disabled ACPI Processor.
> When I run the test examples/native/trivial-periodic.c. => OK
> When I stress with : "stress --cpu 1 --io 4 --vm 2 --vm-bytes 128M
> --timeout 10s" => I have 1.25s between each rt_task_wait_period(NULL);
> 
> Then , I have enabled ACPI Processor (Here is my .config).
> Kernel arg : idle=poll
> When I run the test examples/native/trivial-periodic.c. => I'm not sure
> but it seems that each time fans run the time between each wait is 1.25s.
> 
> What could I be doing wrong here? please help.

Normally, when enabling ACPI Processor, you should get a message in
Kconfig telling you that this option should not be enabled with Xenomai.
So, do not enable it.

-- 
					    Gilles.

