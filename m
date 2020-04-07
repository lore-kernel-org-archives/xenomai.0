MIME-Version: 1.0
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
In-Reply-To: <20200407171816.E0B3979D@centrum.cz>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 7 Apr 2020 17:30:09 +0200
Message-ID: <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
Subject: Re: rt_task_unblock() POSIX alternative
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
To: =?UTF-8?Q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On Tue, Apr 7, 2020 at 5:18 PM Petr =C4=8Cervenka via Xenomai
<xenomai@xenomai.org> wrote:
>
> Hello Jan.
> And if I don't want to totally remove the thread? Only to interrupt the w=
aiting and react according to new events (like reconfiguring something or s=
tarting to wait on different resource).
> Is there some pthread_create... or sched_... parameter or flag, that the =
task's system call can be interruptible?
> And how to use the signals to interrupt it? Call of kill(task_pid, SIGINT=
) didn't helped.

Use pthread_kill() plus a custom signal. Such as SIGRTMIN + 2.

--=20
Thanks,
//richard

