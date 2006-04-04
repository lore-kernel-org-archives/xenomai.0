Message-ID: <44328187.6080005@domain.hid>
Date: Tue, 04 Apr 2006 10:24:07 -0400
From: Randy Smith <rsmith@domain.hid>
MIME-Version: 1.0
References: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D042A2FEE@rennsmail02.eu.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Questions porting existing rtai-24.1.12 app to
	xenomai (PART II)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

Thanks Philippe and Fillod for your explanations of the situation wrt 
rtai skin and the gentle nudge to port the code to the native skin.  I 
have decided to go that route as I am going to have to go there 
eventually and there isn't that much code (famous last words.)

I must have installed xenomai incorrectly as my code is not compiling 
without some header files complaining about basic types like atomic_t 
not being defined.  I have a kernel source tree installed in a 
non-standard place, lets call it /home/randy/linux and the xenomai 
package under /home/randy/xenomai-2.1.0.  I have applied the adios patch 
and done the prepare_kernel.sh thing.  So far so good.  I can then do 
make menuconfig and setup the realtime stuff then make uImage and the 
kernel builds correctly (yes, I am cross-compiling for a powerpc).  That 
all works ok.

Where I'm confused is this.  Do I then do something like

$ cd /home/randy
$ mkdir xenomai && cd xenomai
$ ../xenomai-2.1.0/configure --build=i686-linux --host=ppc-linux 
--prefix=/home/randy
$ make all
$ make install

OR should I be in the kernel tree such as

$ cd /home/randy/linux
$ ../xenomai-2.1.0/configure --build=i686-linux --host=ppc-linux 
--prefix=/home/randy/linux

???

One of the problems I am seeing is that after the make all and make 
install, there is built, an include file tree under /home/randy/include 
and when I include this path on the compiler command line, I get 
circular references such as

#include <asm/atomic.h> from line 29 of /home/randy/include/asm/atomic.h

which should refer to the kernel include of 
/home/randy/linux/include/asm/atomic.h but instead picks up itself again 
and doesn't define the atomic_t (among other things)

Obviously I'm doing something wrong and any help would be appreciated.

Fillod Stephane wrote:
> Philippe Gerum wrote:
>   
>
>> people porting from the RTAI API to Xeno usually switch to Xeno's
>>     
> native 
>   
>> API directly.
>>     
>
> Indeed, switching directly to Xeno native is worth the advice (sigh).
>
>   

