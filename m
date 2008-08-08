Message-ID: <489C96FA.7050400@domain.hid>
Date: Fri, 08 Aug 2008 14:56:58 -0400
From: Michael Galea <michaelgalea@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai kernel user-space problem running testsuite
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

I'm just starting with xenomai and am having troubles getting xenomai 
user space to talk to my kernel.

I build the kernel and user-space xenomai code and try to run `latency` 
from the test suite and get
mpc8360mds:# /usr/local/xenomai/bin/latency
Xenomai: incompatible feature set
(required="fastsem", present="nofastsem", missing="fastsem").


I have built xenomai from svn into my 2.6.26 powerpc kernel and it looks 
  good on the next boot, i.e. `dmesg |grep xeno -i` returns:
I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: real-time nucleus v2.5-devel (Flying In A Blue Dream) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.

The user-space builds and installs over NFS just fine:

./configure --host=ppc-unknown-linux-gnu --prefix=/usr/local/xenomai \
   CC=ppc_6xx-gcc CXX=ppc_6xx-g++ LD=ppc_6xx-ld
make
make DESTDIR=/opt/ppcrootmds/ install


I can't see any fastsem options in the kernel.  Does anyone have any 
advice?

Thanks
-- 
Michael Galea
30 Whitmore Road
Woodbridge, Ontario, Canada, L4L 7Z4
Ph: (905) 266-1745
Fx: (905) 856-1995
www.ruggedcom.com

NOTICE OF CONFIDENTIALITY:
This e-mail and any attachments may contain confidential and privileged 
information. If you are not the intended recipient, please notify the 
sender immediately by return e-mail and delete this e-mail and any 
copies. Any dissemination or use of this information by a person other 
than the intended recipient is unauthorized and may be illegal.

