Date: Tue, 5 Apr 2022 18:14:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <835760478.219600.1649175258568.JavaMail.zimbra@nod.at>
In-Reply-To: <965edc40-6bae-fd91-331e-b1e59bf61a84@siemens.com>
References: <20220405114052.7385-1-richard@nod.at>
 <94940f791d07b0f2e4f8594b26aa47680a024d0b.camel@siemens.com>
 <CAFLxGvzdJYiVd+ZsQ++PPcd_P1ajdDPgWe0Tpko0JAo3G5rb_A@mail.gmail.com>
 <54aa3260-9a9b-dbdb-90a8-6395fd86fc28@siemens.com>
 <1433861802.219536.1649174000463.JavaMail.zimbra@nod.at>
 <965edc40-6bae-fd91-331e-b1e59bf61a84@siemens.com>
Subject: Re: [PATCH] xnthread_relax: Make sure wakework irq work has a stack
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
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> But I fear this might take some time. The KASAM spat happened only once
>> and also only after the test ran for almost 5 days.
>=20
> How about additionally widening the suspected race window by adding a
> delay to lostage_task_wakeup?

Excellent idea! :-)

Thanks,
//richard

