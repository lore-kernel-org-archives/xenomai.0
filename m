MIME-Version: 1.0
References: <E1jR768-0006T0-RS@xenomai.org>
 <123ae762-34c5-e989-8295-30ca61b89f60@siemens.com>
 <CALLqZ8TFu8V-6QVgKqc5+esnkShgFuO4sDdjGEv4zfC_-SATgw@mail.gmail.com>
 <CALLqZ8Q-04Qv7XhiKWuQ2wbQds1ZHyiasxf0i7OS9P6NsAAJhw@mail.gmail.com>
 <ebfa2444-ac56-313d-4335-83d5417ea404@siemens.com>
In-Reply-To: <ebfa2444-ac56-313d-4335-83d5417ea404@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Sat, 25 Apr 2020 01:05:33 -0400
Message-ID: <CALLqZ8Szcca9KmtcfvQ2QwEUMsUYOmorOg39xe1GhVg3C6nbaw@mail.gmail.com>
Subject: Re: [I-PIPE] ipipe-core-4.19.115-arm64-5 released
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 24, 2020 at 3:14 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 24.04.20 20:28, Greg Gallagher wrote:
> >
> >
> > On Fri, Apr 24, 2020 at 2:06 PM Greg Gallagher <greg@embeddedgreg.com
> > <mailto:greg@embeddedgreg.com>> wrote:
> >
> >     Sure no problem
> >
> >     On Fri, Apr 24, 2020 at 2:00 PM Jan Kiszka <jan.kiszka@siemens.com
> >     <mailto:jan.kiszka@siemens.com>> wrote:
> >
> >         On 22.04.20 06:34, xenomai--- via Xenomai wrote:
> >          > Download URL:
> >         https://xenomai.org/downloads/ipipe/v4.x/arm64/ipipe-core-4.19.=
115-arm64-5.patch
> >          >
> >          > Repository: https://git.xenomai.org/ipipe-arm64
> >          > Release tag: ipipe-core-4.19.115-arm64-5
> >          >
> >
> >         I think we have a build regression here:
> >
> >         https://travis-ci.com/github/xenomai-ci/xenomai/jobs/323104732
> >
> >         Could your have a look, Greg?
> >
> >
> > I must have missed a commit, I=E2=80=99ll have it fixed up tonight. If =
I delete
> > the tag and regenerate the patch can it stay at 05 or do I need to bump
> > to 06?
>
> Don't do history rewriting on releases. I did quite a few bad releases
> as well already. Just roll out a better one. ;)
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux

Should all be fixed, apologizes to anyone that was using that patch.

Thanks

Greg

