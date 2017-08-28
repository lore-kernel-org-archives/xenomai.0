Message-ID: <trinity-d9731ee4-e34a-4acf-9b6c-b6da3175962d-1503914754751@3c-app-gmx-bs61>
From: belinea123@gmx.de
Date: Mon, 28 Aug 2017 12:05:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Printf does not always show on the console
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


   I have troubles that the output of printf does not always show on the
   console.

   for(int i = 0; i<500; i++)
   {
      printf("this is my output. 01234567890123.....\n");
   }

   After 240 lines, the output stops in the middle of the sentence without
   a carriage return. The output of later printf calls appears after that.
   Same behaviour when I compile the app for debug or release. Calling
   fflush(stdout) does not make a difference.
   My app links a shared object which controls a rtdm device driver.
   The app and the shared object link xenomai and use the printf that is
   wrapped by xenomai.
   I couldn't reproduce it with a minimal cpp example.

   When I add rt_task_sleep(1000*1000) the output is Ok.

   When I start the app, I use the command line options
   --print-buffer-size=16384 --print-buffer-count=4
   --print-sync-delay=100. When i use print-buffer-size multiplied by 10,
   the output is Ok.

   Is this the normal behavior? This is difficult for me, as I use printf
   for debugging. Printf never returned a negative number, so I can't
   detect the problem in the code.

   I'm running cobalt (dual kernel).

   cat /proc/xenomai/version
   3.0.4

   ipipe
   ipipe-core-4.4.43-x86-6.patch

   uname -a
   Linux my_pc 4.4.43 #1 SMP Tue May 9 13:34:48 CEST 2017 x86_64 GNU/Linux


   Regards

   Chris
