Message-ID: <4A02D609.2010202@domain.hid>
Date: Thu, 07 May 2009 14:37:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1043994168.4085071240493189508.JavaMail.root@domain.hid>		<49F06D77.7050103@domain.hid>
	<1241695394.6157.7.camel@domain.hid> <4A02D4C2.3060009@domain.hid>
In-Reply-To: <4A02D4C2.3060009@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem of freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Raistlin <raistlin@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Gilles Chanteperdrix wrote:
> Raistlin wrote:
>> On Thu, 2009-04-23 at 15:30 +0200, Gilles Chanteperdrix wrote:
>>>> I use xenomai with the patch adeos-ipipe-2.6.28.9-x86-2.2-07.patch from the Xenomai git
>>>>
>>>> But i have the same problem :(
>> Just to make you know that I'm (still) experimenting exactly the same
>> random freeze on Ubuntu Jaunty, with 2.6.28.9 kernel,
>> adeos-ipipe-2.6.28.9... patch and xenomai-git (but I think that does not
>> matter, since it seems a kernel issue!!)
>>
>>> I see that you are using X-window, so I guess you do not see the
>>> console. Unfortunately, if your hang is due to a kernel oops we do not
>>> have a clue. So, you should try and get the console output on another
>>> machine, using preferably a serial cable, or if not possible the netconsole.
>> I'll try to setup a netconsole environment as soon possible and let you
>> know what I can see in the kernel logs.
> 
> As usual, please send us /proc/interrupts, /proc/xenomai/irq, your
> .config, and the version of the I-pipe patch you use.
> 
> Run the latency and switchtest tests, and tell us if you have the freeze
> with them too.

Also, Benoit's problem was not in fact due to xenomai but to gnome power
management. This shows that the notion of "freeze" is very vague, and
without further information, we can not tell you more.

-- 
                                                 Gilles.

