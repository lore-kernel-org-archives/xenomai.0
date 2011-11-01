MIME-Version: 1.0
From: =?UTF-8?Q?=C5=81ukasz_Sacha?= <dragilla@domain.hid>
Date: Tue, 1 Nov 2011 12:34:20 +0100
Message-ID: <CAAeYjMko1nqaFX4xvL_j9GoS_wT5SxOFtCjfLgN8T=CGrL2Cvw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] kernel compilation error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello again:

luke@domain.hid$ make ARCH=3Darm
CROSS_COMPILE=3Darm-none-linux-gnueabi-
...
  CC      arch/arm/kernel/fiq.o
arch/arm/kernel/fiq.c: In function 'set_fiq_handler':
arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incomplete type
arch/arm/kernel/fiq.c:87: error: dereferencing pointer to incomplete type
arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incomplete type
arch/arm/kernel/fiq.c:89: error: dereferencing pointer to incomplete type
make[1]: *** [arch/arm/kernel/fiq.o] Error 1
make: *** [arch/arm/kernel] Error 2
luke@domain.hid$

This is how it looks like
80:void set_fiq_handler(void *start, unsigned int length)
81:{
82:#if defined(CONFIG_CPU_USE_DOMAINS)
83:        memcpy((void *)0xffff001c, start, length);
84:#else
85:        memcpy(vectors_page + 0x1c, start, length);
86:#endif
87:        flush_icache_range(0xffff001c, 0xffff001c + length);
88:        if (!vectors_high())
89:                flush_icache_range(0x1c, 0x1c + length);
90:}

Any ideas?
--
=C5=81ukasz Dragilla Sacha

