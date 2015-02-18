Message-ID: <54E4D835.1040204@siemens.com>
Date: Wed, 18 Feb 2015 19:21:41 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54E4D14E.1060104@siemens.com>
 <20150218175507.GD30317@hermes.click-hack.org> <54E4D61B.1020006@siemens.com>
 <20150218181334.GE30317@hermes.click-hack.org>
In-Reply-To: <20150218181334.GE30317@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] arm: Late delivery of pending Linux signals?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-02-18 19:13, Gilles Chanteperdrix wrote:
> On Wed, Feb 18, 2015 at 07:12:43PM +0100, Jan Kiszka wrote:
>> On 2015-02-18 18:55, Gilles Chanteperdrix wrote:
>>> On Wed, Feb 18, 2015 at 06:52:14PM +0100, Jan Kiszka wrote:
>>>> Hi Gilles,
>>>>
>>>> I noticed on ARM (AM335 TI board) that the SIGDEBUG if the related test
>>>> apparently only gets delivered to the receiver after it invokes a
>>>> syscall, not on return from its secondary mode migration. Therefore the
>>>> page fault test of the sigdebug smokey test fails (tested with Xenomai
>>>> 3), and I bet the watchdog test as well. Is this a known limitation?
>>>
>>> Xenomai 2.6 sigdebug works fine on omap3 (very near from an
>>
>> Will try 2.6 next.
>>
>>> arm33xx). That being said, the AM3xx port is not part of the main
>>> line I-pipe, and based on a non mainline kernel, so it is difficult
>>> for me to answer this question.
>>
>> Then I'm possibly not building all recommended bits - I'm on 3.14 I-pipe
>> upstream. That seems to work fine in general. Which version are you
>> referring to?
> 
> The one documented in arm/patches/README

https://github.com/RobertCNelson/linux-dev/commits/am33x-v3.8? There is
nothing explicitly stated regarding the AM3xx board, just that reference
in the context of the Beaglebone.

Anyway, I thought that syscall and exception handling should not be
dependent on board patches, should they?

BTW, do you have recommended QEMU setup? Does the vexpress work (despite
not being listed)? The integratorcp model doesn't like me, while I have
vexpress even in KVM running (but guest debugging is still worked on).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

