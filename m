Message-ID: <48BE51D8.4040308@domain.hid>
Date: Wed, 03 Sep 2008 10:59:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <491471.74668.qm@domain.hid>
In-Reply-To: <491471.74668.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RT_HEAP Problem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: yasser_kashfi@domain.hid
Cc: xenomai@xenomai.org

Yasser Kashfi wrote:
> <5>119MB HIGHMEM available.
> <5>896MB LOWMEM available.

This kernel has still some highmem, so it was not compiled with
CONFIG_VMSPLIT_3G_OPT.

-- 
                                                 Gilles.

