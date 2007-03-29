From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17932.11512.447406.720008@domain.hid>
Date: Thu, 29 Mar 2007 23:17:44 +0200
Subject: Re: [Xenomai-help] Newbie problem : xenomai 2.3.1 and kernel 2.6.20.4
	installation problem
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C603221032@domain.hid>
References: <5C40CD1E4697424ABDE3AC57CF1B22C603221032@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

RAKOTOSALAMA, Nirilanto wrote:
 > Hello everybody !
 > 
 > I installed xenomai 2.3.0 on a FC6 linux distribution with vanilla kernel 2.6.19.7 following the
 > http://www.captain.at/xenomai-2.1-installation.php installation guide. 
 > It worked well until I install a new xenomai version (2.3.1) and linux kernel (2.6.20.4)
 > with the same kernel configuration than the first install.
 > The compilation and installation passed but when I run the xeno-test program, sometimes, it blocks
 > at the begining and I have to reboot the PC. Also, the cyclic testsuite program always blocks when I stop it pressing ctl-c.  
 > I have no problem with the latency test or others simple programs I made using rt_arlarm objects (I only use native skin).
 > 
 > When I launch the ancient kernel (which worked before) I have the same behaviour when I launch cyclic test and xeno-test.

This means that the problem lies in user-space. Could you launch
xeno-test with bash -x to see what command of xeno-test blocks ? And
attach gdb to the bloccked cyclictest to see where it is blocked ?

 > 
 > Note : When I installed 2.3.1 xenomai version over the ancien 2.3.0 version I only removed the 
 > old /usr/xenomai directory and launch the 2.3.1 xenomai installation. (Is there a better manner to unsinstall an older xenomai version?)

No, this method should work.

 > (...)
 > [niry@domain.hid ~]$ xeno-info
 > If some fields are empty or look unusual you may have an old version.
 > Compare to the current minimal requirements in Documentation/Changes.
 > 
 > Linux localhost.localdomain 2.6.20.4-xenomai.2.3.1_29-03-2007 #1 Thu Mar 29 16:27:42 CEST 2007 i686 i686 i386 GNU/Linux
 > 
 > Gnu C                  4.1.1

To rule out any compiler bug, could you try recompiling with a less
recent version ? Say gcc 3.3.x ?



-- 


					    Gilles Chanteperdrix.

