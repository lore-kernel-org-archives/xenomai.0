References: <a92cf71bb68a9e0701fcd6de46055eb7f584136a.camel@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Dovetail 5.10 - Xenomai huge page support
Date: Thu, 20 Jan 2022 09:30:07 +0100
In-reply-to: <a92cf71bb68a9e0701fcd6de46055eb7f584136a.camel@siemens.com>
Message-ID: <87wniug63q.fsf@xenomai.org>
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

> Hi all,
>
> after migrating from 4.19-ipipe to 5.10-dovetail internal users are
> reporting that they receive sporadic SIGXCPUs. The reported reason is
> "page_fault_user".=C2=A0
>
> After disabling the huge page support in 5.10 the issue vanished. Tests
> are still running, but we are optimistic that we found the root cause.
>
> Are there any known limitations to the huge page support in Xenomai /
> Dovetail? My understanding is that huge pages are supported by Xenomai,
> so any ideas where to look at?
>

No limitation intended or known, however the recent change in the
Dovetail implement you mention in your next post may help addressing the
issue indeed by disabling COW for huge pages too, which was missing so
far.

--=20
Philippe.

