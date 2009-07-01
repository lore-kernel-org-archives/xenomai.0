Message-ID: <4A4B2368.5080108@domain.hid>
Date: Wed, 01 Jul 2009 10:50:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E181189FBC64C@ILMA1.IL.NDS.COM>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E181189FBC64C@ILMA1.IL.NDS.COM>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_mutex_lock returns 1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
>  Thanks.
> 
> The mutex failed in the function pse51_mutex_trylock_internal, in the following section (the printk is mine):
> 
> #if XENO_DEBUG(POSIX)
>         if (mutex->owningq != pse51_kqueues(mutex->attr.pshared))
>         {
>                 printk ("mutex->owningq\n");
>                 return EPERM;
>         }
> #endif /* XENO_DEBUG(POSIX) */
> 
> I have XENO_DEBUG defined.
> 
> What does this mean?

This means that the mutex you lock does not belong to the process which
tries to lock it.

A program which does:

pthread_mutex_t mutex;
pthread_mutex_init(&mutex, NULL);
pid = fork();
if (pid) {
	assert(pthread_mutex_lock(&mutex) == 0);
}

will fail for reasons I already explained (both in the two previous
answers I sent you, and in the howto I pointed you to, which also
explains how to solve this issue). I am aware that this is not the
behaviour of Linux, but changing in Xenomai is not easy.

> 
> (BTW, nothing I can do about those footers.)

Yes you can. Use a yahoo, gmail, or even a hotmail account. According to
this footer, letting your mails pass to the mailing lists would allow
your company's legal department to bother us. Because letting this mail
pass to a public mailing list is "strictly prohibited", these are the
words of the footer.

-- 
                                          Gilles


