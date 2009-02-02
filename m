Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 2 Feb 2009 22:56:37 -0000
Message-ID: <4B3F8896E1733D4787DDB0EA1C7FF91F6B572E@ukmail.uk.wirelessworld.airvananet.com>
From: "Mike McTernan" <mmcternan@domain.hid>
Subject: [Xenomai-help] pthread_cond_init() returns ENOMEM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I'm trying to port a large complex app to Xenomai using the POSIX skin,
and so far so good!

But I've found pthread_cond_init() it reporting ENOMEM to a userspace
app.  Looking back up the sources I think this maybe because
xnheap_alloc() is exhausted in the kernel.

I'm using the Xenomai VMware image from
http://www.cs.ru.nl/lab/xenomai/, it's version 2.4.3.  Do I need to
update, or is there a way I can increase the heap? =20

I can't see how to do it from the docs, please point me in the right
direction.

Kind Regards,

Mike


