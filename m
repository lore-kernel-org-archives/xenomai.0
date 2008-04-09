MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18428.57314.689407.926229@domain.hid>
Date: Wed, 9 Apr 2008 17:25:22 +0200
In-Reply-To: <6132061f0804082052u67797b3x422ac1b7258401e3@domain.hid>
References: <6132061f0804082052u67797b3x422ac1b7258401e3@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Xenomai Patching Problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Breno Carneiro Pinheiro <brenodee@domain.hid>
Cc: xenomai@xenomai.org

Breno Carneiro Pinheiro wrote:
 > Hi all, I'm trying to embed the
 > linux-2.6.24 with xenomai-2.4.3 on powerpc processor. Although when I try
 > to execute
 > /scripts/prepare-kernel.sh on xenomai directory I unfortunately get the
 > message at the end :
 > 
 > patching file Makefile
 > patching file arch/powerpc/Kconfig
 > patching file arch/powerpc/boot/Makefile
 > patching file arch/powerpc/kernel/Makefile
 > patching file arch/powerpc/kernel/asm-offsets.c
 > patching file arch/powerpc/kernel/cputable.c
 > Hunk #1 succeeded at 1333 (offset -79 lines).
 > Hunk #2 succeeded at 1380 (offset -79 lines).
 > patching file arch/powerpc/kernel/entry_32.S
 > 
 > ......
 > 
 > Unable to patch kernel 2.6.24.4 with adeos-ipipe....
 > 
 > Have you seen this problem? Could you give me some tips?

The way you flood us with your question will not make us answer it any
faster. I do not know the answer to your question (which is why I did
not answer you), but it seems pretty obvious that you are not patching
the right kernel. Have you read ksrc/arch/powperpc/patches/README to
know what kernel you are supposed to patch ?

-- 


					    Gilles.

