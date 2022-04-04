Date: Mon, 4 Apr 2022 15:26:45 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <704015867.215142.1649078805251.JavaMail.zimbra@nod.at>
In-Reply-To: <49ea6194-c0da-6039-fc96-9686bec23ad1@siemens.com>
References: <20220330201614.31083-1-richard@nod.at>
 <74b8e93cc14b656f6d97bff5d6ef2c2dd606f64b.camel@siemens.com>
 <637249774.202758.1648715778757.JavaMail.zimbra@nod.at>
 <589a354736795684073a1b35b5605205e72febec.camel@siemens.com>
 <CAFLxGvyvAR5-CHPSnqt=rYEkyd=KtWGg9c69q07JjxFPKFoajg@mail.gmail.com>
 <49ea6194-c0da-6039-fc96-9686bec23ad1@siemens.com>
Subject: Re: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> An: "Richard Weinberger" <richard.weinberger@gmail.com>, "Florian Bezdeka=
" <florian.bezdeka@siemens.com>
> CC: "richard" <richard@nod.at>, "xenomai" <xenomai@xenomai.org>
> Gesendet: Montag, 4. April 2022 13:20:55
> Betreff: Re: [PATCH] Alchemy: Fix rt_task_unblock() for RT_MUTEX

> On 04.04.22 11:39, Richard Weinberger via Xenomai wrote:
>> On Fri, Apr 1, 2022 at 9:16 AM Bezdeka, Florian via Xenomai
>> <xenomai@xenomai.org> wrote:
>>>> With my changes at least the application works again and the tests
>>>> on the customer side pass.
>>>
>>> We would need such / similar tests as well inside the Xenomai testsuite
>>> to make sure we don't break it again.
>>=20
>> I'm a bit unsure where to place the test.
>> Under testsuite/ seems to be not a single alchemy related test.
>> Shall I create a new folder?
>=20
> There is lib/alchemy/testsuite/ - but also
> https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/32.

:-S

Thanks for the pointer.

I fear there are more TODOs, just gave some tests a try.
LD_LIBRARY_PATH=3D/usr/xenomai/lib64 lib/alchemy/testsuite/task-5.c.exe=20
[9] at task-5.c:79
[1] at task-5.c:23
[10] at task-5.c:87
[3] at task-5.c:40
[11] at task-5.c:95
[4] at task-5.c:45
[5] at task-5.c:50
[6] at task-5.c:55
[2] at task-5.c:28
[7] at task-5.c:60
   0"001.868| BUG in __traceobj_check_abort(): [FGND] wrong return status:
              task-5.c:63 =3D> EINVAL (want OK)
Thanks,
//richard

