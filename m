Message-Id: <6.1.1.1.2.20050303164341.0298e420@domain.hid>
Date: Thu, 03 Mar 2005 16:52:49 -0800
From: Nate Villaume <Nathaniel.J.Villaume@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Subject: [Adeos-main] 2.6.9-r9c5  patch problem
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

Hello,

I cannot seem to find a 2.6.x kernel that, once patched with adeos, will 
compile on my setup.
I have this problem with 2.6.7, 2.6.8.1, and 2.6.9 (either patch version r8 
or r9c5):

I am compiling with gcc (GCC) 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)
I am on a dual athlon machine.

   CC      arch/i386/kernel/asm-offsets.s
In file included from include/asm-i386/mach-generic/mach_apicdef.h:5,
                  from include/asm/adeos.h:40,
                  from include/linux/adeos.h:25,
                  from include/linux/sched.h:8,
                  from arch/i386/kernel/asm-offsets.c:7:
include/asm/genapic.h:30: error: syntax error before "bitmap"
include/asm/genapic.h:30: warning: function declaration isn't a prototype
include/asm/genapic.h:35: error: syntax error before "physid_mask_t"

Any suggestions?

On one attempt, I tried plugging the holes by finding the defines, but then 
I run into an undefined instance of adp_root....

-Nate

P.S. Philippe, I brought this here because I tried your last suggestion on 
RTAI's list, but again, to no avail.



-Nathaniel J. Villaume
Jet Propulsion Laboratory
(818) 393 0881

***   All personal and professional opinions presented herein are 
my      ***
***   own and do not, in any way, represent the opinion or policy of JPL. 
***




