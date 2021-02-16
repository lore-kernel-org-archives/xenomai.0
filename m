References: <18fee8f3-6d25-0e71-5f7d-737c3c34b293@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] mercury: Fix include path for cobalt/wrapper.h
In-reply-to: <18fee8f3-6d25-0e71-5f7d-737c3c34b293@siemens.com>
Date: Tue, 16 Feb 2021 10:20:34 +0100
Message-ID: <87pn10id25.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>, "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Long broken, likely not practically relevant. But now that we known it,
> let's fix it: There is no mercury/wrapper.h, but we have that file under
> mercury/copperplate.
>

A better fix would be to drop copperplate/wrappers.h. This is an
internal header, which has no in-tree user. This explains why Mercury
builds flawlessly even if that file would attempt to pull in a
non-existent header.

-- 
Philippe.

