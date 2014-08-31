MIME-Version: 1.0
Date: Sun, 31 Aug 2014 19:55:37 +0430
Message-ID: <CAKKWdtf4Rgs169TudtzyxWHL7L6QV3anFwGWHumKzRnkwTwQqw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rtser1!
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

I want to execute one example of RTDM, cross-link.c. It was compiled
but executed with an error:
can't open rtser1 (write) , no such device

Xenomai-2.6.3
ipipe-core-3.5.7-x86-4.patch

I have set the module for 16550A as built in and also tested by insmod
xeno_16550A.ko. The probe() function of the device driver is never
called I guess

Please tell me how to use that example. Thank you

