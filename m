MIME-Version: 1.0
Date: Thu, 15 Oct 2009 18:13:43 -0700
Message-ID: <96eea0c80910151813v635d518dr6abd72986e2f07bd@domain.hid>
From: Peter Pastor <peter.pastor@domain.hid>
Content-Type: multipart/alternative; boundary=0015177412186490fc0476031beb
Subject: [Xenomai-help] national instruments card and comedi-rtdm-dev
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

--0015177412186490fc0476031beb
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey,

I am trying to get a national instrument data acquisition pci card working
under linux 2.6.30.5 xenomai 2.5-rc3 using comedi. I successfully installed
the regular comedi drivers and I got data from the card, however, I also go=
t
mode switches. Therefore, I moved to the latest xenomai release which
includes the comedi interface. The installation worked out and I got a
xeno_comedi.ko module that I can load and a /usr/xenomai/lib/libcomedi.so.0=
.
However, my program returns with...

xenomai:~/xenomai_test> ./rt_comedi_test
./rt_comedi_test: /usr/xenomai/lib/libcomedi.so.0: no version information
available (required by ./rt_comedi_test)
Xenomai: incompatible ABI revision level
(needed=3D1, current=3D2).

I figured, that I need a national instrument driver (ni_pcimio) to get the
/dev/comedi0 up and running since there is no kernel module associated with
the NI card...

xenomai:~/xenomai_test> lspci -v

...

06:00.0 Class ff00: National Instruments Device 717f
    Flags: bus master, medium devsel, latency 64, IRQ 11
    Memory at f7dfe000 (32-bit, non-prefetchable) [size=3D4K]
    Memory at f7dff000 (32-bit, non-prefetchable) [size=3D4K]

...

I "svn co http://svn.gna.org/svn/xenomai/branches/comedi-rtdm-dev" since it
seems to contain the NI drivers... however, I got a compiler error that I
think relates to the fact that the system I am using has 4GB of ram
(highmem). I am using revision: 4727.

root@domain.hid# make
make  all-recursive
make[1]: Entering directory `/usr/src/comedi-rtdm-dev'
Making all in comedi_kcore
make[2]: Entering directory `/usr/src/comedi-rtdm-dev/comedi_kcore'
make[3]: Entering directory `/usr/src/comedi-rtdm-dev'
make[3]: Leaving directory `/usr/src/comedi-rtdm-dev'
make[3]: Entering directory `/usr/src/linux-2.6.30.5'
  CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_os_facilities.o
  CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_command.o
  CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_instruction.o
  CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_driver.o
  CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_subdevice.o
  CC [M]  /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o
/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c: In function
=91comedi_free_buffer=92:
/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c:52: error: implicit
declaration of function =91__va_to_kva=92
make[4]: *** [/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o] Error =
1
make[3]: *** [_module_/usr/src/comedi-rtdm-dev/comedi_kcore] Error 2
make[3]: Leaving directory `/usr/src/linux-2.6.30.5'
make[2]: *** [comedi.ko] Error 2
make[2]: Leaving directory `/usr/src/comedi-rtdm-dev/comedi_kcore'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/comedi-rtdm-dev'
make: *** [all] Error 2

I would be really happy if someone could give me some hints/advice on how t=
o
get things working. What do I need to do ??

Thanks a lot,
 peter

--0015177412186490fc0476031beb
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hey,<br><br>I am trying to get a national instrument data acquisition pci c=
ard working under linux 2.6.30.5 xenomai 2.5-rc3 using comedi. I successful=
ly installed the regular comedi drivers and I got data from the card, howev=
er, I also got mode switches. Therefore, I moved to the latest xenomai rele=
ase which includes the comedi interface. The installation worked out and I =
got a xeno_comedi.ko module that I can load and a /usr/xenomai/lib/libcomed=
i.so.0. However, my program returns with...<br>
<br>xenomai:~/xenomai_test&gt; ./rt_comedi_test<br>./rt_comedi_test: /usr/x=
enomai/lib/libcomedi.so.0: no version information available (required by ./=
rt_comedi_test)<br>Xenomai: incompatible ABI revision level<br>(needed=3D1,=
 current=3D2).<br>
<br>I figured, that I need a national instrument driver (ni_pcimio) to get =
the /dev/comedi0 up and running since there is no kernel module associated =
with the NI card...<br><br>xenomai:~/xenomai_test&gt; lspci -v<br><br>...<b=
r>
<br>06:00.0 Class ff00: National Instruments Device 717f<br>=A0=A0=A0 Flags=
: bus master, medium devsel, latency 64, IRQ 11<br>=A0=A0=A0 Memory at f7df=
e000 (32-bit, non-prefetchable) [size=3D4K]<br>=A0=A0=A0 Memory at f7dff000=
 (32-bit, non-prefetchable) [size=3D4K]<br>
<br>...<br><br>I &quot;svn co <a href=3D"http://svn.gna.org/svn/xenomai/bra=
nches/comedi-rtdm-dev">http://svn.gna.org/svn/xenomai/branches/comedi-rtdm-=
dev</a>&quot; since it seems to contain the NI drivers... however, I got a =
compiler error that I think relates to the fact that the system I am using =
has 4GB of ram  (highmem). I am using revision: 4727.<br>
<br>root@domain.hid# make<br>make=A0 all-recursive<br=
>make[1]: Entering directory `/usr/src/comedi-rtdm-dev&#39;<br>Making all i=
n comedi_kcore<br>make[2]: Entering directory `/usr/src/comedi-rtdm-dev/com=
edi_kcore&#39;<br>
make[3]: Entering directory `/usr/src/comedi-rtdm-dev&#39;<br>make[3]: Leav=
ing directory `/usr/src/comedi-rtdm-dev&#39;<br>make[3]: Entering directory=
 `/usr/src/linux-2.6.30.5&#39;<br>=A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/co=
medi_kcore/comedi_os_facilities.o<br>
=A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_command.o<br>=A0=
 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_instruction.o<br>=
=A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_driver.o<br>=A0 =
CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_subdevice.o<br>
=A0 CC [M]=A0 /usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o<br>/usr=
/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c: In function =91comedi_fr=
ee_buffer=92:<br>/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.c:52: =
error: implicit declaration of function =91__va_to_kva=92<br>
make[4]: *** [/usr/src/comedi-rtdm-dev/comedi_kcore/comedi_buffer.o] Error =
1<br>make[3]: *** [_module_/usr/src/comedi-rtdm-dev/comedi_kcore] Error 2<b=
r>make[3]: Leaving directory `/usr/src/linux-2.6.30.5&#39;<br>make[2]: *** =
[comedi.ko] Error 2<br>
make[2]: Leaving directory `/usr/src/comedi-rtdm-dev/comedi_kcore&#39;<br>m=
ake[1]: *** [all-recursive] Error 1<br>make[1]: Leaving directory `/usr/src=
/comedi-rtdm-dev&#39;<br>make: *** [all] Error 2<br><br>I would be really h=
appy if someone could give me some hints/advice on how to get things workin=
g. What do I need to do ??<br>
<br>Thanks a lot,<br>=A0peter<br>

--0015177412186490fc0476031beb--

