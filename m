From: Skander Bahloul <skander.bahloul@imag.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jul 2013 11:32:25 +0200
Message-Id: <BC6109C5-9FF8-488D-9A1C-A983B1AD3415@imag.fr>
Mime-Version: 1.0 (Apple Message framework v1085)
Subject: [Xenomai] Xenomai and NVIDIA graphics drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Xenomai list members,

I'am a student and beginner.
I am in charge of installing, configuring and testing Xenomai for hard =
real-time interactive physically based simulation.
The laboratory and myself have very small experience on Xenomai.

I need high quality graphics on the machine with the NVIDIA drivers, but =
do not succeed.

I have various installation ongoing, eg on Debian, Ubuntu, fedora.
Only Debian is successful so far.
OS :
	Debian 7.1 AMD64
	Kernel 3.2.21 (updated from 3.1.0 AMD64)
	Xenomai 2.6.1
Final xenomai version (uname -r) : Xenoami-ipipe-3.2.21
Machine :
	Architecture : Intel X86
	GPU Quadro 2000


Is it possible ? It is AFAIK.
Can you indicate a good tutorial on this issue ?


More details now.


I tried installing the drivers before Xenomai, but i cannot :=20


I tried installing the NVIDIA drivers after installing Xenomai, but then =
the installation fails:

Error! bad return status for module build on kernel 3.2.21-xenomai-ipipe =
(X86-64). consult /var/lib/dkms/nvidia/319.31/build/make.log for me more =
information.


I try to do :
$ sh Nvidia-linux-x86-319.31.run --kernel-name=3D'xenomai-ipipe-3.2.21'=20=


but it fails.


Could you help me please!





I thank you very much,
Best regards,
Skander Bahloul=

