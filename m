MIME-Version: 1.0
References: <CAAvDm6bFOv=0_9kcX5BUtPYs3dRh-aVc7XARY7BtDo5Pu4Mz-Q@mail.gmail.com>
 <CAFLxGvzWRwKfdChTSm5h1gqZPK12B3OCtA=j2Kr8ZaLvXOB_ng@mail.gmail.com>
In-Reply-To: <CAFLxGvzWRwKfdChTSm5h1gqZPK12B3OCtA=j2Kr8ZaLvXOB_ng@mail.gmail.com>
From: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Date: Mon, 13 Apr 2020 16:47:26 +0800
Message-ID: <CAAvDm6aRFgjt9r-yg0PuriaJgCOs_PVcCaK=BraNgs0EG82SyA@mail.gmail.com>
Subject: Re: How could I allocate a huge memory in rtdm driver?
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

Hi,

     Thanks a lot for your reply.

     I am not a native speaker. I hope you won't be confused by my poor
english.



    The huge memory allocated is no need to be contiguous.    I have seen
the suggestion that cma is not recommend to be used with xenomai through
Philippe Gerum have allready relaxed the requirement on CONFIG_MIGRATION to
support cma. You could see the commit which commit id is 265ca3c3c for
detail .

    The memory will be used to store high definition video to be processed
later .Though many image processing algorithms require contiguous memory, I
do not need contiguous memory indeed.



  Best regards.

Richard Weinberger <richard.weinberger@gmail.com> =E4=BA=8E2020=E5=B9=B44=
=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:17=E5=86=99=E9=
=81=93=EF=BC=9A

> On Mon, Apr 13, 2020 at 9:21 AM =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai <=
xenomai@xenomai.org>
> wrote:
> >
> > Hi,
> >      I am using xenomai 3.1.
> >
> >      How could I allocate a huge memory which may be larger then 50MB i=
n
> > rtdm driver?
> >
> >      I have tried rtdm_malloc function,but it returns NULL.
>
> Depends on the use case, what exactly do you need?
> Physical contiguous memory? Who should use it?
> But 50MiB is a lot, in any context.
>
> I'd allocate it in a non-realtime context with either vmalloc(), cma
> or requesting
> pages manually and then provide the allocated memory to my RT related cod=
e.
>
> --
> Thanks,
> //richard
>
