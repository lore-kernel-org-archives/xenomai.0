From: Christoph Permes <christoph.permes@domain.hid>
In-Reply-To: <4A9642D3.5040304@domain.hid>
References: <1251273701.4345.9.camel@domain.hid>
	<4A94EE84.5040101@domain.hid> <1251354286.4321.19.camel@domain.hid>
	<4A9642D3.5040304@domain.hid>
Date: Thu, 27 Aug 2009 14:00:43 +0200
Message-Id: <1251374443.4321.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi,

I have examined the print_buffers() function and my core dump:

#1  0xb8087f61 in print_buffers () at rt_print.c:380
380				fprintf(head->dest, "%s", head->text);
(gdb) print head->dest
$1 = (FILE *) 0x445b205d
(gdb) print head->text
$2 = "_"
(gdb) print (char*)head
$3 = 0x8ea5a02 "] [D] [V_MainClampToteRequest   ] ===> [1]\n"
(gdb) print buffer->read_pos
$4 = 3482
(gdb) print *(char*)buffer->ring@domain.hid
$5 = "... [67046.506] [CONTROL] [1104820] [\000] [D] [V_MainClamp"

As the above output shows the head pointer points to a wrong memory
address, the head->dest FILE pointer results from some text written to
the buffer.

buffer = get_next_buffer();
if (!buffer)
        break;

read_pos = buffer->read_pos;
head = buffer->ring + read_pos;
len = strlen(head->text);

if (len) {
        /* Print out non-empty entry and proceed */
        fprintf(head->dest, "%s", head->text); // ==> SEGV
        read_pos += sizeof(*head) + len;
} else {
        /* Emptry entries mark the wrap-around */
        read_pos = 0;
}

Obviously the value of buffer->read_pos is not correct or the buffer
pointer returned by get_next_buffer() points to a wrong address.

Christoph

Am Donnerstag, den 27.08.2009, 10:24 +0200 schrieb Jan Kiszka:
> Christoph Permes wrote:
> > Am Mittwoch, den 26.08.2009, 10:12 +0200 schrieb Gilles Chanteperdrix:
> >> Christoph Permes wrote:
> >>> Hi, 
> >>>
> >>> I'm using rt_printf for debug output. When running tests for 20 hours or
> >>> longer, sometimes I get a segmentation fault.
> >>>
> >>> The backtrace shows:
> >>> #0  0xb7d008d8 in fputs () from /lib/libc.so.6
> >>> #1  0xb7f26f61 in print_buffers () from /usr/xenomai/lib/librtdk.so.0
> >>> #2  0xb7f26fb3 in printer_loop () from /usr/xenomai/lib/librtdk.so.0
> >>> #3  0xb7c92f3b in start_thread () from /lib/libpthread.so.0
> >>> #4  0xb7d6fb6e in clone () from /lib/libc.so.6
> >>>
> >>> It seems to me that there is a bug in the print thread.
> >>>
> >>> My program runs on x86 using the following software versions:
> >>> Kernel 2.6.29.5
> >>> Xenomai 2.4.9
> >>> I-Pipe patch: adeos-ipipe-2.6.29.5-x86-2.4-02.patch
> >> Could you try the following patch?
> >>
> >> diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
> >> index 0615247..a0aeec3 100644
> >> --- a/src/rtdk/rt_print.c
> >> +++ b/src/rtdk/rt_print.c
> >> @@ -422,6 +422,7 @@ void __rt_print_init(void)
> >>         pthread_attr_t thattr;
> >>         const char *value_str;
> >>         unsigned long long period;
> >> +       unsigned stksize;
> >>
> >>         first_buffer = NULL;
> >>         seq_no = 0;
> >> @@ -457,6 +458,9 @@ void __rt_print_init(void)
> >>         pthread_cond_init(&printer_wakeup, NULL);
> >>
> >>         pthread_attr_init(&thattr);
> >> -       pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
> >> +       stksize = 32768;
> >> +       if (stksize < PTHREAD_STACK_MIN)
> >> +               stksize = PTHREAD_STACK_MIN;
> >> +       pthread_attr_setstacksize(&thattr, stksize);
> >>         pthread_create(&printer_thread, &thattr, printer_loop, NULL);
> >>  }
> >>
> > 
> > I have tried the patch but it crashed again with the same backtrace.
> 
> Could you try to find out, what memory access is precisely causing the
> SEGV? Maybe even what variables of the rt_printf code have invalid
> states? Or do you have a portable test case for us to reproduce the issue?
> 
> Thanks,
> Jan
> 


