Message-ID: <4C69BE0F.1090907@domain.hid>
Date: Tue, 17 Aug 2010 00:39:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid> <4C6932E8.7050701@domain.hid>
	<4C694AB3.8050407@domain.hid> <4C698E16.5050806@domain.hid>
In-Reply-To: <4C698E16.5050806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Theo Veenker <T.J.G.Veenker@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Theo Veenker wrote:
> On 08/16/2010 04:26 PM, Theo Veenker wrote:
>> Gilles Chanteperdrix wrote:
>>> Theo Veenker wrote:
>>>> Hi,
>>>>
>>>> I want to upgrade all our PC's from Ubuntu hardy to lucid and in the
>>>> process
>>>> I'm also going from kernel 2.6.29.5 with Xenomai 2.4.8 to kernel
>>>> 2.6.32.11
>>>> with Xenomai 2.5.3.
>>>>
>>>> I first built and tested the 2.6.32.11 kernel with 2.5.3 on my hardy
>>>> system
>>>> and all went fine. But the problem is it just doesn't run on the
>>>> lucid distro.
>>> This, I do not understand, the kernel does not need any support from the
>>> distribution for booting, how can the same kernel boot with one
>>> distribution, and not with the other? When you say the "same kernel", do
>>> you mean the exact same zImage or bzImage, or do you mean the kernel
>>> with the same configuration, but with a different compiler, or only the
>>> version is identical?
>>>
>> It is a complete mystery to me either. I compiled my kernel into a deb
>> package
>> and installed the very same deb package on three machines:
>> MSI p45 neo3 with Hardy on it -> works OK
>> MSI p45 neo3 with Ludid on it -> nothing (works fine with regular kernel)
>> MSI 945P with Lucid on it: -> nothing (works fine with regular kernel)
>>
>> I'll try the suggestions posted and keep you informed.
> 
> OK. Connected a terminal to catch early kernel messages. Still no output
> unfortunately (with the regular kernel I do get output on the terminal,
> so the connection works).
> 
> Meanwhile also built and tested kernel 2.6.32.15 + xenomai 2.5.4. Still nothing.
> I'm clueless. I'm running Xenomai for years on dozens of systems and I've
> never run into problems like this. I think I'll have to sit down and take a
> close look at what I'm doing. I've always built my kernels using make-kpkg,
> maybe that somehow introduces a problem here. I'll try without it.
> 
> (unfortunately/luckily I have to work from home for a few days so I can't
> get to the test system until later this week)

I had a look at your configuration, it has tracing, profiling and perf
enabled. Could you try disabling them? I do not think this could matter,
but who knows...

-- 
					    Gilles.

