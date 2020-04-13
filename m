MIME-Version: 1.0
References: <CAAvDm6aGF4MyODidv3qjCuUoUVVEEa4qh4H_X6iQvaKPAkvumw@mail.gmail.com>
In-Reply-To: <CAAvDm6aGF4MyODidv3qjCuUoUVVEEa4qh4H_X6iQvaKPAkvumw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 13 Apr 2020 10:29:31 +0200
Message-ID: <CAFLxGvx+AmTs+Q-A77n_c=uXun8883DX9d8G+Ji-U7tpkJigLQ@mail.gmail.com>
Subject: Re: Could anybody make me more clearly that the differences bettween
 rtdm_event_wait and rtdm_wait_condition?
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

On Mon, Apr 13, 2020 at 5:14 AM =E5=AD=99=E4=B8=96=E9=BE=99 via Xenomai <xe=
nomai@xenomai.org> wrote:
>
> Hi,
>        Could anybody make me more clearly that the differences bettween
> rtdm_event_wait and rtdm_wait_condition?
>
>        I think they both support to wait for some condition become true.

In the *_condition() variant you can specify your own condition to wait for=
.
Just like with Linux's wait_event* API.

>        Another question is about the differences betteew
> rtdm_wait_condition and rtdm_wait_condition_lock.I could not find any
> actual usage of the two function throughout all source code (v3.1).

You can lock a waitqueue. Depending on weather the queue is locked or not
the _lock() variant is needed.

See:
https://www.xenomai.org/documentation/xenomai-3.1/html/xeno3prm/group__rtdm=
__sync.html#ga16d020cefc20213de5929ed2e72fe918

--=20
Thanks,
//richard

