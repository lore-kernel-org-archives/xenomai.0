References: <a92cf71bb68a9e0701fcd6de46055eb7f584136a.camel@siemens.com>
 <745119239ef0a715f703f8315befc79ee34d0511.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Dovetail 5.10 - Xenomai huge page support
Date: Thu, 20 Jan 2022 09:32:35 +0100
In-reply-to: <745119239ef0a715f703f8315befc79ee34d0511.camel@siemens.com>
Message-ID: <87sftig62e.fsf@xenomai.org>
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
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>


"Bezdeka, Florian" <florian.bezdeka@siemens.com> writes:

> On Wed, 2022-01-19 at 13:35 +0000, Bezdeka, Florian via Xenomai wrote:
>> Hi all,
>>=20
>> after migrating from 4.19-ipipe to 5.10-dovetail internal users are
>> reporting that they receive sporadic SIGXCPUs. The reported reason is
>> "page_fault_user".=C2=A0
>>=20
>> After disabling the huge page support in 5.10 the issue vanished. Tests
>> are still running, but we are optimistic that we found the root cause.
>>=20
>> Are there any known limitations to the huge page support in Xenomai /
>> Dovetail? My understanding is that huge pages are supported by Xenomai,
>> so any ideas where to look at?
>
> [1] is part of the 5.15-rebased dovetail branch but not part of the
> 5.10-rebase branch and mentions huge page handling. Could that be
> related? Maybe this patch is not 5.15 specific?
>

It is not 5.15 specific. The same logic would apply to 5.10.

> [1] https://source.denx.de/Xenomai/linux-dovetail/-/commit/b0a4f4c3891949=
d079aa3d65f2a56428a67e580c
>
>>=20
>> Best regards,
>> Florian


--=20
Philippe.

