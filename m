Message-ID: <4A94EE84.5040101@domain.hid>
Date: Wed, 26 Aug 2009 10:12:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1251273701.4345.9.camel@domain.hid>
In-Reply-To: <1251273701.4345.9.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation fault in rt_printf print thread
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Christoph Permes <christoph.permes@domain.hid>
Cc: xenomai@xenomai.org

Christoph Permes wrote:
> Hi, 
> 
> I'm using rt_printf for debug output. When running tests for 20 hours or
> longer, sometimes I get a segmentation fault.
> 
> The backtrace shows:
> #0  0xb7d008d8 in fputs () from /lib/libc.so.6
> #1  0xb7f26f61 in print_buffers () from /usr/xenomai/lib/librtdk.so.0
> #2  0xb7f26fb3 in printer_loop () from /usr/xenomai/lib/librtdk.so.0
> #3  0xb7c92f3b in start_thread () from /lib/libpthread.so.0
> #4  0xb7d6fb6e in clone () from /lib/libc.so.6
> 
> It seems to me that there is a bug in the print thread.
> 
> My program runs on x86 using the following software versions:
> Kernel 2.6.29.5
> Xenomai 2.4.9
> I-Pipe patch: adeos-ipipe-2.6.29.5-x86-2.4-02.patch

Could you try the following patch?

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 0615247..a0aeec3 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -422,6 +422,7 @@ void __rt_print_init(void)
        pthread_attr_t thattr;
        const char *value_str;
        unsigned long long period;
+       unsigned stksize;

        first_buffer = NULL;
        seq_no = 0;
@@ -457,6 +458,9 @@ void __rt_print_init(void)
        pthread_cond_init(&printer_wakeup, NULL);

        pthread_attr_init(&thattr);
-       pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+       stksize = 32768;
+       if (stksize < PTHREAD_STACK_MIN)
+               stksize = PTHREAD_STACK_MIN;
+       pthread_attr_setstacksize(&thattr, stksize);
        pthread_create(&printer_thread, &thattr, printer_loop, NULL);
 }


-- 
                                          Gilles


