Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Dec 2007 15:40:11 +0100
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7A4AB2E2@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-help] RTDM mmap and DMA
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Perrine Martignoni wrote:
> I don't know how memory heaps really work but it seems that memory
heaps are shared between user and kernel spaces.
> So, if I do like this I don't need mmap, am I wrong ?

Indeed. rt_heap's take care of mmap'ing as long as the H_MAPPABLE is
set.

http://www.xenomai.org/documentation/trunk/html/api/group__native__heap.
html

>How is done the DMA transfer after ?

You're the only one who knows how to program your DMA (i.e. read your
chip reference
manual). Generally, embedded DMA only "speak" physical addresses. Hence
the patch
sent previously in this discussion.
--=20
Stephane

