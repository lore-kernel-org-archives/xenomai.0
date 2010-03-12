Message-ID: <4B9A4C6A.1010600@domain.hid>
Date: Fri, 12 Mar 2010 15:15:06 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1DE138B7F8CE402AB05AC211D832BE49@domain.hid>
In-Reply-To: <1DE138B7F8CE402AB05AC211D832BE49@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Testsuite syntax error on Virtex5 PPC440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alessandro Avanzi <a.avanzi@domain.hid>
Cc: xenomai@xenomai.org

Alessandro Avanzi wrote:
> Hello. I installed Xenomai kernel support on the 2.6.32.3 kernel provided by
> Xilinx using a mod. DENX patch. Then I installed the user support on a ramdisk,
> and packed the kernel, the ramdisk and the device tree all togheter in an .elf file
> to be dowloaded on the board (based on Xilinx Virtex5 FXT with PPC440).
> At booting I got the following  

What version of Xenomai? What shell are you using? If using busybox, you
should select the "ash" shell. It is the most compatible with POSIX sh,
and is supposed to work. If you want to use another shell, then do not
try and use Xenomai scripts, run the binaries directly.

-- 
					    Gilles.

