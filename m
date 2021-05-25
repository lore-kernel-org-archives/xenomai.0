MIME-Version: 1.0
References: <CALLqZ8SWfJqE64RfNfK-OXcj0mdWnU+5tTT9ABmMa-rz9QHZnA@mail.gmail.com>
 <CAMC3Yu0FizU008EE9RNB+jMZUxeg8R-u+7v4FGCFjLsLP7aRFg@mail.gmail.com>
In-Reply-To: <CAMC3Yu0FizU008EE9RNB+jMZUxeg8R-u+7v4FGCFjLsLP7aRFg@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 25 May 2021 09:21:50 -0400
Message-ID: <CALLqZ8S2QnXuK+5c_O=mLWGsyvL-t0OxGOh319PCq7=rddCxbQ@mail.gmail.com>
Subject: Re: arm/arm64 ipipe performance
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
To: liandao <liandao@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, May 25, 2021 at 6:43 AM liandao <liandao@gmail.com> wrote:

> hi greg gallagher,
>     is this mean:the ipipe-core-5.4.119-arm64-2 released on 5/23 also
> should turn off ftrace when config kernel?
>
> On 5/19/21, Greg Gallagher via Xenomai <xenomai@xenomai.org> wrote:
> > Hi Everyone,
> >    There's been a noticeable slow down in the arm and arm64 latency of
> > late.  I tracked the issue
> >  down to the tracing infrastructure.  For now if you hit this issue,
> > disable ftrace.  Once this is done the latency numbers look much better=
.
> > I'm currently working on resolving the issue.
> >
> >   New patches will be released this week for both arm and arm64 now tha=
t
> > the issue is understood and a work around exists.
> >
> > Thanks
> >
> > Greg
> >


Yes the same for arm64. I believe I=E2=80=99ve found the issue but for this=
 release
ftrace should not be included in the build to get optimal performance.

Thanks

Greg

>
>
