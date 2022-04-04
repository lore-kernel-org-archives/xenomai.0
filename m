Date: Mon, 4 Apr 2022 14:40:14 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <2108061040.215035.1649076014582.JavaMail.zimbra@nod.at>
In-Reply-To: <1018f867-d9a7-4c0a-a6ee-6b9a5d457c0a@siemens.com>
References: <20220330201614.31083-1-richard@nod.at>
 <70be73c4-2b97-7a92-014d-5655a489a0b2@siemens.com>
 <169724307.214985.1649074667197.JavaMail.zimbra@nod.at>
 <1018f867-d9a7-4c0a-a6ee-6b9a5d457c0a@siemens.com>
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
Cc: xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> Uff yes. Just tried building with --with-core=3Dmercury and it failed. ;=
-\
>>=20
>> So, when mercury is enabled, alchemy will use NPTL.
>> This means rt_task_unblock() cannot work on mercury because
>> pthread_mutex_lock() will not return EINTR either.
>>=20
>> Fixing the build for mercury should be easy by adding an ifdef
>> CONFIG_XENO_MERCURY.
>> But I'm not sure how to fix unblocking for the mercury case.
>=20
> Either by ignoring that case on mercury (it has not predecessor in
> Xenomai 2, and it can't be fixed via posix means) or by redefining the
> behavior for everyone, i.e. by exempting rt_mutex_acquire* from
> rt_task_unblock.

I'd strongly vote for option #1. The application I work an cleans
up deadlocks with rt_task_unblock().
This seems to work quite well on Xenomai 2.

Thanks,
//richard

