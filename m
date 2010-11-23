Message-ID: <4CEC47C9.9000604@domain.hid>
Date: Wed, 24 Nov 2010 00:01:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTiny-NB-R4ELThQ0HE3LALz03cvcNuamnsa2kqiC@mail.gmail.com>	<4CEC17DD.6050004@domain.hid>	<AANLkTikDwEO-g9KvgBMXoccO1RAWtDcscekUEH+UpwFE@mail.gmail.com>	<4CEC42D4.5010009@domain.hid>
	<AANLkTikQLek06L7xhBLKq3xQwcuOb=km3rNQAJ3zKsLw@domain.hid>
In-Reply-To: <AANLkTikQLek06L7xhBLKq3xQwcuOb=km3rNQAJ3zKsLw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai installation on archlinux
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: tadele shiferaw <metitad@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

tadele shiferaw wrote:
> Here is my config file and I am using a pentium dual core 32 bit processor.

There is no such thing as dual core pentium. And you selected pentium
pro. If you avec a Core 2 duo, please select "CONFIG_MCORE2", instead of
a ten years old processor model. When that is done, you will no longer
need "CONFIG_X86_GENERIC". That is what the first paragraph on the page
I sent you asks you to do.

You should also disable all the CPUFREQ stuff (not only
CONFIG_CPU_FREQ), CONFIG_CPU_IDLE, and CONFIG_CC_STACKPROTECTOR.

The next private message will receive no answer.

-- 
                                                                Gilles.

