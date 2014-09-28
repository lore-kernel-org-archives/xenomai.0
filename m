MIME-Version: 1.0
Date: Sun, 28 Sep 2014 08:53:20 +0530
Message-ID: <CALe7ZU3shAd1y2yWjEgnSJjHkVOmJ5o5bfd3P+Xpm04+oNMhdg@mail.gmail.com>
From: JAY KOTHARI <jaikothari10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] passing SMI parameter in kernel command line
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Sir,
     In troubleshooting guide I have read to pass xenomai.smi=1
in parameter to kernel command line.
     I am not able to get kernel command line.

What I tried
1)to pass this parameter at boot time.
2)I tried to change parameter in:
         sys/module/xeno_hal/parameters
3)I tried to do menuconfig and tried to change under "real
time-subsystem->Machine" but I am unable to find SMI menu under it.

How should I change this parameter? Do I have to make new patch on
Linux of Xenomai again?

I am using dell pc with following configuration
-Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz
-4 cores
-3.8 GiB RAM

