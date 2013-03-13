Message-ID: <5140EEEA.2080209@yahoo.com>
Date: Wed, 13 Mar 2013 16:26:02 -0500
From: Tom Z <tomz30@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] linkage problem under 2.6.2.1
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

First I would like to sincerely thank all the people here that kindly 
helped me with my previous problems regarding Xenomai installation.
Now I got Xenomai 2.6.2.1 running on Ubuntu 12.04 (Linux-3.5.7) . I 
added 
"/usr/xenomai/bin:/usr/xenomai/lib:/usr/xenomai/include:/usr/local/lib" 
to my $PATH, and can run "xeno latency" and "xeno-test".
However, when I tried to compile this toy program found at 
http://www.cs.ru.nl/lab/xenomai/ , I got some linage problems as follows:
/tmp/ccwl2tpg.o: In function `main':
ex01.c:(.text+0x8a): undefined reference to `rt_print_auto_init'
ex01.c:(.text+0xa2): undefined reference to `rt_printf'
ex01.c:(.text+0xe3): undefined reference to `rt_task_create'
ex01.c:(.text+0xff): undefined reference to `rt_task_start'
collect2: ld returned 1 exit status

The above source code can be compiled & linked under Xenomai 2.4.3 
smoothly, and I understand that the rtdk library had been moved to 
libxenomai, so I changed the build flags accordingly. Below is what I 
used to build the above toy program:
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ 
-lnative -L/usr/xenomai/lib -lxenomai -lpthread -lrt -lxenomai ex01.c -o 
ex01

On my system, running "xeno-config --skin=native --cflags" gets 
"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__",
and running "xeno-config --skin=native --ldflags" gets "-lnative 
-L/usr/xenomai/lib -lxenomai -lpthread -lrt".
Under "/usr/xenomai/lib", I can find libnative.[a|la|so], 
libxenomai.[a|la|so], and other libs.

I don't understand why there are still undefined reference to 
`rt_print_auto_init', etc. Did I miss something while building this program?

With many thanks,
Tom

