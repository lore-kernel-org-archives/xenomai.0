Message-ID: <52e18582a48da6c08ed88bbce325aed8.squirrel@domain.hid>
In-Reply-To: <491805AE.1060809@domain.hid>
References: <491805AE.1060809@domain.hid>
Date: Mon, 10 Nov 2008 12:42:00 +0100 (CET)
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Mode switch when using RT heap on ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>


Wolfgang Grandegger wrote:
> Hello,
>
> I realized that accessing memory allocated with rt_heap_alloc() causes
> mode switches on ARM i.mx31. The attached patch provides a demo program
> to demonstrate the problem, which actually does *not* show up on my
> PowerPC TQM5200 board.

On ARM, we normally map the heaps uncacheable, this should not be
necessary on ARMv6, but I am afraid we then get the fault on first access.

-- 
                    Gilles.


