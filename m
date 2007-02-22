Message-ID: <45DDBB86.2080105@domain.hid>
Date: Thu, 22 Feb 2007 16:49:26 +0100
From: Stephan Zimmermann <s.zimmermann@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid>	<45CC68F3.1000003@domain.hid>		<45D1C033.9010002@domain.hid>	<45D1C61B.7030503@domain.hid>		<1171376742.885.3.camel@domain.hid>	<45D1CAFA.6050408@domain.hid>		<1171385716.885.17.camel@domain.hid>	<45D200C3.1030001@domain.hid>		<1171393088.885.37.camel@domain.hid>	<45D59F98.8020006@domain.hid>		<45D5E493.4080405@domain.hid>
	<45D5F0AD.9010404@domain.hid>		<1171649724.10479.12.camel@domain.hid>
	<45D5F71F.60509@domain.hid>		<1171650868.10479.21.camel@domain.hid>
	<45D5FA33.3030503@domain.hid>	<1171651639.10479.24.camel@domain.hid>
	<45DD9A4E.9070709@domain.hid> <45DD9F8E.6070708@domain.hid>
In-Reply-To: <45DD9F8E.6070708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Jan Kiszka schrieb:
> Stephan Zimmermann wrote:
>> Hm, updated my machines to 2.6.20 and 2.3.0 rev 2222. I still see ( less
>> frequent?) some backtraces occuring on my console, either during reboot
>> or sometimes when running the testprogram and reloading the modules.(see
>> dmesg snippet below) The Celeron M still crashes often totally.
>>
>> My main-application still freezes the SMP mashines if I have 'priority
>> coupling' enabled in kernel-config. Using trunk makes things even worse.
>> The pc will crash during startup of my app, the testapp I sendt you
>> works, but i can not shutdown the pc afterwards, because it freezes
>> completely when terminating kdm.
>>
>> Stephan
>>
>>
>>
>> dmesg tells me the following (2.3.0.2222, 2.6.20, SMP):
> 
> Latest I-pipe version?

Kernel was freshly patched with:

./ksrc/arch/i386/patches/adeos-ipipe-2.6.20-i386-1.7-02.patch

the one from svn rev. 2222

> 
>> --snip--
>> Bad page state in process 'kswapd0'
>> page:c17f3060 flags:0x80010408 mapping:00000000 mapcount:0 count:0
>> Trying to fix it up, but a reboot is needed
> 
> Something is corrupting kernel memory.
> 
> I did some remark on your test, let's get back to it: You are running
> the test at 100 kHz. That /may/ have side-effects like overload, or it
> might actually trigger some stack overrun. Did you enable the stack
> checks? Can you confirm the problem occurs also at slower tick rates?

Test was run at 10KHz, but stack-debugging wasn't on, I will repeat it 
and post again...

> Jan
> 


