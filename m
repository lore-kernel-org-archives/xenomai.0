MIME-Version: 1.0
Date: Sun, 30 Dec 2012 11:32:06 +0800
Message-ID: <CABi95VNaL3VuLq-qBEGgG1Fnwtpi2eQsDCMyEqPqvh9yNuZ-Eg@mail.gmail.com>
From: =?GB2312?B?yfLMzg==?= <xst0001@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Can not run test on Raspberry Pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hello all!

I'm not familiar with either Xenomai or Raspberry Pi.So please do not be
mad at me if my question seems silly.

Anyway,I followed the instructions on
http://powet.eu/2012/07/25/raspberry-pi-xenomai/<http://translate.googleuse=
rcontent.com/translate_c?depth=3D1&hl=3Den&ie=3DUTF8&prev=3D_t&rurl=3Dtrans=
late.google.com&sl=3Dfr&tl=3Den&twu=3D1&u=3Dhttp://powet.eu/2012/07/25/rasp=
berry-pi-xenomai/&usg=3DALkJrhh8sBPbInHso_27CJ73Qprh-F7cxA>
and
cross compiled a kernel patched with Xenomai with tools from
https://github.com/raspberrypi/tools.It seems work fine.

Then I cross compile Xenomai(the user-space sport),and copied all the
results to my Raspberry Pi.When I try to run the /usr/xenomai/bin/latency,I
get the ERROR: error while loading shared libraries:libnative.so.3:cannot
open shared object file: No such file or directory.

pi@raspberrypi ~ $ ls /usr/xenomai/lib
...... libnative.so.3 ......

So the object file is there.

The I tried to ldconfig with /usr/xenomai/lib in my /etc/ld.so.conf,and
confirm the result.

pi@raspberrypi ~ $ ldconfig - p | grep native
   libnative.so.3(libc6)=3D>/usr/xenomai/lib/libnative.so.3
   ......

I also tried to export LD_LIBRARY_PATH,still get the same error.

I know the problem may seems familiar to you.I have already googled it and
keep trying to solve it.I also read the Program-Library-HOWTO from
http://www.tldp.org/HOWTO/Program-Library-HOWTO/introduction.html and try
to learn more about shared libraries.But I still can not solve my
problem,need some help.

Thanks in advance.

Shen Tao
