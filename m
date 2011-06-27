Message-ID: <4E08C03D.9010407@domain.hid>
Date: Mon, 27 Jun 2011 13:39:09 -0400
From: Andrew Tannenbaum <trb@domain.hid>
MIME-Version: 1.0
References: <4DF934BD.50505@domain.hid>
	<4DFA1F3C.7090209@domain.hid>
	<261CC64699FF40F2937C31EEF248B8E5@domain.hid>
In-Reply-To: <261CC64699FF40F2937C31EEF248B8E5@domain.hid>
Content-Type: multipart/mixed; boundary="------------040900060602080304040509"
Subject: Re: [Xenomai-help] rtcanrecv output line-buffering
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------040900060602080304040509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Wolfgang Grandegger wrote:
> On 06/16/2011 05:20 PM, Andrew Tannenbaum wrote:
>> I was trying to use the Xenomai RT-Socket-CAN rtcanrecv in a Tcl/Tk
>> script GUI wrapper.
>>
>> rtcanrecv uses printf to stdout, and it line-buffers when attached to a
>> tty, but it uses larger buffers (so it is unusable) when run from a
>> script with no tty.
>>
>> Tcl does stdio with pipes rather than ptys (that is, Tcl thinks it has
>> no tty for stdio).  I think both bash and perl use ptys (and so don't
>> have this problem).  I haven't done a more thorough survey, but that's
>> not the point.
>>
>> I think it would be nice to modify rtcanrecv so it can write stdout in
>> line-buffered mode.  If you think this is a good idea, please either set
>> line buffering with
>>
>>      setvbuf(stdout, NULL, _IOLBF, 0);
>>
>> at the top of src/utils/can/rtcanrecv.c:rt_task() or
>>
>>      fflush(stdout);
>>
>> after the printf("\n") at the bottom of rt_task(), or you could add a
>> command line getopt option for line-buffering that would do one of the
>> above.
>
> I would prefer the latter, patches are welcome. Be aware that using
> printf will switch to secondary mode which should be avoided if
> real-time is required.
>
> Wolfgang.
>

Wolfgang,

rtcanrecv already exists using printf, I'm just changing the buffering. 
  I added a -L (line-buffer) getopt switch (default=off), as you 
suggested.  I added it to the C source and the man page.

Attached are two diff patch files, one for rtcanrecv.c and one for 
rtcanrecv.man.in .  I see there is a generated version of the html man 
page in the tar file, I assume that is created automatically, so I 
didn't patch it.  I created the patches within the folders containing 
the source files, and I diffed from filenames foo.orig to foo.  I am not 
aware of the naming protocol for patches in the development tree, but 
these are simple patches so I hope they are sufficient.

-Andy

--------------040900060602080304040509
Content-Type: text/x-patch;
 name="rtcanrecv.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rtcanrecv.c.patch"

--- rtcanrecv.c.orig	2011-06-27 12:02:43.634343171 -0400
+++ rtcanrecv.c	2011-06-27 12:12:32.834332555 -0400
@@ -24,6 +24,7 @@
 	    " -R, --timestamp-rel   with relative timestamp\n"
 	    " -v, --verbose         be verbose\n"
 	    " -p, --print=MODULO    print every MODULO message\n"
+	    " -L, --line-buffer     use line buffering\n"
 	    " -h, --help            this help\n",
 	    prg);
 }
@@ -31,7 +32,7 @@
 
 extern int optind, opterr, optopt;
 
-static int s = -1, verbose = 0, print = 1;
+static int s = -1, verbose = 0, print = 1, line_buffer = 0;
 static nanosecs_rel_t timeout = 0, with_timestamp = 0, timestamp_rel = 0;
 
 RT_TASK rt_task_desc;
@@ -174,6 +175,7 @@
 	{ "timeout", required_argument, 0, 't'},
 	{ "timestamp", no_argument, 0, 'T'},
 	{ "timestamp-rel", no_argument, 0, 'R'},
+	{ "line-buffer", no_argument, 0, 'L'},
 	{ 0, 0, 0, 0},
     };
 
@@ -182,7 +184,7 @@
     signal(SIGTERM, cleanup_and_exit);
     signal(SIGINT, cleanup_and_exit);
 
-    while ((opt = getopt_long(argc, argv, "hve:f:t:p:RT",
+    while ((opt = getopt_long(argc, argv, "hve:f:t:p:RTL",
 			      long_options, NULL)) != -1) {
 	switch (opt) {
 	case 'h':
@@ -230,6 +232,10 @@
 	    with_timestamp = 1;
 	    break;
 
+	case 'L':
+	    line_buffer = 1;
+	    break;
+
 	default:
 	    fprintf(stderr, "Unknown option %c\n", opt);
 	    break;
@@ -311,6 +317,10 @@
 	}
     }
 
+    if (line_buffer) {
+	setvbuf(stdout, NULL, _IOLBF, 0);
+    }
+
     snprintf(name, sizeof(name), "rtcanrecv-%d", getpid());
     ret = rt_task_shadow(&rt_task_desc, name, 0, 0);
     if (ret) {

--------------040900060602080304040509
Content-Type: text/x-patch;
 name="rtcanrecv.man.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rtcanrecv.man.in.patch"

--- rtcanrecv.man.in.orig	2011-06-27 13:19:28.558330768 -0400
+++ rtcanrecv.man.in	2011-06-27 13:20:27.798334902 -0400
@@ -46,6 +46,9 @@
 .B \-p, \-\-print=MODULO
 print every MODULO message
 .TP
+.B \-L, \-\-line-buffer
+flush buffered ouput for each line
+.TP
 .B \-h, \-\-help
 this help
 .SH "SEE ALSO"

--------------040900060602080304040509--

