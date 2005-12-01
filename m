From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 1 Dec 2005 22:01:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512012201.21380.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Problem running koan (UVM)
Reply-To: niklaus.giger@domain.hid
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

Hi

Many thanks to Philip Gerum for his previous help!

I am no able to sucessfully link koan on my PPC405 board.

However after calling 
$ koan
The only output I get is
Xenomai/uvm: real-time nucleus v2.1 (Surfing With The Alien) loaded.
koan was linked like this:
 /home/hcu/tools/gcc-3.4.4-glibc-2.3.5/powerpc-405-linux-gnu/bin/powerpc-405-linux-gnu-g++  
-g  -o koan   /home/hcu/project/bb/3_1_x/work/xeno/koan.o   
-u__xeno_skin_init -L/mnt/data.ng/hcu/rootfs/usr/xenomai/lib -luvm -lnucleus 
-lpthread -lnative -lvxworks

Nothing more. I know its now time to build the GDB stub, but as it is the 
first time that I do this it will take a moment to read the documentation.

In the mean time any help would be appreciated.

Looking at the output of xeno-config in my cross compile case I think that one 
should create two xeno-config's one representing the target's view and one 
for the host which did the cross-compile, e.g.creating in the build directory 
a xeno-config-host. And how should we handle a canadian cross?

Regards

-- 
Niklaus Giger

