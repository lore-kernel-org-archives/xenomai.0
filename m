Message-ID: <142859.29324.qm@domain.hid>
Date: Mon, 24 Aug 2009 22:01:14 -0700 (PDT)
From: David Tao <david_xtao@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1004941763-1251176474=:29324"
Subject: [Xenomai-help] arch/arm/kernel/ipipe.c:421: error: implicit
	declaration of function '__ipipe_mach_irq_mux_p'
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--0-1004941763-1251176474=:29324
Content-Type: text/plain; charset=us-ascii

Hi,

I run into a build error when compiling ipipe.c as follows:

  CC      arch/arm/kernel/ipipe.o
 arch/arm/kernel/ipipe.c: In function '__ipipe_grab_irq':
arch/arm/kernel/ipipe.c:421: error: implicit declaration of function '__ipipe_mach_irq_mux_p'
make[1]: *** [arch/arm/kernel/ipipe.o] Error 1
make: *** [arch/arm/kernel] Error 2

Kernel: 2.6.26
Adeos patch:  adeos-ipipe-2.6.26-arm-1.12-00.patch
Xenomai: 2.4.7, and 2.4.8
Tool chain: Denx 4.2 for arm
Target CPU: iMX25

googling around find no such reports.

Any help is highly appreciated.

Best regards,
David



      
--0-1004941763-1251176474=:29324
Content-Type: text/html; charset=us-ascii

<html><head><style type="text/css"><!-- DIV {margin:0px;} --></style></head><body><div style="font-family:'times new roman', 'new york', times, serif;font-size:12pt"><div>Hi,</div><div><br></div><div>I run into a build error when compiling ipipe.c as follows:</div><div><br></div><div><div>&nbsp;&nbsp;CC &nbsp; &nbsp; &nbsp;arch/arm/kernel/ipipe.o</div><div>&nbsp;arch/arm/kernel/ipipe.c: In function '__ipipe_grab_irq':</div><div>arch/arm/kernel/ipipe.c:421: error: implicit declaration of function '__ipipe_mach_irq_mux_p'</div><div>make[1]: *** [arch/arm/kernel/ipipe.o] Error 1</div><div>make: *** [arch/arm/kernel] Error 2</div><div><br></div><div>Kernel: 2.6.26</div><div>Adeos patch: &nbsp;adeos-ipipe-2.6.26-arm-1.12-00.patch</div><div>Xenomai: 2.4.7, and 2.4.8</div><div>Tool chain: Denx 4.2 for arm</div><div>Target CPU: iMX25</div><div><br></div><div>googling around find no such reports.</div><div><br></div><div>Any help is highly
 appreciated.</div><div><br></div><div>Best regards,</div><div>David</div><div><br></div></div><div style="position:fixed"></div></div><br>

      </body></html>
--0-1004941763-1251176474=:29324--

