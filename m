References: <5283f8ff-33bf-910d-25b5-044ea6a963ae@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: dovetail: add prctl() call form
Date: Mon, 08 Nov 2021 18:57:18 +0100
In-reply-to: <5283f8ff-33bf-910d-25b5-044ea6a963ae@siemens.com>
Message-ID: <87a6iepm0x.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> this dovetail commit makes the pipeline go red, crashing the kernels
> (e.g. [1][2]). I hope this is something we can quickly fix in dovetail,
> maybe via a config option?
>
> Jan
>
> [1] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348118#L966
> [2] https://source.denx.de/Xenomai/xenomai-images/-/jobs/348121#L1429

Cobalt needs some update to cope with this now. I'll send a fix either
way (dovetail or xenomai) tomorrow morning.

-- 
Philippe.

