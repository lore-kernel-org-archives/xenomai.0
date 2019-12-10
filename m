Date: Tue, 10 Dec 2019 20:52:24 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <739572661.112669.1576007544977.JavaMail.zimbra@nod.at>
In-Reply-To: <e58f57ef-4de9-ea9c-708c-6138aa2662e0@siemens.com>
References: <CAOf5uw=i62dBaP1KidqJ09RFYz7hwPDj4e9cCwvNQzq9h61n5A@mail.gmail.com>
 <CAFLxGvz9X3qtz-tK6egDLuNn2OB6iYuy__-th=61mAbHynV+qg@mail.gmail.com>
 <6858a3b5-adbc-c65f-c11c-92297d4dd8f7@siemens.com>
 <2008645939.112092.1575975265668.JavaMail.zimbra@nod.at>
 <45cda878-fa53-c1b2-881b-06d52e66a32a@siemens.com>
 <4298ac73-340f-5699-7176-ef48b5ab2294@xenomai.org>
 <316849456.112635.1576006265616.JavaMail.zimbra@nod.at>
 <e58f57ef-4de9-ea9c-708c-6138aa2662e0@siemens.com>
Subject: Re: Lockdep splat around rq->lock (Was: Re: [Xenomai] am335x xenomai)
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
Cc: Philippe Gerum <rpm@xenomai.org>, Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, xenomai <xenomai@xenomai.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> That's untested even on x86 - and likely not working, with any kernel.
>=20
> Do you have a use case for kprobe?

Yes. On the old kernel we used to have many hooks (function pointers)
within kernel to allow installing notification functions by our modules.
It is basically a hand made tracing/notify framework.

To get rid of the mess we decided to use kprobes instead of our plain
pointers. So far the probes worked nicely and helped us a lot to cleanup
the code base.

If this is not supported, please make ipipe depend on !CONFIG_TRACEPOINTS. =
:-(

Thanks,
//richard

