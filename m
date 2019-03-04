MIME-Version: 1.0
References: <CA+WNq=WXhcDcibmNQeO1WCkOmHVKFB32Fu5DVWWKPTyq2EtFzw@mail.gmail.com>
 <20190301133206.0b723b80@md1za8fc.ad001.siemens.net>
 <CA+WNq=Vo0p6CAWp_V5JzWK47JGJZVDvj0j1Os8AdF9FStvBncw@mail.gmail.com>
 <f2711dc9-497a-2aac-391d-c30a02c306b0@numalliance.com>
In-Reply-To: <f2711dc9-497a-2aac-391d-c30a02c306b0@numalliance.com>
From: C Smith <csmithquestions@gmail.com>
Date: Mon, 4 Mar 2019 00:38:50 -0800
Message-ID: <CA+K1mPE=X0G7N1DZde0hYvJSAytydP9QgdacZGzaj=2vJAQ=nw@mail.gmail.com>
Subject: Re: Qt application on Xenomai
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
To: =?UTF-8?Q?St=C3=A9phane_Ancelot?= <sancelot@numalliance.com>
Cc: Sumitabh Ghosh via Xenomai <xenomai@xenomai.org>

QT will allocate/destruct memory and its overhead and timing are
unpredictable because of its signal/slot architecture - don't try to run QT
in RT space.
Instead, run your QT (C++,etc) application in userspace. Have your QT
application attach to a static shared memory segment which a xenomai RT
thread creates, and put any time-critical code into the RT thread. Send
messages on XDDP sockets (or similar fifos) between the two processes if
necessary. Your UI and multimedia graphics don't really need determinism,
they have only 'soft real time' timing requirements (they can drop frames
or finish late and the human viewer doesn't care). We've done this
architecture for years, on uniprocessor systems, it works well.
- C Smith

On Sun, Mar 3, 2019 at 11:56 PM St=C3=A9phane Ancelot via Xenomai <
xenomai@xenomai.org> wrote:

> Hi,
>
> I will share some points from my viewpoint :
>
> The Xenomai impact will depend on the processor architecture selected
> (uniprocessor or multiprocessor).
>
> In uniprocessor context, while your rt application will consume cpu
> time, meanwhile the other scheduled application will be waiting for
> their time slice.
>
> And thus GUI application is interrupted and may be slow in some cases
> (that really depends on the impact of the RT process). In multiprocessor
> context, this becomes no more a problem.
>
> Performance is then dependant on the cpu architecture (x86/x64/arm...)
> and their graphics chip device.
>
> Depending on the graphics chip, the performance needed to drive a 19inch
> size display is not the same as driving a 7inch size display.
>
> There are two kinds of Qt applications these days : Native Qt and QML
> applications.
>
> * Qt is native and can use 2D OpenGL or display framebuffer,
>
> * QML is no more than a javascript application layer running in a
> javascript web engine , in this case you will be performance mainly
> impacted by the QML architecture.
>
> If your GUI application fits only few buttons in a display, then, that's
> not a problem.
>
> Regards.
>
> St=C3=A9phane ANCELOT
>
>
> Le 02/03/2019 =C3=A0 06:57, Sumitabh Ghosh via Xenomai a =C3=A9crit :
> > Hi Henning,
> >
> > Thanks for your confirmation. Just to understand your set up further,
> does
> > the POSIX layer used by QT is of the Xenomai skin ? Is This the way Qt =
is
> > leveraging the rt features ?
> >
> > I guess the rendering of graphics is handled through non rt Linux
> > framebuffer /opengl apis.
> >
> > Let me know if my above understanding is correct.
> >
> > Thanks,
> > Sumit
> >
> >
> >
> >
> > On Fri, Mar 1, 2019, 18:02 Henning Schild <henning.schild@siemens.com>
> > wrote:
> >
> >> Hi,
> >>
> >> i am not sure i fully understand the question. In case you are worried
> >> about combining Xenomai and Qt, i can assure you that it is possible.
> >> We do have big c++/Qt applications running both rt and non-rt on
> >> xenomai.
> >>
> >> regards,
> >> Henning
> >>
> >> Am Fri, 1 Mar 2019 14:10:42 +0530
> >> schrieb Sumitabh Ghosh via Xenomai <xenomai@xenomai.org>:
> >>
> >>> Hi,
> >>>
> >>> I have a generic question not specific to any platform. If I want to
> >>> run a small graphics application on Xenomai 3.x what would be the
> >>> correct approach. e.g. Qt application framework which needs POSIX
> >>> apis and a linux frame buffer to be able to render 2D applications.
> >>>
> >>> Kindly provide me some pointers.
> >>>
> >>> Thanks in advance.
> >>>
> >>> Cheers!
> >>> Sumit
> >>
>
