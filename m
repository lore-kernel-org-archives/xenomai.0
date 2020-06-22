MIME-Version: 1.0
References: <HE1PR03MB31154FC1C35ABA6CC541A8C9E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
 <702edf30-b134-ac8a-3e41-787a5428ac86@siemens.com>
 <CALLqZ8RhxCkRCbSkiWcFAtYp8VkwMCFG57LVz-uewgYmpy-1PA@mail.gmail.com>
 <HE1PR03MB311538758AAB8CD1D6141B99E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
In-Reply-To: <HE1PR03MB311538758AAB8CD1D6141B99E5810@HE1PR03MB3115.eurprd03.prod.outlook.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 22 Jun 2020 12:25:08 -0400
Message-ID: <CALLqZ8S1XPVOJJnJat-VMQQdyLyqm5rw2QUK1GmzCckoXt4QSg@mail.gmail.com>
Subject: Re: [PATCH 0/9] arm: ipipe: Add basic I-pipe support for the SAMA5D3
 SoC
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jouko Haapaluoma <jouko.haapaluoma@wapice.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Jun 12, 2020 at 11:58 AM Jouko Haapaluoma
<jouko.haapaluoma@wapice.com> wrote:
>
> Thanks for replies, answers for both below.
>
> > Great, thanks for the patches! I assume Greg will look into them in details.
> > Regarding the mainline patches: Are they simply missing in 4.19
> > because they were not backported as fixes (feature patches)? Are they
> > safe to be applied on a stable branch, i.e. side-effect free for other targets?
>
> The mainline patches are included in Linux 5.2. Probably they are simply missing.
> I think that there is a low risk for side effects - patches affect only SAMA5 (and AT91). I-pipe is
> anyway not supported on other SAMA5/AT91 targets currently.
>
> >Are the mainline and PREEMTP_RT patches included in the patch series?
> Yes, both included: mainline patches are from Alexandre Belloni, RT_PREEMPT is from Benedikt Spranger
>
> BR,
> Jouko

Applied to master, I'll push these into 4.19, and 4.19-cip this week.

thanks for the patches :)

-Greg

