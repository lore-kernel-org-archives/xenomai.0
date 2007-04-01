Message-ID: <2a9546e00704010206n6805c8a7v5127de16512019c5@domain.hid>
Date: Sun, 1 Apr 2007 14:36:22 +0530
From: "sanjeev sharma" <sanjeevsharmaengg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_59453_1986480.1175418382043"
Subject: [Xenomai-help] Error while creating shared library for mips
	Architecture
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

------=_Part_59453_1986480.1175418382043
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,

we are trying to build Xenomai for mips Architecure from x86 host.we used an
MIPS cross-compiler and 2.6. kernel.

while configuring and building for mips architecture it not creating shared
library.

the configuration option i am passing.

./configure --host=mips --prefix=/opt --enable-shared CC=mips2_fp_be-gcc

After configuring it creating libtool executable in which  there is an
macro        build_libtool_libs=no

after passing --enable-shared it doesnot change.

when we do make install it creates only static library.not shared library.


could you help me out of this issue.

Thanks and Regards
sanjeev

------=_Part_59453_1986480.1175418382043
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,<br><br>we are trying to build Xenomai for mips Architecure from x86 host.we used an<br>MIPS cross-compiler and 2.6. kernel.<br><br>while configuring and building for mips architecture it not creating shared<br>library.
<br><br>the configuration option i am passing.<br><br>./configure --host=mips --prefix=/opt --enable-shared CC=mips2_fp_be-gcc<br><br>After configuring it creating libtool executable in which &nbsp;there is an<br>macro &nbsp; &nbsp; &nbsp; &nbsp;build_libtool_libs=no
<br><br>after passing --enable-shared it doesnot change.<br><br>when we do make install it creates only static library.not shared library.<br><br><br>could you help me out of this issue.<br><br>Thanks and Regards<br>sanjeev
<br>

------=_Part_59453_1986480.1175418382043--

