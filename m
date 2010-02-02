Message-ID: <4B68530A.10804@domain.hid>
Date: Tue, 02 Feb 2010 17:30:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <729916.37479.qm@domain.hid>	<1265127687.3317.61.camel@domain.hid>
	<4B685262.9070606@domain.hid>
In-Reply-To: <4B685262.9070606@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with Xeno-test: "Something died a XXX or"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Brian Zenowich <bz@domain.hid>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Brian Zenowich wrote:
>> Hello,
>>
>>> I try to install Xenomai on Ubunut Hardy 8.04. Versions used are:
>>> - xenomai-2.4.6.1
>>> - linux-kernel 2-6.24.6 
>>> - adeos patch: adeos-ipipe-2.6.24-x86-2.0-07.patch
>>>
>>> I tried many .config files but it is always the same problem with
>>> Xeno-test. It seems that there is a problem with the "generate load"
>>> part of the script.
>>> Attached, are two files. One is xeno-test without modifying it. The
>>> other is xeno-test results but with the "generate load'" part removed.
>>>
>>> Latency (in user space and kernel) seem to be great. Around 7 us in
>>> user-space and 4 us in kernel for worst case.
>> I know this thread is a year old now, but there was never a solution
>> posted. I ran into the same problem a few months ago, solved it, ran
>> into it again yesterday, and forgot how I solved it before.
>>
>> So, just to document the solution for posterity's sake (or for anyone
>> Googling for a solution):
>>
>> The xeno-test script fails with "something died a <xxxx>" when it is run
>> under the dash shell for me. The xeno-test script specifies "/bin/sh" as
>> a shell, and under my distro (Ubuntu 9.10 now), /bin/sh => dash, not
>> bash. The dash shell is designed to be a fast, efficient,
>> non-interactive shell mainly for running scripts, and therefore has a
>> limited feature set when compared with bash. 
>>
>> It seems dash is not able to handle whatever xeno-test is asking it to
>> do at that moment. But the xeno-test script works fine (for me) when run
>> with "bash xeno-test".
> 
> That is not a good solution. bash is not available on embedded platform.
> The real platform is to fix the script to run with dash. And it is far

I meant: "the real solution".

-- 
					    Gilles.

