References: <E1b6BNz-0003TC-QN@sd-51317.xenomai.org>
 <20160614155740.GE23680@hermes.click-hack.org> <57602CA7.5050108@siemens.com>
 <20160614170443.GH23680@hermes.click-hack.org> <57603EB6.9040605@siemens.com>
 <20160614184022.GI23680@hermes.click-hack.org> <57605662.9060106@siemens.com>
 <20160614192438.GJ23680@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <57605E4D.5090001@siemens.com>
Date: Tue, 14 Jun 2016 21:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <20160614192438.GJ23680@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/kernel: Allow to
 restart clock_nanosleep and select after signal processing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2016-06-14 21:24, Gilles Chanteperdrix wrote:
> On Tue, Jun 14, 2016 at 09:09:22PM +0200, Jan Kiszka wrote:
>>> This, of course, means an ABI change, so would only go in 3.1.x, but
>>> is not changing the behaviour of nanosleep with signals an ABI
>>> change already?
>>
>> An ABI fix - to comply with POSIX again.
> 
> The point is: if an application relies on the current behaviour, we
> are breaking it, and this should not happen in the current stable
> branch.

If an application relies on a POSIX violation, primarily while that
application is being debugged or otherwise externally stopped? Err, well...

Anyway, I don't mind that much if it goes to stable, helping people with
gdb, or if we keep it here until we move on to 3.1.

> 
>>>>> consequences with that. Also the case you handle is a corner case,
>>>>> and with your patch, handling that corner case ends-up taking the
>>>>> majority of the nanosleep code. And finally, maybe some changes
>>>>> could be moved in the I-pipe patch, if that helps (reading the
>>>>> commit message, I believe it could help).
>>>>>
>>>>> So, all and all, I do not think this patch is acceptable as is.
>>>>>
>>>>
>>>> Again, I'm open for better, concrete, less invasive, whatever design
>>>> proposals.
>>>>
>>>> The code solves a generic problem that we share with Linux in a way that
>>>> is very similar to Linux, even reuses a lot of Linux so that our I-pipe
>>>> patch doesn't grow, and that even per arch. It may not look very
>>>> friendly, but neither does the Linux code.
>>>
>>> For such a core, generic feature as syscall restarting, I see no
>>> problem with moving some stuff to the I-pipe patch.
>>
>> I do: patch maintenance.
> 
> Well ok, but having almost the same code that does almost the same
> thing but not really in two different syscalls can be a pain to
> maintain too.

There are subtle differences (even less than under Linux), and it's only
two syscalls with a pretty high probability that they won't get more
(see Linux).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

