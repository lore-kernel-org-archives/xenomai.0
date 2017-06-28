References: <CAFUnMkmx6TK94a4Q0qtmaaGRnvW_cHpR4NaBcT-+ef8GaY_4aw@mail.gmail.com>
From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <fc4afff2-399b-36ff-7b55-f655d9139d24@numalliance.com>
Date: Wed, 28 Jun 2017 08:45:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFUnMkmx6TK94a4Q0qtmaaGRnvW_cHpR4NaBcT-+ef8GaY_4aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] CPU time limit exceeded (core dumped)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I am not sure, but I think  this means that your program is running in=20
an infinite loop....
Regards,
S.Ancelot

Le 27/06/2017 =C3=A0 16:23, Ashok kumar a =C3=A9crit :
> Hi,
> I am using xenomai -2.6.2.1 . I have configured two task, after some ti=
me
> of running
> I got this message in the terminal
> CPU time limit exceeded (core dumped)
>
> in one task for 1ms time I am reading Ethercat frames and other task of=
 1ms
> I am running an application for calculation.
>
> please provide me the solution for this  error
>
> CPU time limit exceeded (core dumped)
>
> Thank you
> Ashok
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

