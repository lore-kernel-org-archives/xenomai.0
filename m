Message-ID: <42283891.2060807@domain.hid>
Date: Fri, 04 Mar 2005 11:29:37 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] 2.6.9-r9c5  patch problem
References: <6.1.1.1.2.20050303164341.0298e420@domain.hid>
In-Reply-To: <6.1.1.1.2.20050303164341.0298e420@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Nate Villaume <Nathaniel.J.Villaume@domain.hid>
Cc: adeos-main@gna.org

Nate Villaume wrote:
> Hello,
> 
> I cannot seem to find a 2.6.x kernel that, once patched with adeos, will 
> compile on my setup.
> I have this problem with 2.6.7, 2.6.8.1, and 2.6.9 (either patch version 
> r8 or r9c5):
> 
> I am compiling with gcc (GCC) 3.4.2 20041017 (Red Hat 3.4.2-6.fc3)
> I am on a dual athlon machine.
> 
>   CC      arch/i386/kernel/asm-offsets.s
> In file included from include/asm-i386/mach-generic/mach_apicdef.h:5,
>                  from include/asm/adeos.h:40,
>                  from include/linux/adeos.h:25,
>                  from include/linux/sched.h:8,
>                  from arch/i386/kernel/asm-offsets.c:7:
> include/asm/genapic.h:30: error: syntax error before "bitmap"
> include/asm/genapic.h:30: warning: function declaration isn't a prototype
> include/asm/genapic.h:35: error: syntax error before "physid_mask_t"
> 
> Any suggestions?
> 
> On one attempt, I tried plugging the holes by finding the defines, but 
> then I run into an undefined instance of adp_root....
> 
> -Nate
> 
> P.S. Philippe, I brought this here because I tried your last suggestion 
> on RTAI's list, but again, to no avail.
> 
> 

I cannot reproduce this bug using 3.4.3 + Athlon SMP config, but does 
the following patch make things any better?

--- include/asm-i386/adeos.h~	2005-02-28 18:46:46.000000000 +0100
+++ include/asm-i386/adeos.h	2005-03-04 11:23:09.000000000 +0100
@@ -37,6 +37,7 @@
  #ifdef CONFIG_SMP

  #include <asm/fixmap.h>
+#include <asm/mpspec.h>
  #include <mach_apicdef.h>

  #define ADEOS_NR_CPUS          NR_CPUS
-- 

Philippe.

