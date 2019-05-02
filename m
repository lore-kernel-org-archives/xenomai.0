From: Steve Freyder <steve@freyder.net>
Subject: --print-buffer-syncdelay, lib/cobalt/init.c:cobalt_help()
Message-ID: <5CCB1CE0.6020102@freyder.net>
Date: Thu, 2 May 2019 11:37:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Greetings,

I had a dev complain about losing stdio output in a Xenomai app, and
had never looked at rt_printf() and friends before.  I had
problems attempting to use --print-buffer-syncdelay=1 to reduce the
delay to 1(ms), I found that my programs started complaining about an
invalid switch.  Found that cobalt_help() was out of sync with the
actual switch name definition --print-sync-delay.

Here's a lame attempt at a patch.

Regards,
Steve
------------------------------------------------------------------------


lib/cobalt:
------------------------------------------------------------------------
diff -Naur a/init.c b/init.c
--- a/init.c    2018-06-15 10:26:19.692062099 -0500
+++ b/init.c    2019-05-02 11:16:07.894454047 -0500
@@ -349,7 +349,7 @@
          fprintf(stderr, "--main-prio=<prio>            main thread 
priority\n");
          fprintf(stderr, "--print-buffer-size=<bytes>   size of a print 
relay buffer (16k)\n");
          fprintf(stderr, "--print-buffer-count=<num> number of print 
relay buffers (4)\n");
-        fprintf(stderr, "--print-buffer-syncdelay=<ms> max delay of 
output synchronization (100 ms)\n");
+        fprintf(stderr, "--print-sync-delay=<ms>       max delay of 
output synchronization (100 ms)\n");
  }

  static struct setup_descriptor cobalt_interface = {
------------------------------------------------------------------------


