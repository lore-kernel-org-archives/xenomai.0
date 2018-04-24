From: Gustav Johansson <gusjohan@kth.se>
Date: Tue, 24 Apr 2018 12:38:06 +0000
Message-ID: <1524573484592.16072@kth.se>
Content-Language: en-GB
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Illegal instruction/bad syscall
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

Hi!


I recently managed to run a cobalt core for raspberry pi 3, Im using ipipe =
#9 for arm,  kernel version 4.1.21, Xenomai 3.0.6.


I managed to build the xenomai API but when I try every executable file, fo=
r example latency test bench,  I get "illegal instruction", and in dmesg I =
get "[Xenomai] bad syscall <0xff7000af> ...".


The crosscompiler Im using is https://github.com/raspberrypi/tools/tree/mas=
ter/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian and I have also tri=
ed compiling it on the RPI3 itself but Im getting the same error.


I have compared my kernel config next to Harco Kuppens  working image (http=
://www.cs.ru.nl/lab/xenomai/) But the only difference is that I have higher=
 values in XENO_OPT_SYS_HEAP, XENO_PRIVATE_HEAPS, XENO_OPT_SHARED_HEAPSZ, X=
ENO_OPT_TIMERS.


Im uploading a readme with the steps I have taken with the installation and=
 also my kernel config.


Any ideas on why I get "Illegal instruction"?


Regards

Gustav Johansson

-------------- next part --------------
A non-text attachment was scrubbed...
Name: rpi3_cobalt_4.1.21_config
Type: application/octet-stream
Size: 126604 bytes
Desc: rpi3_cobalt_4.1.21_config
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180424/fd49797a/at=
tachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: readme.md
Type: text/markdown
Size: 6403 bytes
Desc: readme.md
URL: <http://xenomai.org/pipermail/xenomai/attachments/20180424/fd49797a/at=
tachment.bin>
