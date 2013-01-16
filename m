Message-ID: <50F67750.60408@siemens.com>
Date: Wed, 16 Jan 2013 10:48:00 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <50F19CE1.5080106@zultron.com> <50F19DE4.4030805@xenomai.org>
	<50F239E1.40400@zultron.com> <50F2A59D.5050600@xenomai.org>
	<50F30781.3050302@zultron.com> <50F30DE5.7030007@xenomai.org>
	<50F3F36A.8050804@siemens.com> <50F45358.1020601@xenomai.org>
	<50F458E9.7080504@siemens.com> <50F4594C.8090907@xenomai.org>
	<50F45E87.9030701@siemens.com> <50F46D0E.9000706@xenomai.org>
	<50F53F0E.7020604@siemens.com> <50F54641.3010802@xenomai.org>
	<50F546E8.2050606@xenomai.org> <50F549AD.7040508@siemens.com>
	<50F55D33.3020205@xenomai.org> <50F55E22.9030308@siemens.com>
	<50F56074.50203@xenomai.org> <50F5B08D.60504@xenomai.org>
	<50F65EB3.1000301@siemens.com> <50F6687C.7040809@siemens.com>
	<50F675C8.1060009@xenomai.org>
In-Reply-To: <50F675C8.1060009@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 3.5.7 "I-pipe: could not find timer" (Was: Re: Kernel
 OOPS during regression tests)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: John Morris <john@zultron.com>, Xenomai <xenomai@xenomai.org>

On 2013-01-16 10:41, Philippe Gerum wrote:
> On 01/16/2013 09:44 AM, Jan Kiszka wrote:
>> On 2013-01-16 09:02, Jan Kiszka wrote:
>>> At the same time, upstream should not pull or pick in
>>> a way that makes life harder for downstream.
>>
>> Philippe, in the future, please keep your public tree up-to-date,
>> ideally at a daily base. I'm seeing commits there that were done locally
>> more than a week ago. Only publishing your state will avoid the problems
>> you faced with integrating our changes.
> 
> No. If I don't publish, there must be a reason.

This approach doesn't work very well - to state it carefully. Push you
stuff at least into a public "next" branch, one that may be rebased /
reordered without warning. That allows us to prepare for what is under
test, maybe pick up arch-specific changes into the subsystem queues. And
don't complain about conflict if you cherry-pick subsystem patches
without dropping a note to the author - or was Gilles aware of your
private queue?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

