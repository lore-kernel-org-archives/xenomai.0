MIME-Version: 1.0
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
 <20200407171816.E0B3979D@centrum.cz>
 <CAFLxGvx2EhOgUnB1VkW+7TendLUcsZ0XGGcwYhiPw7PcxwFkTw@mail.gmail.com>
 <20200408114406.6119E0D9@centrum.cz>
 <CAFLxGvx9-awne2He+ULqOzwf0cGae1s_k+-b8tdiM+uT67+cYg@mail.gmail.com>
 <20200409170009.5B0DAA77@centrum.cz>
 <CAFLxGvy8SP+4mr3PYYRHuxww=22w28RjaDPUgDSVFVHx-_cQ_g@mail.gmail.com>
 <20200409201057.74CB5ED0@centrum.cz>
 <CAFLxGvxuZw57FvaAQEAxseamoPhHdKX7wfZoaZxKskgeXa4V9g@mail.gmail.com>
 <20200414101600.F9AA555D@centrum.cz>
 <CAFLxGvz7ewnVv57QiEfCG76tjGcJ5v9KSg0QNHwtMa0Hihp_dQ@mail.gmail.com>
 <20200414111059.39716137@centrum.cz>
 <CAFLxGvx4qs8ONbaiU37rFNqXy=n8Hat_p-V7fLAAxgskbuU_GA@mail.gmail.com>
 <6b8c89d1-bae0-90f5-4935-925fb0af2137@siemens.com>
 <CAFLxGvzkubcKhrzWvHQqQ6Stv4xD=LU2k6Uvhymk=YKHpKt91w@mail.gmail.com>
 <da711d20-6897-3a80-d327-2f054c8bdd88@siemens.com>
In-Reply-To: <da711d20-6897-3a80-d327-2f054c8bdd88@siemens.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 14 Apr 2020 12:41:51 +0200
Message-ID: <CAFLxGvyoGbnQULdswrikMg-tBetnq-UA5fn_0jqQd1BLgH2U6A@mail.gmail.com>
Subject: Re: rt_task_unblock() POSIX alternative
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?UTF-8?Q?Petr_=C4=8Cervenka?= <grugh@centrum.cz>, Xenomai <xenomai@xenomai.org>

On Tue, Apr 14, 2020 at 12:29 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > This interrupts the Linux syscall, yes. Does this also work when the
> > thread blocks on the Xenomai/Cobalt side?
> >
>
> That ::read is a Xenomai syscall, being handled in the end by
> timerfd_read in the core. So, yes.

True that, once again I got tricked by wrapping. :-)

> There were two "tricks" needed: avoid syscall restart (as you already
> noticed) and using __STD (i.e. __real) pthread_kill in order to get a
> normal signal out. Oh, and the flag var should better be volatile, but
> that may still work when lucky.

While we are here, is there a guarantee that rt_task_unblock() can unblock
a thread in every situation?
I have a large Xenomai 2 application on my desk which seems to assumes that.

As far as I understand it, unblocking tasks is best effort.
/me has pthread_mutex_lock() in mind which must not return -EINTR as
required by POSIX.

-- 
Thanks,
//richard

