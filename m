MIME-Version: 1.0
References: <CAAvDm6bFOv=0_9kcX5BUtPYs3dRh-aVc7XARY7BtDo5Pu4Mz-Q@mail.gmail.com>
 <CAFLxGvzWRwKfdChTSm5h1gqZPK12B3OCtA=j2Kr8ZaLvXOB_ng@mail.gmail.com>
 <CAAvDm6aRFgjt9r-yg0PuriaJgCOs_PVcCaK=BraNgs0EG82SyA@mail.gmail.com>
In-Reply-To: <CAAvDm6aRFgjt9r-yg0PuriaJgCOs_PVcCaK=BraNgs0EG82SyA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 13 Apr 2020 10:58:00 +0200
Message-ID: <CAFLxGvxmtQTF5FEwUBNnqBcxmeP=LNY_VPEgqAEKCSTJBhQ9sA@mail.gmail.com>
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
To: =?UTF-8?B?5a2Z5LiW6b6Z?= <sunshilong369@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Mon, Apr 13, 2020 at 10:47 AM =E5=AD=99=E4=B8=96=E9=BE=99 <sunshilong369=
@gmail.com> wrote:
>
> Hi,
>
>      Thanks a lot for your reply.
>
>      I am not a native speaker. I hope you won't be confused by my poor e=
nglish.
>
>
>
>     The huge memory allocated is no need to be contiguous.    I have seen=
 the suggestion that cma is not recommend to be used with xenomai through P=
hilippe Gerum have allready relaxed the requirement on CONFIG_MIGRATION to =
support cma. You could see the commit which commit id is 265ca3c3c for deta=
il .
>
>     The memory will be used to store high definition video to be processe=
d later .Though many image processing algorithms require contiguous memory,=
 I do not need contiguous memory indeed.

If CMA is really not an option you can still vmalloc() it or use page_alloc=
().
Since the memory does not have to be physically contiguous this are
not that hard.

Thanks,
//richard

