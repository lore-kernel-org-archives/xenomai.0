Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566181FC2
	for <xenomai@lists.linux.dev>; Tue, 17 Jan 2023 09:50:34 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id g205so5928067pfb.6
        for <xenomai@lists.linux.dev>; Tue, 17 Jan 2023 01:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=byGNKRrgcGq5AUDvhS+qssQ4c8gzZx+HYo6SXjw+HzY=;
        b=CeCFYCCrMZFc9pmZ+L7CIAK1OqMXLhh73zbfL0Y/cb+h/XFwhd0G3CwpODt2nR6QIZ
         dAgZRBkgqPMp94xCJ3aFBnpsKd5n5ieV7evWzpMBh0BqQU2v4WDf14zjqJOJ1BW/83hp
         cxAjIM2vpvHirDI/JrCkmjUgcBYyZhdpPiRhFj36Ouq3KcFkRsDhpAbdG7HCqu/T8Js5
         y4qf9l20LcEtXCFN1hjE2MmMM////pvjVqerjFCHgl5zsyz7ee67fNLVM7ts6w/XKm+X
         kOH2UUAuNWAsYmoopiKkMhy95L+Qs/2zttBdDKLXVhXnNWdcsnI43Mg8kXT0NISufFVP
         xxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byGNKRrgcGq5AUDvhS+qssQ4c8gzZx+HYo6SXjw+HzY=;
        b=Fy1a5GRYlHnTAbF23B18oE1NABxdJTkXoJlehQkH9eK0VlYyO5OG+kXFRd9YNCTWlf
         yYPkieXg7qXnUgYcVCSV9afjIH2Fi4PA51Po6MwqwJ9ij5MQyNvi50xYMGrxLBJ8E9qT
         Kp+6yakC8AtlTeQ4qJ/4d9tVkz8X2VcKVO4VmUFhB0ogTZjXYW8Opz036/uyePkYk5gx
         jRLhV8wW1ZbDiDkDKi2QJ+WdPsqrnKHYQ2Zj/e0hUftkI/QRRdFXegaQpxWYVp20K+YW
         Nn5P0jZeNl+2KtkVU95FZP2T4u3vtFtj6kx0HGpUELF2Qyt6wZPvvDy5KImiKxhxhIST
         Ha6Q==
X-Gm-Message-State: AFqh2kofSTuAP+TR2uKewxn1NjqWKEQzBe8NdGLh0Bu4rQVvolzoFEY0
	S7aGH9h6VwkZxLJHevJZVhOZxInTgSRjGqNc1RE=
X-Google-Smtp-Source: AMrXdXtG3aqHtdjcQDk8lnUw/Bat9mwFeg+Na1yS0Q8EHWL8DkS3b23xXdu8LfDZzyHw+r1iweVNZ04ILl64TqIdmLQ=
X-Received: by 2002:a63:5d06:0:b0:478:7743:901e with SMTP id
 r6-20020a635d06000000b004787743901emr148168pgb.375.1673949033574; Tue, 17 Jan
 2023 01:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1673779013-11742-mlmmj-00f27513@lists.linux.dev>
 <CAKcohPxHzbQvztgQMQaFq-EoXGbpfQxi1HpPV9nogBUaQ+PUSw@mail.gmail.com>
 <CAKcohPxdhCMohJZfSNaL2EvEDcLdm8CRgdy3hUusCu9Y5jexxw@mail.gmail.com>
 <MN2PR11MB42854A69C41937ADA0F29CDAF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <e8f0810b-7104-18a2-9931-a1df6ede2917@siemens.com> <MN2PR11MB42855B83E5F981669B6B0ED9F2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <94fdf3b0-bc07-7063-7cc6-f6987ad1ed10@siemens.com> <847c0a00-2e91-6391-d8e4-6677ca719baf@siemens.com>
 <MN2PR11MB4285E612761676D50EF5571DF2C19@MN2PR11MB4285.namprd11.prod.outlook.com>
 <b3eeb9f2-21a4-feab-a605-70f6fbe9285f@siemens.com>
In-Reply-To: <b3eeb9f2-21a4-feab-a605-70f6fbe9285f@siemens.com>
From: Yunjie Gu <yunjie.gu1@gmail.com>
Date: Tue, 17 Jan 2023 09:50:20 +0000
Message-ID: <CAKcohPz3z+HVJxsaYcEr0Z1QDwxWHdbryoBUuc7+FxynR3nk6A@mail.gmail.com>
Subject: Re: while loop in a multi-core cpu
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, 
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, qiyu_sjtu@163.com
Content-Type: text/plain; charset="UTF-8"

Hi Hongzhan and Jan,

Many thanks for the answers. Is this also true even for multi-core
cpus? When one of the cores is running a xenomai thread 100%, what the
other cores are doing?
If we really want a core to run a 100% while loop, how can we do that
in a dual-core xenomai system? Say, can we isolate one core that is
not managed by the OS (i.e. kind of bare-metal) to do this?

Best Regards,
Yunjie

On Mon, 16 Jan 2023 at 14:20, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 16.01.23 15:09, Chen, Hongzhan wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >> Sent: Monday, January 16, 2023 5:13 PM
> >> To: Chen, Hongzhan <hongzhan.chen@intel.com>; Yunjie Gu
> >> <yunjie.gu1@gmail.com>; xenomai@lists.linux.dev
> >> Subject: Re: while loop in a multi-core cpu
> >>
> >> On 16.01.23 10:10, Jan Kiszka wrote:
> >>> On 16.01.23 06:53, Chen, Hongzhan wrote:
> >>>>
> >>>>
> >>>>> -----Original Message-----
> >>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>>> Sent: Monday, January 16, 2023 1:17 PM
> >>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>; Yunjie Gu
> >>>>> <yunjie.gu1@gmail.com>; xenomai@lists.linux.dev
> >>>>> Subject: Re: while loop in a multi-core cpu
> >>>>>
> >>>>> On 16.01.23 04:05, Chen, Hongzhan wrote:
> >>>>>>
> >>>>>>
> >>>>>>> -----Original Message-----
> >>>>>>> From: Yunjie Gu <yunjie.gu1@gmail.com>
> >>>>>>> Sent: Monday, January 16, 2023 12:08 AM
> >>>>>>> To: xenomai@lists.linux.dev
> >>>>>>> Subject: while loop in a multi-core cpu
> >>>>>>>
> >>>>>>> Hi Guys,
> >>>>>>>
> >>>>>>> We are trying to develop a polling mode thread to skip the delay of
> >>>>>>> the interrupt response. This is done by a while loop to check the
> >>>>>>> hardware (say a gpio or a timer) continuously. When we did this we
> >>>>>>> found that the system was frozen, meaning that the other cores are not
> >>>>>>> functioning when we run a polling loop on a single core. But if we do
> >>>>>>> the same in a normal Linux thread, the system is not frozen. I'm just
> >>>>>>> wondering if polling mode is allowed for xenomai, or if we did
> >>>>>>
> >>>>>> Xenomai threads should not dominate cpu too much time in dual kernel
> >>>>> configuration.
> >>>>>> When xenomai was dominating cpu too long time, from Linux 's view,
> >> cpu is
> >>>>> like dead
> >>>>>> and Linux can not handle it correctly in such case.  If you enable
> >>>>> CONFIG_XENO_OPT_WATCHDOG,
> >>>>>> it may notify system to avoid such thing from debug point.
> >>>>>
> >>>>> Theoretically, a stable NOHZ-full setup should be able to tolerate on
> >>>>> top a Xenomai-only schedule with full CPU domination. However,
> >> achieving
> >>>>> that under Linux is already not trivial, and I haven't tested if Linux
> >>>>> is actually entering the right state when out-of-band Dovetail/Xenomai
> >>>>> takes over.
> >>>>
> >>>> What do you means about NOHZ-full setup? Is it just related to
> >> configuration or commands passed for linux?
> >>>> Is it possible to fix such issue that we do not need to modify Linux kernel?
> >>>>
> >>>
> >>> I'm referring to
> >>> https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-
> >> scheduling-clock-ticks-for-idle-cpus
> >>>
> >>
> >> Actually:
> >> https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-scheduling-
> >> clock-ticks-for-cpus-with-only-one-runnable-task
> >
> > The last paragraph of known issues in https://www.kernel.org/doc/html/latest/timers/no_hz.html#omit-scheduling-
> > clock-ticks-for-cpus-with-only-one-runnable-task, it mentioned that there is still the needs which
> > are are currently accommodated by scheduling-clock tick every second or so including calculating CPU load, maintaining sched average, computing CFS entity vruntime, computing avenrun, and carrying out load balancing.
> > If we can not meet these needs , may it cause other system issue?
> > In dpdk, we may also need 100% dominating cpu in PMD mode, it is worth giving it a try.
> >
>
> Yeah, didn't check in a while that status, just recalling the at least
> mainline was not able to provide 100%, but there were concepts (or
> hacks?) to get it at that level. Obviously, if there is still no 100% in
> mainline, we would just prolong the phase of CPU domination also for
> Xenomai tasks, but not eliminate the need to periodically release it for
> a while.
>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>
