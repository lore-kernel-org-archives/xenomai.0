Date: Fri, 8 Apr 2022 11:19:51 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <405880743.228998.1649409591091.JavaMail.zimbra@nod.at>
In-Reply-To: <7aa1e2f14db4438eeae8225d143c1836aee42879.camel@siemens.com>
References: <20220408080401.22235-1-richard@nod.at>
 <20220408080401.22235-4-richard@nod.at>
 <7aa1e2f14db4438eeae8225d143c1836aee42879.camel@siemens.com>
Subject: Re: [PATCH 3/6] testsuite: Add a simple test driver for alchemytests
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
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@xenomai.org>

Florian,

----- Urspr=C3=BCngliche Mail -----
> Why is this "special" cpu-affinity necessary? What would happen if we
> remove that? Asking because I want to make sure that we do not miss any
> concurrency problems by adding this constraint.

I don't know. I copied it as-is from the old Makefile.
Without that flag most tests fail (at least on my x86 VM).

So far I did only integration of the tests but no deciphering. :-)

Thanks,
//richard

