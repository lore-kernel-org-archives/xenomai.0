Message-Id: <6.1.1.1.2.20050304081745.02773fe0@domain.hid>
Date: Fri, 04 Mar 2005 08:20:44 -0800
From: Nate Villaume <Nathaniel.J.Villaume@domain.hid>
Subject: Re: [Adeos-main] 2.6.9-r9c5  patch problem
In-Reply-To: <42283891.2060807@domain.hid>
References: <6.1.1.1.2.20050303164341.0298e420@domain.hid>
 <42283891.2060807@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

Yes, that helped tremendously! At least I can build now!

>I cannot reproduce this bug using 3.4.3 + Athlon SMP config, but does the 
>following patch make things any better?
>
>--- include/asm-i386/adeos.h~   2005-02-28 18:46:46.000000000 +0100
>+++ include/asm-i386/adeos.h    2005-03-04 11:23:09.000000000 +0100
>@@ -37,6 +37,7 @@
>  #ifdef CONFIG_SMP
>
>  #include <asm/fixmap.h>
>+#include <asm/mpspec.h>
>  #include <mach_apicdef.h>



-Nathaniel J. Villaume
Jet Propulsion Laboratory
(818) 393 0881

***   All personal and professional opinions presented herein are 
my      ***
***   own and do not, in any way, represent the opinion or policy of JPL. 
***




