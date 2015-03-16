Message-ID: <5507329D.1040907@siemens.com>
Date: Mon, 16 Mar 2015 20:44:29 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <55005580.6050702@siemens.com> <5506EC14.9070302@xenomai.org>
 <5506F73B.5020103@siemens.com> <5506FE23.60408@siemens.com>
 <55070020.70002@xenomai.org> <550707E7.1000107@siemens.com>
 <55070FE3.9050803@siemens.com> <55072DDE.1070103@xenomai.org>
 <55073099.9000208@siemens.com> <550731D5.1090706@xenomai.org>
In-Reply-To: <550731D5.1090706@xenomai.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3: smokey test sched_tp causes oops when run
	in gdb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 2015-03-16 20:41, Philippe Gerum wrote:
> On 03/16/2015 08:35 PM, Jan Kiszka wrote:
>> On 2015-03-16 20:24, Philippe Gerum wrote:
>>> On 03/16/2015 06:16 PM, Jan Kiszka wrote:
>>>> Don't understand the reason for this multiple calls in details yet, but
>>>> you can also trigger the bug by invoking pthread_setschedparam_ex twice
>>>> in smokey's sched-tp.c. Fix pushed to for-forge.
>>>>
>>>
>>> This is what has to be fixed, because guarding would only paper over the
>>> issue for TP, but the latter would bite the same way with other existing
>>> or future policies.
>>
>> You mean push the guard into xnsched_set_policy, e.g.?
>>
> 
> Or fix what might be a signal restart issue so that we don't end up
> twice in xnsched_set_policy().

Again, already calling pthread_setschedparam_ex twice in a row on the
same thread triggers the bug. There is no way around such a guard.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

