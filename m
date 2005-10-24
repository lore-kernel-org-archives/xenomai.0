Message-ID: <435D4572.10805@domain.hid>
Date: Mon, 24 Oct 2005 22:34:58 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] problem and solution
	with	adeos-ipipe-2.6.13-ppc-1.0-03.patch
References: <1CFEB358338412458B21FAA0D78FE86D4F0E3F@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0E3F@rennsmail02.eu.thmulti.com>
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
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Hi,
> 
> The adeos-ipipe-2.6.13-ppc-1.0-03.patch file in Xenomai-2.0 dist appears
> to be broken. The unified diff format is wrong on
> include/asm-ppc/ipipe.h,
> which breaks include/asm-ppc/mmu_context.h. I've found the problem while
> 
> applying the patch on a Linux 2.6.13 kernel.
> Line 1664 (no pun :), instead of @@ -0,1 +1,178 @@, the following solves
> the problem here: @@ -0,0 +1,177 @@
> 

Gahh... Ok.

> Does somebody else encountered the problem?
> 
> 
> For the record, here is for 2.6.13-ppc-1.0-03 the result of klatency, 
> with only calibrator as a load generator.
> 
> KLATENCY with load:
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|
> RTS|       -7350|       -5715|        6420|       0|    00:03:17 1.0-00
> RTS|       -6150|       -4384|       12180|       0|    00:03:13 1.0-01
> RTS|       -6150|       -4183|       12480|       0|    00:03:38 1.0-02
> RTS|       -6120|       -4447|        8370|       0|    00:03:47 1.0-02+
> RTS|       -6210|       -5381|       12390|       0|    00:03:38 1.0-03
> 

Ok, I need to check some changes between -02 and -03 before sending -04 out.

-- 

Philippe.

