Message-ID: <4CBD7182.2050500@domain.hid>
Date: Tue, 19 Oct 2010 12:22:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C00C@rennsmail06.eu.thmulti.com>
	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C00E@rennsmail06.eu.thmulti.com>
	<4CB57DB2.3010709@domain.hid>
	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C010@domain.hid>
	<4CB5A7DD.9090203@domain.hid>
	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C011@domain.hid>
	<4CB78450.70204@domain.hid>
	<DF9F3A3C150B0646A17FF1487C1B6D5E0380C01F@rennsmail06.eu.thmulti.com>
In-Reply-To: <DF9F3A3C150B0646A17FF1487C1B6D5E0380C01F@rennsmail06.eu.thmulti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_heap and DMA32 zone
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Daniel Jacques (Alten)" <jacques.daniel@domain.hid>
Cc: xenomai@xenomai.org

Daniel Jacques (Alten) wrote:
> Hi,
> 
> I noticed some allocation failure using kmalloc in case of GFP_DMA32 with big size, even if I modified the CONFIG_FORCE_MAX_ZONEORDER to be coherent with my max size (32MB).
> I don't know the reason of this failure. I am interesting by any idea about this point ...
> Meanwhile, to avoid this trouble I performed the following additional patch in ksrc/nucleus/heap.c to force using of __get_free_pages instead of kmalloc in case of GFP_DMA32 flag.
> Jacques

At this point, the problem seems to be in linux code. So, there should
be no need to modify xenomai code. Are you sure that kmalloc does not
fail due to fragmentation?

-- 
					    Gilles.

