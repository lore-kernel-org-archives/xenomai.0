References: <375d9f2d-4182-cc45-6ac1-12fa44b7af96@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Y2038 re-sync request
In-reply-to: <375d9f2d-4182-cc45-6ac1-12fa44b7af96@siemens.com>
Date: Sun, 21 Feb 2021 16:51:56 +0100
Message-ID: <87czwt4dwj.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org, rick.y.wang@intel.com, chensong <chensong@tj.kylinos.cn>


Hi,

Florian Bezdeka <florian.bezdeka@siemens.com> writes:

> Hi all!
>
> I'm a little bit surprised to see patches caring about the Y2038 problem
> coming up. I guess Song and me have been to silent in the last months
> due to new year vacations and internal schedules...
>
> Maybe it's time to re-sync. CCing Rick as organizer of the community
> call minutes. Maybe we can get a timeslot in the meeting for that topic.
> Song already mentioned via private channel that he would be available as
> well.
>
> The results of our investigations can be found here [1]. When we started
> we tried to stay fully backward compatible, so allowing updates of
> libcobalt without any need to update the Cobalt core as well. That may
> no longer be necessary, so let's discuss it. (IOW: Do we need a Y2038
> safe Xenomai 3.1?)
>
> Btw: It isn't to late yet. Song reviewed [1] again over the weekend and
> we planned to discuss the roadmap with you within the next week(s). So
> Philippe was some kind of "ahead of time" for us ;-)
>
> Happy hacking!

As I just mentioned in replying to Song, this patch series is not about
addressing the y2038 issue fully, but merely to prep for this by
replacing the ambiguous timeval/timespec/itimerspec/timex types with
their new y2038-safe counterparts throughout the core implementation,
aligning on the mainline kernel. This is a prerequisite to support
Dovetail on top of v5.10 for Xenomai 3.2, simply because these types are
not available to the kernel code anymore.

Completing the y2038 effort will require more work, likely starting with
defining how userland should deal with this (i.e. dual-time vs
single-time support). Discussing the matter during the next meeting
would be indeed a good idea.

-- 
Philippe.

