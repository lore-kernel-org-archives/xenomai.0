Message-ID: <4A012DDE.7030601@domain.hid>
Date: Wed, 06 May 2009 08:27:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <431263.25323.qm@domain.hid>
In-Reply-To: <431263.25323.qm@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shared library in xenomai ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: luan dinh <dinhluanbmt@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

luan dinh wrote:
> hi.
> My program included :
> + libsock.c
> + demo_use.c
> + Makefile
> i build libsock.c as shared library named libmylibra.so ( support my_send() function )
> demo_use.c use my_send() and built with -lmylibra option
> Thanks for any advise.
> Luan Dinh
> PS :i also attach the source code of these files 
> ######### libsock. c###
> void demo(void *agr)
> {    
>     int len,i;
>     rt_task_set_periodic(NULL, TM_NOW, 100000000);
>     while (1) {       
>     rt_task_wait_period(NULL);
>     len = send(sock, data, sizeof(data), 0);
>         if (len < 0)
>     {
>         printf("Sent Failed...!\n");
>             break;
>     }    
>     }       
> }
> /*my_send*/
> int my_send()
> {    
>     struct sched_param param;// = { .sched_priority = 1 };     
>       struct sockaddr_ll addr;
>       struct ifreq ifr;    
>     mlockall(MCL_CURRENT|MCL_FUTURE);    
>     if ((sock = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL))) < 0) {
>             perror("socket cannot be created");
>             return 1;
>     }
>     strncpy(ifr.ifr_name, "rteth0", IFNAMSIZ);
>     if (ioctl(sock, SIOCGIFINDEX, &ifr) < 0) {
>             perror("cannot get interface index");
>             close(sock);
>             return 1;
>        }
>      addr.sll_family   = AF_PACKET;
>         addr.sll_protocol = htons(ETH_P_ALL);
>     addr.sll_pkttype  = PACKET_OTHERHOST;
>         addr.sll_ifindex  = ifr.ifr_ifindex;
> 
>         if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
>             perror("cannot bind");
>             close(sock);
>             return 1;
>         }
>     
>     rt_task_create(&demo_task, "mytask", 0, 99, 0);
>     rt_task_start(&demo_task, &demo, NULL);      
>     return 1;
> }
> 
> ### demo_use.c ###
> int main( int argc, char * argv[] )
> {
>     my_send();
>     pause();    
>     return 1;    
> }
> 
> ## Makefile ###
> CC = gcc
> AR = ar cru
> SOFLAGS = -shared -Wl

The -Wl means that you are going to pass a flag to the linker. So, this
declaration of SOFLAGS is a bit like a sentence which you started and
did not finish.

> CFLAGS = -I/usr/xenomai/include -I/usr/xenomai/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -Wall -g -fPIC -rdynamic -pipe -O2 -fstrict-aliasing
> LDFLAGS = -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lpthread_rt -lpthread -lnative -lrt -lstdc++ -ldl

Bad. You should use xeno-config to obtain the CFLAGS and the LDFLAGS.

> LINKER = $(CC)
> LINT = lint -c
> RM = /bin/rm -f
> LIBOBJS =  libsock.o 
> TARGET =  libmylibra.so \
>         test 
> all: $(TARGET)
> libmylibra.so: $(LIBOBJS)
>     $(LINKER) $(SOFLAGS) -o $@ $^ -lc

As I told you in my previous mail, you should use LDFLAGS when linking
libmylibra.so.

Also, if you are working on an embedded system, it is a better idea to
use either the native skin or the posix skin, not use both. This way,
you can compile only one of the two skins in the kernel, and you put
only one of the two libraries on your system.

-- 
					    Gilles.

