Message-ID: <4509DBEB.7020707@domain.hid>
Date: Thu, 14 Sep 2006 17:47:07 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] invalid use of FPU in Xenomai context
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

I made some more progress in porting my RTLinux application, but now I'm spinning my wheels trying to track down the source of the following error:

  "invalid use of FPU in Xenomai context at ..."

I am doing floating point calculations inside a real-time POSIX thread in kernel-space.  I am puzzled because I can create a simple test program that uses floating point operations in a real-time thread without any errors.  I create the task with something like this:

      pthread_attr_init(&attr);
      pthread_attr_setfp_np(&attr, 1);
      result = pthread_create(&fptest_task, &attr, &fptest_routine, NULL);

In fact, it seems that the fp attribute is already 1 by default, because I get no floating point errors if I leave out the pthread_attr_setfp_np line.  I do get an error if I do this:

  pthread_attr_setfp_np(&attr, 0);

I am doing the same thing in my much more complicated real-time application.  In fact, I can even insert a loop with some floating-point code at the beginning of my thread, and it works fine.  The problem is that something in my application code is triggering the "invalid use of FPU" error.

Does anyone have any ideas of what could trigger this besides not setting the fp attribute for the thread?

Thanks,

Jeff

