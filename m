Date: Mon, 10 Aug 2020 01:45:53 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <166391923.711496.1597041953464.JavaMail.zimbra@wolfram.com>
In-Reply-To: <20200807171220.E090CB18@centrum.cz>
References: <20200807171220.E090CB18@centrum.cz>
Subject: Re: Posix periodic time first tick
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
Cc: Petr =?utf-8?Q?=C4=8Cervenka?= <grugh@centrum.cz>

----- Den 7 aug 2020, p=C3=A5 kl 17:12, xenomai xenomai@xenomai.org skrev:

> Hello.
> I have created small example of periodic task in posix.
> If I compile it without xenomai it works fine.
> When I add Xenomai linking flags, the first tick of periodic task take ar=
ound
> 16s. After that it continues as it should.
> Used clock type for timer_fd is CLOCK_MONOTONIC. The example should in
> attachment.
> Do you have any suggestions?

Just had a extremely quick look at it. Are you sure you don't get any round=
ing errors when doing your period arithmetics ?=20

> Best regards
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: timer_test.cpp
> Type: text/x-c++src
> Size: 4351 bytes
> Desc: timer_test.cpp
> URL:
> <http://xenomai.org/pipermail/xenomai/attachments/20200807/d4203f59/attac=
hment.cpp>

Per =C3=96berg=20

