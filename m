MIME-Version: 1.0
Date: Wed, 23 Mar 2011 11:40:08 +0800
Message-ID: <AANLkTimFAxy81d7NErKOT0S4esN20DtQbUu4d42K4_8s@domain.hid>
From: alamo hwuang <lovealamo@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd379e004680b049f1e1e6a
Subject: [Xenomai-core] Help: What is this in xenomai? rtheap crash?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd379e004680b049f1e1e6a
Content-Type: text/plain; charset=ISO-8859-1

Hello , I am a new bird using the xemomai! I use my classmate program to run
on the xenomai and I got the below information .It seems that the rtheap
crash ??


How can I solve this problem ????

the xenomai is 2.5.4 and the kernel is 2.6.34.5.





thanks for your help.

linux-xkps1:~/Desktop/linux # Bin/APP_LTE_DEMO config.txt
Noise Generated
*** glibc detected *** Bin/APP_LTE_DEMO: malloc(): memory corruption:
0x00000000176fbba0 ***
======= Backtrace: =========
/lib64/libc.so.6(+0x75018)[0x7f6ae8eb6018]
/lib64/libc.so.6(+0x77f7f)[0x7f6ae8eb8f7f]
/lib64/libc.so.6(__libc_malloc+0x77)[0x7f6ae8ebb057]
Bin/APP_LTE_DEMO[0x41f284]
/usr/xenomai/lib/libnative.so.3(+0x728c)[0x7f6ae961328c]
/lib64/libpthread.so.0(+0x75f0)[0x7f6ae981e5f0]
/lib64/libc.so.6(clone+0x6d)[0x7f6ae8f1584d]
======= Memory map: ========
00400000-0052f000 r-xp 00000000 08:05 8986626
/root/linux/Bin/APP_LTE_DEMO
0072e000-0072f000 r--p 0012e000 08:05 8986626
/root/linux/Bin/APP_LTE_DEMO
0072f000-00761000 rw-p 0012f000 08:05 8986626
/root/linux/Bin/APP_LTE_DEMO
00761000-15833000 rw-p 00000000 00:00 0
176d2000-1771c000 rw-p 00000000 00:00 0
[heap]
7f6ab4000000-7f6ab4021000 rw-p 00000000 00:00 0
7f6ab4021000-7f6ab8000000 ---p 00000000 00:00 0
7f6abb491000-7f6abb492000 ---p 00000000 00:00 0
7f6abb492000-7f6abf492000 rw-p 00000000 00:00 0
7f6abf492000-7f6abf854000 rw-s 00000000 00:0e 2199
/dev/rtheap
7f6abf854000-7f6abf855000 ---p 00000000 00:00 0
7f6abf855000-7f6ac3855000 rw-p 00000000 00:00 0
7f6ac3855000-7f6ac444c000 rw-s 00000000 00:0e 2199
/dev/rtheap
7f6ac444c000-7f6ac5043000 rw-s 00000000 00:0e 2199
/dev/rtheap
7f6ac5043000-7f6ac5c3a000 rw-s 00000000 00:0e 2199
/dev/rtheap
7f6ac5c3a000-7f6ac6831000 rw-s 00000000 00:0e 2199
/dev/rtheap
7f6ac6831000-7f6ac6bf3000 rw-s 00000000 00:0e 2199
/dev/rtheap
7f6ac6bf3000-7f6ac6fb5000 rw-s 00000000 00:0e 2199
/dev/rtheap
7f6ac6fb5000-7f6ac7377000 rw-s 00000000 00:0e 2199
/dev/rtheap
7f6ac7377000-7f6ac7378000 ---p 00000000 00:00 0
7f6ac7378000-7f6acb378000 rw-p 00000000 00:00 0
7f6acb378000-7f6acb379000 ---p 00000000 00:00 0
7f6acb379000-7f6acb479000 rw-p 00000000 00:00 0
7f6acb479000-7f6acb47a000 ---p 00000000 00:00 0
7f6acb47a000-7f6acb57a000 rw-p 00000000 00:00 0
7f6acb57a000-7f6acb57b000 ---p 00000000 00:00 0
7f6acb57b000-7f6acb67b000 rw-p 00000000 00:00 0
7f6acb67b000-7f6acb67c000 ---p 00000000 00:00 0
7f6acb67c000-7f6ae8c3d000 rw-p 00000000 00:00 0
7f6ae8c3d000-7f6ae8c3f000 r-xp 00000000 08:05 11599887
/lib64/libdl-2.11.1.so
7f6ae8c3f000-7f6ae8e3f000 ---p 00002000 08:05 11599887
/lib64/libdl-2.11.1.so
7f6ae8e3f000-7f6ae8e40000 r--p 00002000 08:05 11599887
/lib64/libdl-2.11.1.so
7f6ae8e40000-7f6ae8e41000 rw-p 00003000 08:05 11599887
/lib64/libdl-2.11.1.so
7f6ae8e41000-7f6ae8f95000 r-xp 00000000 08:05 11599881
/lib64/libc-2.11.1.so
7f6ae8f95000-7f6ae9195000 ---p 00154000 08:05 11599881
/lib64/libc-2.11.1.so
7f6ae9195000-7f6ae9199000 r--p 00154000 08:05 11599881
/lib64/libc-2.11.1.so
7f6ae9199000-7f6ae919a000 rw-p 00158000 08:05 11599881
/lib64/libc-2.11.1.so
7f6ae919a000-7f6ae919f000 rw-p 00000000 00:00 0
7f6ae919f000-7f6ae91b5000 r-xp 00000000 08:05 11599986
/lib64/libgcc_s.so.1
7f6ae91b5000-7f6ae93b4000 ---p 00016000 08:05 11599986
/lib64/libgcc_s.so.1
7f6ae93b4000-7f6ae93b5000 r--p 00015000 08:05 11599986
/lib64/libgcc_s.so.1
7f6ae93b5000-7f6ae93b6000 rw-p 00016000 08:05 11599986
/lib64/libgcc_s.so.1
7f6ae93b6000-7f6ae940b000 r-xp 00000000 08:05 11599889
/lib64/libm-2.11.1.so
7f6ae940b000-7f6ae960a000 ---p 00055000 08:05 11599889
/lib64/libm-2.11.1.so
7f6ae960a000-7f6ae960b000 r--p 00054000 08:05 11599889
/lib64/libm-2.11.1.so
7f6ae960b000-7f6ae960c000 rw-p 00055000 08:05 11599889
/lib64/libm-2.11.1.so
7f6ae960c000-7f6ae9616000 r-xp 00000000 08:05 7799014
/usr/xenomai/lib/libnative.so.3.0.0
7f6ae9616000-7f6ae9815000 ---p 0000a000 08:05 7799014
/usr/xenomai/lib/libnative.so.3.0.0
7f6ae9815000-7f6ae9816000 r--p 00009000 08:05 7799014
/usr/xenomai/lib/libnative.so.3.0.0
7f6ae9816000-7f6ae9817000 rw-p 0000a000 08:05 7799014
/usr/xenomai/lib/libnative.so.3.0.0
7f6ae9817000-7f6ae982e000 r-xp 00000000 08:05 11599907
/lib64/libpthread-2.11.1.so
7f6ae982e000-7f6ae9a2e000 ---p 00017000 08:05 11599907
/lib64/libpthread-2.11.1.so
7f6ae9a2e000-7f6ae9a2f000 r--p 00017000 08:05 11599907
/lib64/libpthread-2.11.1.so
7f6ae9a2f000-7f6ae9a30000 rw-p 00018000 08:05 11599907
/lib64/libpthread-2.11.1.so
7f6ae9a30000-7f6ae9a34000 rw-p 00000000 00:00 0
7f6ae9a34000-7f6ae9a37000 r-xp 00000000 08:05 7799009
/usr/xenomai/lib/libxenomai.so.0.0.0
7f6ae9a37000-7f6ae9c37000 ---p 00003000 08:05 7799009
/usr/xenomai/lib/libxenomai.so.0.0.0
7f6ae9c37000-7f6ae9c38000 r--p 00003000 08:05 7799009
/usr/xenomai/lib/libxenomai.so.0.0.0
7f6ae9c38000-7f6ae9c39000 rw-p 00004000 08:05 7799009
/usr/xenomai/lib/libxenomai.so.0.0.0
7f6ae9c39000-7f6ae9d29000 r-xp 00000000 08:05 7854798
/usr/lib64/libstdc++.so.6.0.10
7f6ae9d29000-7f6ae9f28000 ---p 000f0000 08:05 7854798
/usr/lib64/libstdc++.so.6.0.10
7f6ae9f28000-7f6ae9f2f000 r--p 000ef000 08:05 7854798
/usr/lib64/libstdc++.so.6.0.10
7f6ae9f2f000-7f6ae9f31000 rw-p 000f6000 08:05 7854798
/usr/lib64/libstdc++.so.6.0.10
7f6ae9f31000-7f6ae9f44000 rw-p 00000000 00:00 0
7f6ae9f44000-7f6ae9f63000 r-xp 00000000 08:05 11599874
/lib64/ld-2.11.1.so
7f6aea022000-7f6aea023000 ---p 00000000 00:00 0
7f6aea023000-7f6aea129000 rw-p 00000000 00:00 0
7f6aea136000-7f6aea137000 rw-p 00000000 00:00 0
7f6aea137000-7f6aea138000 ---p 00000000 00:00 0
7f6aea138000-7f6aea148000 rw-p 00000000 00:00 0
7f6aea148000-7f6aea149000 ---p 00000000 00:00 0
7f6aea149000-7f6aea15a000 rw-p 00000000 00:00 0
7f6aea15a000-7f6aea15d000 rw-s 00000000 00:0e 2199
/dev/rtheapAborted

--000e0cd379e004680b049f1e1e6a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span style=3D"color: rgb(255, 102, 102);">Hello , I am a new bird using th=
e xemomai! I use my classmate program to run on the xenomai and I got the b=
elow information .It seems that the rtheap crash ??</span><br style=3D"colo=
r: rgb(255, 102, 102);">
<br style=3D"color: rgb(255, 102, 102);"><br style=3D"color: rgb(255, 102, =
102);"><span style=3D"color: rgb(255, 102, 102);">How can I solve this prob=
lem ????</span><br style=3D"color: rgb(255, 102, 102);"><br style=3D"color:=
 rgb(255, 102, 102);">
<span style=3D"color: rgb(255, 102, 102);">the xenomai is 2.5.4 and the ker=
nel is 2.6.34.5.</span><br><br><br><br><br><br>thanks for your help.<br><br=
>linux-xkps1:~/Desktop/linux # Bin/APP_LTE_DEMO config.txt<br>Noise Generat=
ed<br>
*** glibc detected *** Bin/APP_LTE_DEMO: malloc(): memory corruption: 0x000=
00000176fbba0 ***<br>=3D=3D=3D=3D=3D=3D=3D Backtrace: =3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>/lib64/libc.so.6(+0x75018)[0x7f6ae8eb6018]<br>/lib64/libc.so.6(+0=
x77f7f)[0x7f6ae8eb8f7f]<br>/lib64/libc.so.6(__libc_malloc+0x77)[0x7f6ae8ebb=
057]<br>
Bin/APP_LTE_DEMO[0x41f284]<br>/usr/xenomai/lib/libnative.so.3(+0x728c)[0x7f=
6ae961328c]<br>/lib64/libpthread.so.0(+0x75f0)[0x7f6ae981e5f0]<br>/lib64/li=
bc.so.6(clone+0x6d)[0x7f6ae8f1584d]<br>=3D=3D=3D=3D=3D=3D=3D Memory map: =
=3D=3D=3D=3D=3D=3D=3D=3D<br>
00400000-0052f000 r-xp 00000000 08:05 8986626=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /root/linux/Bin/APP_LTE=
_DEMO<br>0072e000-0072f000 r--p 0012e000 08:05 8986626=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /root/linux/Bi=
n/APP_LTE_DEMO<br>0072f000-00761000 rw-p 0012f000 08:05 8986626=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /root=
/linux/Bin/APP_LTE_DEMO<br>
00761000-15833000 rw-p 00000000 00:00 0 <br>176d2000-1771c000 rw-p 00000000=
 00:00 0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [heap]<br>7f6ab4000000-7f6ab4021000 rw-p =
00000000 00:00 0 <br>7f6ab4021000-7f6ab8000000 ---p 00000000 00:00 0 <br>
7f6abb491000-7f6abb492000 ---p 00000000 00:00 0 <br>7f6abb492000-7f6abf4920=
00 rw-p 00000000 00:00 0 <br>7f6abf492000-7f6abf854000 rw-s 00000000 00:0e =
2199=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /dev=
/rtheap<br>7f6abf854000-7f6abf855000 ---p 00000000 00:00 0 <br>
7f6abf855000-7f6ac3855000 rw-p 00000000 00:00 0 <br>7f6ac3855000-7f6ac444c0=
00 rw-s 00000000 00:0e 2199=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 /dev/rtheap<br>7f6ac444c000-7f6ac5043000 rw-s 00000000 0=
0:0e 2199=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 /dev/rtheap<br>
7f6ac5043000-7f6ac5c3a000 rw-s 00000000 00:0e 2199=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /dev/rtheap<br>7f6ac5c3a000-7f6a=
c6831000 rw-s 00000000 00:0e 2199=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 /dev/rtheap<br>7f6ac6831000-7f6ac6bf3000 rw-s 0000=
0000 00:0e 2199=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 /dev/rtheap<br>
7f6ac6bf3000-7f6ac6fb5000 rw-s 00000000 00:0e 2199=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /dev/rtheap<br>7f6ac6fb5000-7f6a=
c7377000 rw-s 00000000 00:0e 2199=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 /dev/rtheap<br>7f6ac7377000-7f6ac7378000 ---p 0000=
0000 00:00 0 <br>
7f6ac7378000-7f6acb378000 rw-p 00000000 00:00 0 <br>7f6acb378000-7f6acb3790=
00 ---p 00000000 00:00 0 <br>7f6acb379000-7f6acb479000 rw-p 00000000 00:00 =
0 <br>7f6acb479000-7f6acb47a000 ---p 00000000 00:00 0 <br>7f6acb47a000-7f6a=
cb57a000 rw-p 00000000 00:00 0 <br>
7f6acb57a000-7f6acb57b000 ---p 00000000 00:00 0 <br>7f6acb57b000-7f6acb67b0=
00 rw-p 00000000 00:00 0 <br>7f6acb67b000-7f6acb67c000 ---p 00000000 00:00 =
0 <br>7f6acb67c000-7f6ae8c3d000 rw-p 00000000 00:00 0 <br>7f6ae8c3d000-7f6a=
e8c3f000 r-xp 00000000 08:05 11599887=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libdl-2.11.1.so">libdl-2.11.1.s=
o</a><br>
7f6ae8c3f000-7f6ae8e3f000 ---p 00002000 08:05 11599887=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libdl-2.11.1.so"=
>libdl-2.11.1.so</a><br>7f6ae8e3f000-7f6ae8e40000 r--p 00002000 08:05 11599=
887=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D=
"http://libdl-2.11.1.so">libdl-2.11.1.so</a><br>
7f6ae8e40000-7f6ae8e41000 rw-p 00003000 08:05 11599887=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libdl-2.11.1.so"=
>libdl-2.11.1.so</a><br>7f6ae8e41000-7f6ae8f95000 r-xp 00000000 08:05 11599=
881=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D=
"http://libc-2.11.1.so">libc-2.11.1.so</a><br>
7f6ae8f95000-7f6ae9195000 ---p 00154000 08:05 11599881=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libc-2.11.1.so">=
libc-2.11.1.so</a><br>7f6ae9195000-7f6ae9199000 r--p 00154000 08:05 1159988=
1=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"h=
ttp://libc-2.11.1.so">libc-2.11.1.so</a><br>
7f6ae9199000-7f6ae919a000 rw-p 00158000 08:05 11599881=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libc-2.11.1.so">=
libc-2.11.1.so</a><br>7f6ae919a000-7f6ae919f000 rw-p 00000000 00:00 0 <br>7=
f6ae919f000-7f6ae91b5000 r-xp 00000000 08:05 11599986=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/libgcc_s.so.1<br>
7f6ae91b5000-7f6ae93b4000 ---p 00016000 08:05 11599986=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/libgcc_s.so.1<br>7f6ae93b4000-7f6a=
e93b5000 r--p 00015000 08:05 11599986=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 /lib64/libgcc_s.so.1<br>7f6ae93b5000-7f6ae93b6000 rw-p 0=
0016000 08:05 11599986=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 /lib64/libgcc_s.so.1<br>
7f6ae93b6000-7f6ae940b000 r-xp 00000000 08:05 11599889=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libm-2.11.1.so">=
libm-2.11.1.so</a><br>7f6ae940b000-7f6ae960a000 ---p 00055000 08:05 1159988=
9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"h=
ttp://libm-2.11.1.so">libm-2.11.1.so</a><br>
7f6ae960a000-7f6ae960b000 r--p 00054000 08:05 11599889=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libm-2.11.1.so">=
libm-2.11.1.so</a><br>7f6ae960b000-7f6ae960c000 rw-p 00055000 08:05 1159988=
9=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"h=
ttp://libm-2.11.1.so">libm-2.11.1.so</a><br>
7f6ae960c000-7f6ae9616000 r-xp 00000000 08:05 7799014=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/xenomai/lib/libnative.so.3.0.0<br=
>7f6ae9616000-7f6ae9815000 ---p 0000a000 08:05 7799014=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/xenomai/lib/libnative.so.3.0.0<br=
>
7f6ae9815000-7f6ae9816000 r--p 00009000 08:05 7799014=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/xenomai/lib/libnative.so.3.0.0<br=
>7f6ae9816000-7f6ae9817000 rw-p 0000a000 08:05 7799014=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/xenomai/lib/libnative.so.3.0.0<br=
>
7f6ae9817000-7f6ae982e000 r-xp 00000000 08:05 11599907=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libpthread-2.11.=
1.so">libpthread-2.11.1.so</a><br>7f6ae982e000-7f6ae9a2e000 ---p 00017000 0=
8:05 11599907=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/=
<a href=3D"http://libpthread-2.11.1.so">libpthread-2.11.1.so</a><br>
7f6ae9a2e000-7f6ae9a2f000 r--p 00017000 08:05 11599907=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/<a href=3D"http://libpthread-2.11.=
1.so">libpthread-2.11.1.so</a><br>7f6ae9a2f000-7f6ae9a30000 rw-p 00018000 0=
8:05 11599907=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /lib64/=
<a href=3D"http://libpthread-2.11.1.so">libpthread-2.11.1.so</a><br>
7f6ae9a30000-7f6ae9a34000 rw-p 00000000 00:00 0 <br>7f6ae9a34000-7f6ae9a370=
00 r-xp 00000000 08:05 7799009=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 /usr/xenomai/lib/libxenomai.so.0.0.0<br>7f6ae9a37000-7f6ae9c37=
000 ---p 00003000 08:05 7799009=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 /usr/xenomai/lib/libxenomai.so.0.0.0<br>
7f6ae9c37000-7f6ae9c38000 r--p 00003000 08:05 7799009=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/xenomai/lib/libxenomai.so.0.0.0<b=
r>7f6ae9c38000-7f6ae9c39000 rw-p 00004000 08:05 7799009=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/xenomai/lib/libxenomai.so.0.0.=
0<br>
7f6ae9c39000-7f6ae9d29000 r-xp 00000000 08:05 7854798=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/lib64/libstdc++.so.6.0.10<br>7f6a=
e9d29000-7f6ae9f28000 ---p 000f0000 08:05 7854798=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/lib64/libstdc++.so.6.0.10<br>7f6ae9f=
28000-7f6ae9f2f000 r--p 000ef000 08:05 7854798=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/lib64/libstdc++.so.6.0.10<br>
7f6ae9f2f000-7f6ae9f31000 rw-p 000f6000 08:05 7854798=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /usr/lib64/libstdc++.so.6.0.10<br>7f6a=
e9f31000-7f6ae9f44000 rw-p 00000000 00:00 0 <br>7f6ae9f44000-7f6ae9f63000 r=
-xp 00000000 08:05 11599874=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 /lib64/<a href=3D"http://ld-2.11.1.so">ld-2.11.1.so</a><br>
7f6aea022000-7f6aea023000 ---p 00000000 00:00 0 <br>7f6aea023000-7f6aea1290=
00 rw-p 00000000 00:00 0 <br>7f6aea136000-7f6aea137000 rw-p 00000000 00:00 =
0 <br>7f6aea137000-7f6aea138000 ---p 00000000 00:00 0 <br>7f6aea138000-7f6a=
ea148000 rw-p 00000000 00:00 0 <br>
7f6aea148000-7f6aea149000 ---p 00000000 00:00 0 <br><span style=3D"color: r=
gb(255, 0, 0);">7f6aea149000-7f6aea15a000 rw-p 00000000 00:00 0 </span><br =
style=3D"color: rgb(255, 0, 0);"><span style=3D"color: rgb(255, 0, 0);">7f6=
aea15a000-7f6aea15d000 rw-s 00000000 00:0e 2199=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /dev/rtheapAborted</span><br style=
=3D"color: rgb(255, 0, 0);">
<br><br><br><br>

--000e0cd379e004680b049f1e1e6a--

