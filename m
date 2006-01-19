From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 19 Jan 2006 22:12:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601192212.45556.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Problems generating vxworks/koan in two step: cc and
	link
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi

I am trying to bring my build infrastructure up to Xenomai 2.1 and got the 
following problem:
I have no problems to generate koan using the following command:
  cc  -o koan2  /home/hcu/kernel/tst_xeno_ppc/koan.c  -I. \ 
-I/usr/xenomai/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall \
-pipe -D__XENO_UVM__  -u__xeno_skin_init -L/usr/xenomai/lib -luvm -lnucleus \ 
-lpthread -lvxworks -lnative

No in order to be able to compile and link bigger applications my first try 
was to compile koan first and then to link. However running the following two 
commands

c   -c -I. -I/usr/xenomai/include -O2 -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
-Wall -pipe -D__XENO_UVM__ -u__xeno_skin_init    
-I. /home/hcu/project/bb/3_1_x/work/xeno/koan.c  
-o /home/hcu/project/bb/3_1_x/work/xeno/koan.o
ld -o koan  -L/usr/xenomai/lib -luvm -lnucleus -lpthread -lvxworks -lnative  
-e __xeno_skin_init  /home/hcu/project/bb/3_1_x/work/xeno/koan.o
Now I get the following error output
ld: warning: cannot find entry symbol __xeno_skin_init; defaulting to 
00000000100002a0
/home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function `TaskTest':koan.c:
(.text+0xbc): undefined reference to `semTake'
/home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function `CreateTask':koan.c:
(.text+0x124): undefined reference to `taskSpawn'
/home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function `usrClock':koan.c:
(.text+0x1c8): undefined reference to `semGive'
:koan.c:(.text+0x1f0): undefined reference to `tickAnnounce'
/home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function 
`koan_sysClkInit':koan.c:(.text+0x224): undefined reference to `semBCreate'
:koan.c:(.text+0x23c): undefined reference to `sysClkConnect'
:koan.c:(.text+0x240): undefined reference to `sysClkEnable'
/home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function 
`__xeno_user_exit':koan.c:(.text+0x2c0): undefined reference to `taskDelete'

What is wrong with my split?

-- 
Niklaus Giger

