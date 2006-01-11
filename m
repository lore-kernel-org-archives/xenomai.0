Message-ID: <43C50324.7050706@domain.hid>
Date: Wed, 11 Jan 2006 14:07:48 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newbie heap usage problem
References: <43C50BA1.7020908@domain.hid>
In-Reply-To: <43C50BA1.7020908@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "S. ancelot" <sancelot@domain.hid>
Cc: xenomai@xenomai.org

S. ancelot wrote:
> Hi,
> I tried to make a programming sample using heap .
> The heap seems to be created regarding registry in proc, but then the  
> program seg faults
> 
> 
> Here is my program
> 
> #include <sys/mman.h>
> #include <xenomai/native/heap.h>
> #include <stdio.h>
> 

- RT_HEAP *m;
+ RT_HEAP m;

> int x;
> 
> int main()
> {
>  mlockall(MCL_CURRENT|MCL_FUTURE);

- x = rt_heap_create(m,"toto",100,H_SHARED);
- rt_heap_delete(m);
+ x = rt_heap_create(&m,"toto",100,H_SHARED);
+ rt_heap_delete(&m);

>  return 0;
> 
> }
> 
> Best Regards
> S@
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

