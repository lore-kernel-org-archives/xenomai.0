Message-ID: <6132061f0804082052u67797b3x422ac1b7258401e3@domain.hid>
Date: Wed, 9 Apr 2008 00:52:10 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22871_30144086.1207713130662"
Subject: [Xenomai-help] Xenomai Patching Problem
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

------=_Part_22871_30144086.1207713130662
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all, I'm trying to embed the
linux-2.6.24 with xenomai-2.4.3 on powerpc processor. Although when I try
to execute
/scripts/prepare-kernel.sh on xenomai directory I unfortunately get the
message at the end :

patching file Makefile
patching file arch/powerpc/Kconfig
patching file arch/powerpc/boot/Makefile
patching file arch/powerpc/kernel/Makefile
patching file arch/powerpc/kernel/asm-offsets.c
patching file arch/powerpc/kernel/cputable.c
Hunk #1 succeeded at 1333 (offset -79 lines).
Hunk #2 succeeded at 1380 (offset -79 lines).
patching file arch/powerpc/kernel/entry_32.S

......

Unable to patch kernel 2.6.24.4 with adeos-ipipe....

Have you seen this problem? Could you give me some tips?

Thanks,

Breno

------=_Part_22871_30144086.1207713130662
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<pre>Hi all, I&#39;m trying to embed the<br>linux-2.6.24 with xenomai-2.4.3 on powerpc processor. Although when I try<br>to execute<br>/scripts/prepare-kernel.sh on xenomai directory I unfortunately get the<br>message at the end :<br>
<br>patching file Makefile<br>patching file arch/powerpc/Kconfig<br>patching file arch/powerpc/boot/Makefile<br>patching file arch/powerpc/kernel/Makefile<br>patching file arch/powerpc/kernel/asm-offsets.c<br>patching file arch/powerpc/kernel/cputable.c<br>
Hunk #1 succeeded at 1333 (offset -79 lines).<br>Hunk #2 succeeded at 1380 (offset -79 lines).<br>patching file arch/powerpc/kernel/entry_32.S<br><br>......<br><br>Unable to patch kernel <a href="http://2.6.24.4">2.6.24.4</a> with adeos-ipipe....<br>
<br>Have you seen this problem? Could you give me some tips?<br><br>Thanks,<br><br>Breno<br></pre>

------=_Part_22871_30144086.1207713130662--

