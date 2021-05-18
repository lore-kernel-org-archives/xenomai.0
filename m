MIME-Version: 1.0
References: <CALLqZ8SWfJqE64RfNfK-OXcj0mdWnU+5tTT9ABmMa-rz9QHZnA@mail.gmail.com>
 <82f01d0d-360b-0016-9aec-24ef5b1a8d6b@siemens.com>
In-Reply-To: <82f01d0d-360b-0016-9aec-24ef5b1a8d6b@siemens.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 18 May 2021 15:06:52 -0400
Message-ID: <CALLqZ8R=tb5h7rkqnV9WYJZWSY2xMNRtdWZhzR1oCmkjJs0YQA@mail.gmail.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, May 18, 2021 at 2:49 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 18.05.21 20:28, Greg Gallagher via Xenomai wrote:
> > Hi Everyone,
> >    There's been a noticeable slow down in the arm and arm64 latency of
> > late.  I tracked the issue
> >  down to the tracing infrastructure.  For now if you hit this issue,
> > disable ftrace.  Once this is done the latency numbers look much better=
.
> > I'm currently working on resolving the issue.
>
> Do you mean disabling during build? Or is the issue only present when
> tracing is actively used during runtime?




>
> >
> >   New patches will be released this week for both arm and arm64 now tha=
t
> > the issue is understood and a work around exists.
> >
>
> That's great!
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


Hi,
   I mean disabled during build time. That=E2=80=99s at least how I tested =
to see
that the issue went away. Hopefully I=E2=80=99ll have a solution soon.

Thanks

Greg
