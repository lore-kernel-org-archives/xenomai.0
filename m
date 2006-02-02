From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Date: Thu, 2 Feb 2006 16:13:45 -0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602021613.46172.lbocseg@domain.hid>
Subject: [Xenomai-help] SVN Xenomai posix skin bug
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

Hi Phillipe,

I've downloaded xenomai from SVN and I couldn't compile the kernel with the 
posix module checked up.

Please, let me know when you correct this (as the functions being used are not 
documented I didn't try to do it myself).

That is the result (using the 1.2-00 adeos-ipipe version on linux 2.6.15.2):

  CC [M]  kernel/xenomai/skins/posix/syscall.o
kernel/xenomai/skins/posix/syscall.c: In function '__sem_open':
kernel/xenomai/skins/posix/syscall.c:571: error: 'handle' undeclared (first 
use in this function)
kernel/xenomai/skins/posix/syscall.c:571: error: (Each undeclared identifier 
is reported only once
kernel/xenomai/skins/posix/syscall.c:571: error: for each function it appears 
in.)
make[4]: ** [kernel/xenomai/skins/posix/syscall.o] Erro 1
make[3]: ** [kernel/xenomai/skins/posix] Erro 2
make[2]: ** [kernel/xenomai/skins] Erro 2
make[1]: ** [kernel/xenomai] Erro 2
make: ** [kernel] Erro 2

Thanks in advance,

Rodrigo.

		
____________________________________________________



