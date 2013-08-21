Message-ID: <5214AA25.5070500@siemens.com>
Date: Wed, 21 Aug 2013 13:53:09 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <52147CD7.70400@siemens.com> <52147DF2.8060407@xenomai.org>
	<52147E94.6070309@siemens.com> <5214802B.9060001@siemens.com>
	<5214A55E.2070902@xenomai.org> <5214A886.30608@siemens.com>
	<5214A941.6070302@xenomai.org>
In-Reply-To: <5214A941.6070302@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [RFC] x86 port to kernel 3.10
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-08-21 13:49, Gilles Chanteperdrix wrote:
> On 08/21/2013 01:46 PM, Jan Kiszka wrote:
>> On 2013-08-21 13:32, Gilles Chanteperdrix wrote:
>>> On 08/21/2013 10:54 AM, Jan Kiszka wrote:
>>>> On 2013-08-21 10:47, Jan Kiszka wrote:
>>>>> On 2013-08-21 10:44, Gilles Chanteperdrix wrote:
>>>>>> On 08/21/2013 10:39 AM, Jan Kiszka wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> in the process of updating our kernel support to current (and long-term)
>>>>>>> stable 3.10, I've pushed the I-pipe master tree to that version. The
>>>>>>> tree is available at
>>>>>>>
>>>>>>> git://git.xenomai.org/ipipe-jki.git next-x86
>>>>>>>
>>>>>>> Though the focus is on x86, this became a full merge, ie. I also tried
>>>>>>> to resolve ARM and PowerPC conflicts (other archs had none). But I'm
>>>>>>> sure I broke some things (or things were already broken after the 3.9
>>>>>>> merge - there were suspicious unresolved conflicts). So these arch need
>>>>>>> a careful check! Specifically watch out for merges that resolved
>>>>>>> conflicts in their trees.
>>>>>>>
>>>>>>
>>>>>> I would prefer to have the conflict markers in the git tree, so that we
>>>>>> know where the conflicts occur. Having to browse history to find all the
>>>>>> merge conflicts seems more complicated than greping for '>>>'. Of
>>>>>> course, it means that when all the conflicts are resolved, the kernel
>>>>>> should be rebased to remove the commits with the merge conflicts, so as
>>>>>> to keep a bisectable kernel.
>>>>>
>>>>> As you cannot rebase merges (without losing history), this is not really
>>>>> applicable. I can leave in conflicts that affect ARM or Power, sure, but
>>>>> then the fix-ups will have to happen on top, taking away bisectability.
>>>>
>>>> Hmm, what we would really need is some tool to replay merges with their
>>>> conflict resolution. That must be feasible, somehow...
>>>
>>> You mean like git rerere? Anyway, why not just one big commit with all
>>> the conflicts?
>>
>> For the reason given in my original message.
> 
> The mail explains the how, but not the why. Having to skim through tens
> of commits to find which ones may be related to a particular arch is
> simply a major pain. The "old" method which was to merge the patch with
> all the changes was much simpler. So, I do not see what we gain with the
> new method if it makes things more complicated.

"The advantage of this pattern is that we get more bisection points in
case something subtly breaks between 3.8 and 3.10."

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

