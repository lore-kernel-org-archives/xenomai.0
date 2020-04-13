MIME-Version: 1.0
References: <CAAvDm6bFOv=0_9kcX5BUtPYs3dRh-aVc7XARY7BtDo5Pu4Mz-Q@mail.gmail.com>
In-Reply-To: <CAAvDm6bFOv=0_9kcX5BUtPYs3dRh-aVc7XARY7BtDo5Pu4Mz-Q@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 13 Apr 2020 10:17:36 +0200
Message-ID: <CAFLxGvzWRwKfdChTSm5h1gqZPK12B3OCtA=j2Kr8ZaLvXOB_ng@mail.gmail.com>
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

On Mon, Apr 13, 2020 at 9:21 AM =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai <xe=
nomai@xenomai.org> wrote:
>
> Hi,
>      I am using xenomai 3.1.
>
>      How could I allocate a huge memory which may be larger then 50MB in
> rtdm driver?
>
>      I have tried rtdm_malloc function,but it returns NULL.

Depends on the use case, what exactly do you need?
Physical contiguous memory? Who should use it?
But 50MiB is a lot, in any context.

I'd allocate it in a non-realtime context with either vmalloc(), cma
or requesting
pages manually and then provide the allocated memory to my RT related code.

--=20
Thanks,
//richard

