Message-ID: <43D9F603.8000505@domain.hid>
Date: Fri, 27 Jan 2006 11:29:23 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] Fix to RTDM open problems
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

When RTDM is exposed to code like this:

   device1 = rt_dev_open("some_device", O_RDWR);
   device2 = rt_dev_open("some_device", O_RDWR);

I get a SEGFAULT, which I attribute to a missing assignment to context_ptr in 
the case when the device is already busy, the lack of this assignment leads to a 
segfault in cleanup_instance.


--- xenomai-2.1-rc2/ksrc/skins/rtdm/core.c~     2006-01-07 18:08:34.000000000 +0100
+++ xenomai-2.1-rc2/ksrc/skins/rtdm/core.c      2006-01-27 11:14:43.000000000 +0100
@@ -136,6 +136,8 @@

          if (context->device) {
              xnlock_put_irqrestore(&rt_dev_lock, s);
+
+            *context_ptr = NULL;
              return -EBUSY;
          }
          context->device = device;


