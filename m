Message-ID: <51236C20.5020906@siemens.com>
Date: Tue, 19 Feb 2013 13:12:16 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com> <511DDBD5.4060505@web.de>
	<51236088.1030402@gmail.com> <51236A75.5090400@siemens.com>
In-Reply-To: <51236A75.5090400@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-19 13:05, Jan Kiszka wrote:
> On 2013-02-19 12:22, Manuel Huber wrote:
>> Thanks for your reply and sorry for the delay ;)
>> I have tried disabling the options and attached the logs. It still fails :(
>>
>> I hope it's okay to attach so many files... I can also add the config
>> files for
>> every build if that helps.
> 
> I'll try your config later, though in a different environment. If I'm
> unable to reproduce, I'll provide further instrumentation suggestions.
> 
> Gilles instrumentation confirmed that the CPU is taking a standard
> external IRQ (#23: 0x37-FIRST_EXTERNAL_VECTOR).

Wrong, it's IRQ #7: 0x37-IRQ0_VECTOR.

BTW, do you get spurious events on that IRQ line? Check your kernel log
while running a normal kernel for a while. Also have a look at
/proc/interrupts, if there are entries for #7.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

