Message-ID: <4C9D221F.8090001@domain.hid>
Date: Sat, 25 Sep 2010 00:11:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
	<201009242321.42954.kisda@domain.hid>
	<4C9D1713.8040608@domain.hid>
	<201009250008.04443.kisda@domain.hid>
In-Reply-To: <201009250008.04443.kisda@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] switchtest/xeon-test fails: Help needed
 (Ubuntu/Core i7)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Am Freitag 24 September 2010, 23:24:35 schrieben Sie:
>> Stefan Kisdaroczi wrote:
>>> Am Freitag 24 September 2010, 22:05:37 schrieb Gajamohan Mohanarajah:
>>>> Hi,
>>>>
>>>> 3. I am compiling the kernel using [fakeroot make-kpkg --initrd
>>>> --append-to-version=-xenomaiflv kernel-image kernel-headers
>>>> --overlay-dir=$HOME/kernel-package]. After changing just the
>>>> CONFIG_XENO_OPT_SYS_HEAPSZ via [make menuconfig], when I issue the the
>>>> above command, the kernel goes on to a full recompile which  takes 2
>>>> hours :(.
>>> Have you set CONCURRENCY_LEVEL to the numer of cores ?
>>>
>>>   [CONCURRENCY_LEVEL=8 fakeroot make-kpkg --initrd ... ... ... ]
>>>
>>> Never tried, but "-j x" should work too today:
>>>   [fakeroot make-kpkg -j 8 ... ... ...]
>> Are you sure make-kpkg does not issue a "make clean" before compiling.
> 
> It will do a "make clean" and I have no idea how to disable that. As he wrote 
> the full commandline and nothing about concurrency I just wanted to make sure 
> he knows about this option.

Then maybe we should encourage users to test kernel configurations by
using the usual kernel compilation procedure, then only switch to debian
packages when the settings are chosen?


-- 
                                                                Gilles.

