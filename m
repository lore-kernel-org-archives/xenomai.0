Message-ID: <51B74AEE.5050706@xenomai.org>
Date: Tue, 11 Jun 2013 18:06:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51A30F04.701@xenomai.org> <51A39043.5010609@xenomai.org>
	<51B70BF0.9040904@siemens.com> <51B724A9.4040307@xenomai.org>
	<51B726CE.2010201@siemens.com> <51B72DBD.1080504@xenomai.org>
	<51B72EFE.70304@siemens.com> <51B73110.5000100@xenomai.org>
	<51B7319C.8060903@siemens.com> <51B7380B.80209@xenomai.org>
	<51B73A86.2040107@siemens.com> <51B73CBC.5050806@xenomai.org>
	<51B73D12.50603@siemens.com> <51B74335.1090809@xenomai.org>
	<51B7441A.6010807@siemens.com>
In-Reply-To: <51B7441A.6010807@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] git://git.xenomai.org/ipipe.git reshuffle,
	3.8.0 kernel support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/11/2013 05:36 PM, Jan Kiszka wrote:
> On 2013-06-11 17:33, Philippe Gerum wrote:
>> On 06/11/2013 05:06 PM, Jan Kiszka wrote:
>>> On 2013-06-11 17:05, Philippe Gerum wrote:
>>>> On 06/11/2013 04:56 PM, Jan Kiszka wrote:
>>>>> On 2013-06-11 16:45, Philippe Gerum wrote:
>>>>>> There is no requirement to push stable patches back to master.
>>>>>
>>>>> It makes no sense to push them back, would rather break our model, that
>>>>> is my point.
>>>>>
>>>>>> The only requirement is to branch off master for tracking a stable release.
>>>>>> master is currently 3.8(.0). We'll see how that works. So, 3.8.13 can go
>>>>>> over ipipe-next which is 3.8.10 already, then we may branch off
>>>>>> ipipe-3.8.13 from that head, and switch ipipe-next to 3.9 when we have
>>>>>> something sensible there.
>>>>>
>>>>> So ipipe-next would jump around, at some point tracking master, then
>>>>> again stable - makes no sense. Having multiple ipipe-3.8.x branches
>>>>> makes no sense to me either.
>>>>>
>>>>> Things should work like this:
>>>>>     - master tracks Linus master, thus will never contain any 3.x.y
>>>>>       releases
>>>>>     - ipipe-next is the next master state, but may be thrown away again
>>>>>       due to reworks until it is finally merged into master
>>>>>     - stable branches are forked off from master when it reached a 3.x.0
>>>>>       release point. From then on, fixes to master need to be back-ported
>>>>>       to stable (cherry-picked in the simple case)
>>>>>     - additionally, Linux stable releases are merged into the ipipe stable
>>>>>       branches, resolving conflicts just like we do in master when pulling
>>>>>       Linus changes in
>>>>>
>>>>
>>>> Thanks. You have just summarized what we devised weeks ago with all
>>>> maintainers. We agree on the model, no issue with that. I'm unsure why
>>>> you did not get to that conclusion, but let's move on. This is ok.
>>>
>>> Then please fix the existing branches accordingly, i.e. do not have
>>> 3.8.10 in ipipe-next and rename ipipe-3.8.0 to ipipe-3.8, e.g. when
>>> merging in 3.8.13.
>>>
>>
>> There is a series of patches issued for 3.8.0, so there must be a 3.8.0
>> branch anyway. Having 3.8.10 in ipipe-next is what seems to be confusing
>> to you; this branch is currently used for holding the hot topic for the
>> highest release we are actively working on, and this is currently
>> 3.8.10. Whether this is unfortunate or not, this does make sense to me.
>> What goes to master has to have gone through ipipe-next, but what's in
>> ipipe-next does not necessarily goes to master (if it's a stable).
>>
>> ipipe-next should switch to 3.9 in a near future. Not every project may
>> switch kernels, bumping stable releases, always aiming at the latest
>> stuff the way you suggest. For these people still restricted to using
>> e.g. 3.8.4 despite 3.8.13 is out, we keep several stable branches, and
>> cherry pick critical fixes into them. In that scenario, ipipe-3.8 won't
>> help.
>
> I disagree for obvious reasons (security and other bug fixes that enter
> stable trees continuously). Whenever we update a stable ipipe patch, it
> takes _very_ good reasons to _not_ pull in latest stable fixes as well
> and make sure their potential conflicts are resolved.

Whether this is right or wrong is another issue, I'm not the one to 
convince about this. Fact is that it happens that way, and often having 
regressions in linux stable should not be a reason for not fixing 
obvious critical I-pipe bugs if this is only about running "git 
cherry-pick".

> If you want to
> maintain outdated stable versions in addition, ok.

There is nothing really complex in pushing I-pipe related critical fixes 
into a stable branch when the opportunity to make things easier 
downstream exists. There should be two, maybe three stable I-pipe 
branches for each 3.x release, each of them exported as a series of 
ipipe-* patches over time. Nobody is volunteering for maintaining each 
and every linux stable release over five years either.

This is just about: we have branched off for issuing an I-pipe patch 
series, we can keep the branch separate in our tree, and try to keep 
that branch (almost) free from any obvious critical I-pipe bug we would 
know about later, likely until the corresponding linux stable tree 
reaches eol.

Bottom line, is that when you run ipipe-foo-3.8.13, then you may assume 
that branch ipipe-3.8.13 exists in our tree.

  But this cannot be
> supported for x86 from our side.
>

I don't see any issue with this.

 > Resources are scarce enough already.

Nah, scarcity starts when you end up writing "from my side", instead of 
"from our side".

-- 
Philippe.

