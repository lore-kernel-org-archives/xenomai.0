From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17360.3999.645581.227559@domain.hid>
Date: Thu, 19 Jan 2006 23:15:59 +0100
Subject: Re: [Xenomai-core] Problems generating vxworks/koan in two step: cc
	and link
In-Reply-To: <200601192212.45556.niklaus.giger@domain.hid>
References: <200601192212.45556.niklaus.giger@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: niklaus.giger@domain.hid
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
 > ld -o koan  -L/usr/xenomai/lib -luvm -lnucleus -lpthread -lvxworks -lnative  
 > -e __xeno_skin_init  /home/hcu/project/bb/3_1_x/work/xeno/koan.o
 > Now I get the following error output
 > ld: warning: cannot find entry symbol __xeno_skin_init; defaulting to 
 > 00000000100002a0
 > /home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function `TaskTest':koan.c:
 > (.text+0xbc): undefined reference to `semTake'
 > /home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function `CreateTask':koan.c:
 > (.text+0x124): undefined reference to `taskSpawn'
 > /home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function `usrClock':koan.c:
 > (.text+0x1c8): undefined reference to `semGive'
 > :koan.c:(.text+0x1f0): undefined reference to `tickAnnounce'
 > /home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function 
 > `koan_sysClkInit':koan.c:(.text+0x224): undefined reference to `semBCreate'
 > :koan.c:(.text+0x23c): undefined reference to `sysClkConnect'
 > :koan.c:(.text+0x240): undefined reference to `sysClkEnable'
 > /home/hcu/project/bb/3_1_x/work/xeno/koan.o: In function 
 > `__xeno_user_exit':koan.c:(.text+0x2c0): undefined reference to `taskDelete'
 > 
 > What is wrong with my split?

What happens if you try :

cc -u __xeno_skin_init -o koan -L/usr/xenomai/lib -luvm -lnucleus -lpthread -lvxworks -lnative /home/hcu/project/bb/3_1_x/work/xeno/koan.o

-u seems to be a link-time option.

-- 


					    Gilles Chanteperdrix.

