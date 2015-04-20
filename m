MIME-Version: 1.0
In-Reply-To: <447ft6hlni.fsf@lowell-desk.lan>
References: <CAL92PvWNqZ4SF=WToXa_vhYkpn0R5pOdqZGwtsPNgjyx84vmJQ@mail.gmail.com>
 <447ft6hlni.fsf@lowell-desk.lan>
Date: Mon, 20 Apr 2015 16:35:24 +0100
Message-ID: <CAL92PvXWNTwfJ6Y=H+ZzCK6hgKaOP-yFEAvhoCBjioiLk19hyg@mail.gmail.com>
From: cristian ramos <cristian0084@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] rt_sem_p(&semCC_, TM_INFINITE);
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Thank you very much for you answer and apologize me for asking the question

2015-04-20 16:20 GMT+01:00 Lowell Gilbert <kludge@be-well.ilk.org>:

> cristian ramos <cristian0084@gmail.com> writes:
>
> >    I get error -3 when I use int status = rt_sem_p(&semCC_,
> TM_INFINITE). I
> > have seen in the documentation that the possible values are:
> -EINVAL(-22),
> > -EIDRM(43), -EWOULDBLOCK(11), -EINTR(4), -ETIMEDOUT(110), -EPERM(-1),
> > somebody know what is meaning -3 values?
>
> #define    ESRCH         3      /* No such process */
>
> You know about strerror(), right?
>
