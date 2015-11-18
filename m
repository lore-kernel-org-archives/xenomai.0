Message-ID: <trinity-3b905084-1366-4586-b761-0f15088b0d82-1447853696479@3capp-webde-bap53>
From: JK.Behnke@web.de
Date: Wed, 18 Nov 2015 14:34:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

   Hello,

   I'm currently debugging a problem in my xenomai application.
   In order ot get timing information I do the following inside the
   read-handler of my rtdm driver.

   // --- start code snippet ---------------------------------
   nanosecs_abs_t  t1, t2;
   rtdm_lock_get_irqsave(&lockobj, lockctx);

   t1=rtdm_clock_read();
   rtdm_task_busy_sleep(10000); // code block to be measured.
   t2=rtdm_clock_read();

   rtdm_lock_put_irqrestore(&lockobj, lockctx);
   // --- end code snippet ---------------------------------

   I observe the following time differences  t2-t1:
   min=10176 ns,  max=10737 ns, avg=10314 ns

   This means in this case the average overhead of the two rtdm_clock_read
   calls is
   approximately 314 ns/2 = 157 ns.

   Is that realistic?
   Are there any other functions I might use to measure execution time of
   an arbitrary code block?

   I'm running xenomai 2.6.3 on linux kernel 3.8.13.
   Hardware platform is Intel Atom E640 (1.0 GHz)

   Thanks in advance
   Jochen
