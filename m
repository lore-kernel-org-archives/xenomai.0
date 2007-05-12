Message-ID: <3f027d060705120736h73663da1v9bcf819f6c7452f9@domain.hid>
Date: Sat, 12 May 2007 16:36:27 +0200
From: "Zany Super Chimp" <zanychimp@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_107775_32045014.1178980587591"
Subject: [Xenomai-help] Problem compiling kernel-2.6.20-11-ipipe
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

------=_Part_107775_32045014.1178980587591
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi !

I just configured my kernel with the prepare-kernel script:

sudo ./scripts/prepare-kernel.sh
--linux=/usr/src/linux-2.6.20.11-ipipe--adeos=~/xenomai/src/ksrc
/arch/i386/patches/adeos-ipipe-2.6.20-i386-1.8-00.patch --arch=i386


When I make all, I get the following error:

  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  AS      arch/i386/kernel/entry.o
arch/i386/kernel/entry.S: Assembler messages:
arch/i386/kernel/entry.S:270: Error: invalid character '_' in mnemonic
arch/i386/kernel/entry.S:347: Error: invalid character '_' in mnemonic
arch/i386/kernel/entry.S:477: Error: invalid character '_' in mnemonic
arch/i386/kernel/entry.S:520: Error: invalid character '_' in mnemonic
arch/i386/kernel/entry.S:534: Error: invalid character '_' in mnemonic
make[1]: *** [arch/i386/kernel/entry.o] Error 1
make: *** [arch/i386/kernel] Error 2

I'm using gcc 4.1.2 and GNU assembler 2.17.50 on Ubuntu 7.04. Maybe it is
the problem...

 Did someone already stumble over that problem ?

Best regards,

--Zany

------=_Part_107775_32045014.1178980587591
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi !<br><br>I just configured my kernel with the prepare-kernel script:<br><br>sudo ./scripts/prepare-kernel.sh --linux=/usr/src/linux-2.6.20.11-ipipe --adeos=~/xenomai/src/ksrc<div id="mb_0">/arch/i386/patches/adeos-ipipe-2.6.20-i386-1.8-00.patch

 --arch=i386<br><br><br>When I make all, I get the following error:<br><br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/version.h<br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/utsrelease.h<br>&nbsp; CHK&nbsp;&nbsp;&nbsp;&nbsp; include/linux/compile.h<br>&nbsp; AS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arch/i386/kernel/entry.o
<br>arch/i386/kernel/entry.S: Assembler messages:<br>arch/i386/kernel/entry.S:270: Error: invalid character &#39;_&#39; in mnemonic<br>arch/i386/kernel/entry.S:347: Error: invalid character &#39;_&#39; in mnemonic<br>arch/i386/kernel/entry.S:477: Error: invalid character &#39;_&#39; in mnemonic
<br>arch/i386/kernel/entry.S:520: Error: invalid character &#39;_&#39; in mnemonic<br>arch/i386/kernel/entry.S:534: Error: invalid character &#39;_&#39; in mnemonic<br>make[1]: *** [arch/i386/kernel/entry.o] Error 1<br>make: *** [arch/i386/kernel] Error 2
<br><br>I&#39;m using gcc 4.1.2 and GNU assembler 2.17.50 on Ubuntu 7.04. Maybe it is the problem...<br><br>&nbsp;Did someone already stumble over that problem ? <br><br>Best regards,<br><span class="sg"><br>--Zany</span></div>

------=_Part_107775_32045014.1178980587591--

