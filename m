Message-ID: <42288DFC.3050104@domain.hid>
Date: Fri, 04 Mar 2005 17:34:04 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] 2.6.9-r9c5  patch problem
References: <6.1.1.1.2.20050303164341.0298e420@domain.hid> <42283891.2060807@domain.hid> <6.1.1.1.2.20050304081745.02773fe0@domain.hid>
In-Reply-To: <6.1.1.1.2.20050304081745.02773fe0@domain.hid>
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
> Yes, that helped tremendously! At least I can build now!

Good. Btw, make sure you don't have CONFIG_FRAME_POINTER enabled in SMP 
mode (UP is ok), there is a random bug caused by a conflict w/ the Linux 
profiling code I've just fixed in the CVS. The next patch will include 
this fix.

> 
>> I cannot reproduce this bug using 3.4.3 + Athlon SMP config, but does 
>> the following patch make things any better?
>>
>> --- include/asm-i386/adeos.h~   2005-02-28 18:46:46.000000000 +0100
>> +++ include/asm-i386/adeos.h    2005-03-04 11:23:09.000000000 +0100
>> @@ -37,6 +37,7 @@
>>  #ifdef CONFIG_SMP
>>
>>  #include <asm/fixmap.h>
>> +#include <asm/mpspec.h>
>>  #include <mach_apicdef.h>
> 
> 
> 
> 
> -Nathaniel J. Villaume
> Jet Propulsion Laboratory
> (818) 393 0881
> 
> ***   All personal and professional opinions presented herein are 
> my      ***
> ***   own and do not, in any way, represent the opinion or policy of 
> JPL. ***
> 
> 
> 
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

