Message-ID: <455AC0EA.9000001@domain.hid>
Date: Wed, 15 Nov 2006 08:25:30 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] RT-Socket-CAN, TX loopback and further
	improvements
References: <4559D38C.2080001@domain.hid>
	<4559DA0E.7060406@domain.hid> <455A02AD.9000403@domain.hid>
In-Reply-To: <455A02AD.9000403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Jan,

Jan Kiszka wrote:
> Hi Wolfgang,
[...deletions...]

> Last remark: For the sake of completeness, tx-loopback should also be
> implemented in the virtual CAN driver.

The virtual CAN driver already works like TX loopback. It routes TX 
messages to local foreign sockets (but without sending them to any bus).

Wolfgang.

