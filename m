MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Sep 2014 11:25:30 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <540D4E9A.4090203@siemens.com>
References: <540D4E9A.4090203@siemens.com>
Message-ID: <5d07f986ca9ee2f6e65fe10f16a1bf29@grandegger.com>
Subject: Re: [Xenomai]
	=?utf-8?q?Flexcan_driver_build_broken_since_3=2E11_-_al?=
	=?utf-8?q?so_in_upstream=3F?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, 08 Sep 2014 08:37:14 +0200, Jan Kiszka <jan.kiszka@siemens.com>
wrote:
> Hi all,
> 
> just noticed a build breakage in Xenomai 2: ksrc/drivers/can/flexcan.c
> is looking for linux/can/platform/flexcan.h which was removed in
> baffd2e8d9. But both the Xenomai driver and upstream's flexcan.c still
> use the flexcan_platform_data structure which I do not find anywhere in
> the kernel. Does anyone know what happened there?

I just cloned Linus's kernel tree and do *not* see that any CAN driver is
still including "linux/can/platform/flexcan":

$ grep -r '/platform/flexcan.h' linux/drivers/net/can/
$

Will have a closer look later today.

Wolfgang.


