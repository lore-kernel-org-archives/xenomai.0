Message-ID: <479774E9.3080405@domain.hid>
Date: Wed, 23 Jan 2008 18:10:01 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C41017466AD@Alpha1>
In-Reply-To: <BF58A8AFB316514587D61EADBFBF4C41017466AD@Alpha1>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] x86_64 user/system process accounting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kyle Howell <khowell@domain.hid>
Cc: xenomai@xenomai.org

Kyle Howell wrote:
>> Jan Kiszka wrote:
>>> Kyle Howell wrote:
>>>>> Kyle Howell wrote:
>>>>>> I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an
>>>>> x86_64 (Core2)
>>>>>> system. I'm finding that all of my CPU cycles are being accounted
> 
>>>>>> as kernel time rather than user time. The correct processes are 
>>>>>> still billed, but the system is always 0% user. I'm wondering if
>>>>> this problem
>>>>>> is specific to my setup, or if it is a real bug. Can anyone else 
>>>>>> out there running x86_64 confirm or deny this behavior?
>> I currently have my fingers on a box with 2.6.23.14 with 
>> Xenomai 2.4.1 and I-pipe 1.4-01 (all standard), but I'm not 
>> able to reproduce your effect. Some simple shell loop nicely 
>> loads one CPU at 100%, and /proc/stat looks like this:
>>
>> cpu  38794 0 6325 411304 2882 0 3265 0
>> cpu0 34786 0 3094 189892 413 0 2716 0
>> cpu1 4007 0 3231 221411 2468 0 548 0
> 
> Well, I'm not sure whether to be happy or sad. Thanks for checking. 
> 
>> Could you send me your full .config?
> 
> I've attached my latest .config.

That one makes the difference: it's reproducible on some test box! /me
has to find the magic switch now...

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

