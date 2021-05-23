Subject: Re: linux-v5.10.y-dovetail
References: <b711cb1b-096c-d278-02be-ed8ff208a568@siemens.com>
 <87wnrrccis.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3e30441c-496a-efb0-8d8a-ccc5325c978c@siemens.com>
Date: Sun, 23 May 2021 14:58:30 +0200
MIME-Version: 1.0
In-Reply-To: <87wnrrccis.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 22.05.21 12:02, Philippe Gerum wrote:
> 
> Hi Jan,
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> Hi Philippe,
>>
>> first, is source.denx.de/Xenomai/xenomai4/linux-evl.git already
>> replacing git.evlproject.org/linux-evl.git? At least CI is currently
>> stuck over the latter [update: was stuck, it's moving again].
>>
> 
> Not yet, I'll announce when the switch to
> source.denx.de/Xenomai/xenomai4 is complete, with a grace period of one
> week from that point to update the automated procedures there may be,
> before the trees at git.evlproject.org are decommissioned eventually. In
> the meantime, I'll make sure both sides remain on sync.
> 

OK, then it was fine to switch CI already.

>> Regarding 5.10, I think we are getting closer to the point where our
>> users also need a merging stable branch to track what happens
>> dovetail-wise (at least I have such folks). Would you move
>> linux-v5.10.y-dovetail in that way forward from now on? Or is there a
>> need for one more hard rebase first?
>>
>> Some linux-v5.10.y-dovetail-rebase for the latest version could still be
>> provided in order to ease export to downstream kernels. That would bring
>> us in line with how -rt is maintained e.g.
>>
>> If you need help on the stable side, let me know.
>>
> 
> I don't plan to maintain merging branches myself, only rebase ones. I'll
> rename the stable branches to *-rebase shortly, in order to follow the
> same convention as -rt, clearing the namespace for pulling the work of
> whoever wants to maintain merging branches.
> 

Sounds good. Then I will create the merges. I suppose will that also be
useful to append some -rebase to tag applied to rebased branched, to
avoid conflicts with the merging branch.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

