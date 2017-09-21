MIME-Version: 1.0
From: Antoine Hoarau <hoarau.robotics@gmail.com>
Date: Thu, 21 Sep 2017 12:03:47 +0200
Message-ID: <CAB6vvjm0GH4kzobZ4c-FdqcARoDDwNFmAJBGOEWESFTwXoJw8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] MAXSMP prevents booting on 16.04/x64-4.9.38
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

After many trials and error, I finally found the option that made both
of my Ubuntu 16.04/x64 (i7 7500U and 2600K) to hang at Loading initial
ramdisk.

CONFIG_MAXSMP

* Processor type and features
  --> Enable maximum number of SMP processors and NUMA nodes

It seems to be enabled by default on kernel 4.x, and causes the system
to hang at

   x86 : Booting SMP configuration:
   .... node #0, CPUs:     #1

I've always built the kernel with the xenomai patch, but I don't think
the two are related.
Did any of you had this issue as well ?

------
Antoine Hoarau

