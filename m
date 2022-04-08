Date: Fri, 8 Apr 2022 21:38:47 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <296133608.230893.1649446727755.JavaMail.zimbra@nod.at>
In-Reply-To: <20220408144221.7934-1-richard@nod.at>
References: <20220408144221.7934-1-richard@nod.at>
Subject: Re: [PATCH] testsuite: Add test for x86 port io
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
To: xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> +=09if (!__Terrno(ret, sigaction(SIGSEGV, &sa, &old_sa)))
> +=09=09goto out;
> +
> +=09if (!__Terrno(ret, iopl(3)))
> +=09=09goto out;
> +
> +=09if (!__T(ret, pthread_create(&pt, NULL, tfn, NULL)))
> +=09=09goto out;
> +
> +=09if (!__T(ret, pthread_join(pt, (void *)&ptret)))
> +=09=09goto out;
> +
> +=09if (!__Terrno(ret, sigaction(SIGSEGV, &old_sa, NULL)))
> +=09=09goto out;
> +
> +out:

I missed here to restore old_sa. ;-\
If iopl(), pthread_create() or pthread_join() fail we end up with
the current signal handler for SIGSEGV.

Will fix in a later v2.

Thanks,
//richard

