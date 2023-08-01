Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AB24DC77
	for <xenomai@lists.linux.dev>; Tue,  1 Aug 2023 20:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 23CA663577DD;
	Tue,  1 Aug 2023 22:49:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id R5TAQasAlr2Q; Tue,  1 Aug 2023 22:49:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A64E163577E2;
	Tue,  1 Aug 2023 22:49:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HwS6ohfc9Egw; Tue,  1 Aug 2023 22:49:49 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8527163577D8;
	Tue,  1 Aug 2023 22:49:49 +0200 (CEST)
Date: Tue, 1 Aug 2023 22:49:49 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1904879955.1621501.1690922989393.JavaMail.zimbra@nod.at>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v3-7-2aea39ad909a@siemens.com>
References: <20230630-florian-y2038-part-four-upstreaming-v3-0-2aea39ad909a@siemens.com> <20230630-florian-y2038-part-four-upstreaming-v3-7-2aea39ad909a@siemens.com>
Subject: Re: [PATCH v3 7/7] include/rtdm/serial.h: Fix compat support of
 struct rtser_config
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: include/rtdm/serial.h: Fix compat support of struct rtser_config
Thread-Index: iF48FRvJH8jRhe51vugQUJKw7nKXgg==

----- Urspr=C3=BCngliche Mail -----
> Von: "Florian Bezdeka" <florian.bezdeka@siemens.com>
> An: "xenomai" <xenomai@lists.linux.dev>, "Jan Kiszka" <jan.kiszka@siemens=
.com>
> CC: "Florian Bezdeka" <florian.bezdeka@siemens.com>, "richard" <richard@n=
od.at>
> Gesendet: Dienstag, 1. August 2023 11:29:41
> Betreff: [PATCH v3 7/7] include/rtdm/serial.h: Fix compat support of stru=
ct rtser_config

> This is a backward compatibility breaking change for compat (32 bit)
> applications. We already bumped the ABI revision so we already force
> recompiling all applications.
>=20
> On 32bits:
> struct rtser_config {
>        int                        config_mask;          /*     0     4 */
>        int                        baud_rate;            /*     4     4 */
>        int                        parity;               /*     8     4 */
>        int                        data_bits;            /*    12     4 */
>        int                        stop_bits;            /*    16     4 */
>        int                        handshake;            /*    20     4 */
>        int                        fifo_depth;           /*    24     4 */
>        int                        reserved;             /*    28     4 */
>        nanosecs_rel_t             rx_timeout;           /*    32     8 */
>        nanosecs_rel_t             tx_timeout;           /*    40     8 */
>        nanosecs_rel_t             event_timeout;        /*    48     8 */
>        int                        timestamp_history;    /*    56     4 */
>        int                        event_mask;           /*    60     4 */
>        /* --- cacheline 1 boundary (64 bytes) --- */
>        int                        rs485;                /*    64     4 */
>=20
>        /* size: 68, cachelines: 2, members: 14 */
>        /* last cacheline: 4 bytes */
> } __attribute__((__packed__));
>=20
> Note: I don't know why pahole reports this struct as packed. It is not.
>=20
> and 64:
> struct rtser_config {
>        int                        config_mask;          /*     0     4 */
>        int                        baud_rate;            /*     4     4 */
>        int                        parity;               /*     8     4 */
>        int                        data_bits;            /*    12     4 */
>        int                        stop_bits;            /*    16     4 */
>        int                        handshake;            /*    20     4 */
>        int                        fifo_depth;           /*    24     4 */
>        int                        reserved;             /*    28     4 */
>        nanosecs_rel_t             rx_timeout;           /*    32     8 */
>        nanosecs_rel_t             tx_timeout;           /*    40     8 */
>        nanosecs_rel_t             event_timeout;        /*    48     8 */
>        int                        timestamp_history;    /*    56     4 */
>        int                        event_mask;           /*    60     4 */
>        /* --- cacheline 1 boundary (64 bytes) --- */
>        int                        rs485;                /*    64     4 */
>=20
>        /* size: 72, cachelines: 2, members: 14 */
>        /* padding: 4 */
>        /* last cacheline: 8 bytes */
> };
>=20
> While nanosecs_rel_t is in both case int64_t, gcc adds different tail pad=
ding to
> the struct.
>=20
> Link:
> https://lore.kernel.org/all/601440741.237005.1668456855365.JavaMail.zimbr=
a@nod.at/
> Reported-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
