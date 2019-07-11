MIME-Version: 1.0
References: <CAFLxGvyW2aXNScNQb6rCQtS5AXd_NYYrw+qcjax_H_xiByL8WQ@mail.gmail.com>
 <2f90e818-0e5e-d06f-1cec-2491ffe01ba1@xenomai.org>
In-Reply-To: <2f90e818-0e5e-d06f-1cec-2491ffe01ba1@xenomai.org>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 11 Jul 2019 17:34:35 +0200
Message-ID: <CAFLxGvySPtkN0+VSWO2zbQ7F0-+bsQR69_S8pi3Dxhx5oX9CUg@mail.gmail.com>
Subject: Re: Question on deleting a locked RT_MUTEX
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe,

On Thu, Jul 11, 2019 at 4:30 PM Philippe Gerum <rpm@xenomai.org> wrote:
> > If I have a mutex m1 and a misbehaving RT_TASK rt1 which exits right after
> > acquiring mutex m1, what is the recommended way to get the lock back into a
> > well defined state?
> >
>
> Unfortunately, I see no option other than leaking the orphaned mutex and
> re-creating a new one on the same descriptor with rt_mutex_create().

Will it leak on the kernel side or "just" in the userspace process?
As long the application does not badly deadlock I think we can recover somehow.

-- 
Thanks,
//richard

