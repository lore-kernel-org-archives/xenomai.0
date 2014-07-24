Message-ID: <53D0AC77.8070606@ma-info.de>
Date: Thu, 24 Jul 2014 08:49:27 +0200
From: Frede Florian <florian.frede@ma-info.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] How to use Xenomai in Eclipse
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

We plan to use Xenomai in our new project. So now I tried to prepare a 
Eclipse-Project with Xenomai. First I compiled the Debian packages from 
Xenomai 2.6.3 
<http://www.xenomai.org/index.php/Building_Debian_packages> for my 
System.  After that I install the libxenomai1 and libxenomai-dev

After that I have create a new empty project. There I can include the 
Xenomailib (#include <xenomai/native/task.h>).

First issue: While compiling the code with Eclipse I get an*fatal error: 
nucleus/sched.h: file or directory not found*...

I try to find a answer in the endless world wide web :-) but I didn't 
found a solution.

Second issue: When I change to the compiler for my target platform 
(arm-cortexa8-linux-gnueabihf-gcc) I can not include the Xenomai library?

I use following Software on my System: Eclipse Version: Luna Release 
(4.4.0), Debian GNU/Linux 7.6 (wheezy), Xenomai 2.6.3, 
OSELAS.Toolchain-2013.12.2 
<http://www.pengutronix.de/oselas/toolchain/download/OSELAS.Toolchain-2013.12.2.tar.bz2>

Regards Florian


