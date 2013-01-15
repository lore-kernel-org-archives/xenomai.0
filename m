Message-ID: <50F560B5.5020409@siemens.com>
Date: Tue, 15 Jan 2013 14:59:17 +0100
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
In-Reply-To: <50F55E22.9030308@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: Xenomai <xenomai@xenomai.org>

On 2013-01-15 14:48, Jan Kiszka wrote:
> On 2013-01-15 14:44, Philippe Gerum wrote:
>> On 01/15/2013 01:21 PM, Jan Kiszka wrote:
>>> On 2013-01-15 13:09, Philippe Gerum wrote:
>>>> On 01/15/2013 01:06 PM, Gilles Chanteperdrix wrote:
>>>>> On 01/15/2013 12:35 PM, Jan Kiszka wrote:
>>>>>
>>>>>> On 2013-01-14 21:39, Gilles Chanteperdrix wrote:
>>>>>>> Done, also note that my current work is the for-core-3.5.7 branch, not
>>>>>>> the for-core-3.5 branch.
>>>>>>
>>>>>> Both branches point to the same commit ATM. I suppose you didn't push
>>>>>> the new for-core-3.5.7 version yet. Once done, I'll rebase my stuff on top.
>>>>>
>>>>>
>>>>> Sorry, pushed.
>>>>>
>>>>
>>>> Please everybody, make sure to eventually resync with my tree, this is
>>>> becoming a mess when merging your stuff here. TIA,
>>>
>>> I'm fetching from you regularly, but your public tree contains no
>>> changes for 3.5, sorry.
>>>
>>
>> You must mean no change for 3.5.3 since the last stable pipeline release 
>> I pushed out. I'm seeing several breakages when merging the very latest 
>> work, I'm solving this with Gilles.
> 
> I mean that I have no clue what I should resolve. My branch was based on
> your core-3.5 branch, the latest publicly available version. I've just
> rebased it on top of Gilles' 3.5.7 queue - without any conflicts. So
> what are you talking about?
> 

[taking John from CC]

BTW, at this chance we may also discuss what the maintenance planes for
older core versions and for porting to newer ones are.

I could imagine backporting and testing our x86-related fixes to
core-3.4 (as it's still LTS), but I see no point in maintaining older
versions. If we manage to move forward soon, I'd move maintenance away
from 3.5 to that version once it's stable.

IOW: One stable kernel + one recent target appear reasonable to me, at
least for x86.

Jan

-- 
Siemens AG
Corporate Technology
CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux
Otto-Hahn-Ring 6
81739 Muenchen
Tel.: +49 (89) 636-40042
Fax: +49 (89) 636-45450
mailto:jan.kiszka@siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard
Cromme; Managing Board: Peter Loescher, Chairman, President and Chief
Executive Officer; Roland Busch, Brigitte Ederer, Klaus Helmrich, Joe
Kaeser, Barbara Kux, Hermann Requardt, Siegfried Russwurm, Peter Y.
Solmssen, Michael Suess; Registered offices: Berlin and Munich, Germany;
Commercial registries: Berlin  Charlottenburg, HRB 12300, Munich, HRB
6684; WEEE-Reg.-No. DE 23691322

