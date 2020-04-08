MIME-Version: 1.0
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
 <20200408114406.6119E0D9@centrum.cz>
In-Reply-To: <20200408114406.6119E0D9@centrum.cz>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 8 Apr 2020 23:36:43 +0200
Message-ID: <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
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

On Wed, Apr 8, 2020 at 11:44 AM Petr =C4=8Cervenka <grugh@centrum.cz> wrote=
:
>
> > Use pthread_kill() plus a custom signal. Such as SIGRTMIN + 2.
> Calling of kill() or pthread_kill() does not help. Nothing is able to int=
errupt read() from timerfd (only pthread_cancel). Do I have to prepare the =
task or timerfd to be interruptible by a signal?

BTW: Why do you think nothing can interrupt a read() from a timerfd?
If read() blocks on a timerfd the calling thread will be put into
interruptable sleep.

--=20
Thanks,
//richard

