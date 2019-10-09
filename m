From: steven.seeger flightsystems.net <steven.seeger@flightsystems.net>
Subject: Re: [PATCH] arm64/ipipe: Add support for userspace return notifier
Date: Wed, 9 Oct 2019 05:24:06 +0000
Message-ID: <7592635.y4qTbfG8Aa@omoikane>
References: <e8d943ee-1103-07ec-bede-c36b4a06c745@siemens.com>
 <1692186.oXRrdl6OMX@omoikane>
 <1b138a5d-3b5f-07da-6f22-8ce74a04df93@siemens.com>
In-Reply-To: <1b138a5d-3b5f-07da-6f22-8ce74a04df93@siemens.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D20A8C73E82FE4BBBCE5C0434E6B9DF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

On Wednesday, October 9, 2019 1:22:14 AM EDT Jan Kiszka wrote:
> When __ipipe_notify_user_intreturn returns 0, we go back to
> ret_to_user_noirq, and that checks again. I think I inverted the jump
> ordering here, compared to ARM.

That makes sense. I think when I reviewed your patch I assumed that=20
ret_to_user_noirq was the direct exit path. That was actually the first tim=
e I=20
ever looked at that file ;)

Steven




