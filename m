References: <CAK6DXL0YMe5o+Q6cr2Z5axY3XVVdd=ZUmV=HNR-EbStYfTAYSw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Lowest latency skin
In-reply-to: <CAK6DXL0YMe5o+Q6cr2Z5axY3XVVdd=ZUmV=HNR-EbStYfTAYSw@mail.gmail.com>
Date: Mon, 19 Apr 2021 11:09:30 +0200
Message-ID: <87eef663p1.fsf@xenomai.org>
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
To: Marco Barletta <barlettamarco8@gmail.com>
Cc: xenomai@xenomai.org


Marco Barletta via Xenomai <xenomai@xenomai.org> writes:

> Hi everyone, I finally managed to run correctly Xenomai with acceptable
> latencies (kernel 5.4.77 w ipipe patch2, linux Mint x86_64). Now I'm
> starting to write some simple programs in order to practice. Is there an
> API with lower latencies that I should use or it's just the same? I
> programmed with RTAI API so the native API is quite familiar to me.
> Best regards.

With Xenomai 3.x, the POSIX API delivers lower latency figures than
others: no intermediate layer there between the API and the core. We
should be talking about only a handful of =C2=B5secs better in non-debug
mode, though.

--=20
Philippe.

