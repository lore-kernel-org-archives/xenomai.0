MIME-Version: 1.0
Date: Thu, 18 Jun 2015 14:50:48 +0200
Message-ID: <CANprwBMXsCVdx0qup4e=weJpWW8WZtP2TfZSiT58MhRODSpNsQ@mail.gmail.com>
From: fre go <fgosew@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RTcfg module waits forever after "rtcfg rteth0 server"
 has been called
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm currently working with Xenomai 3 (first rc4, now git head) with Kernel
3.16.7 and encountered a problem with both versions concerning rtnet: When
I try to start rtnet with "rtnet start" the call stalls and sometimes even
locks the kernel. I could trace this back to the "rtcfg rteth0 server" and
further investigation via kgdb debugging via virtual machine showed that
the call to "rtdm_event_signal" in rtnet_rtpc.c seems to be not answered.
Although the kernel should be waiting interruptible most of the time ctrl+c
does nothing. Sometimes it does what it's supposed to (interrupt) but after
another call to "rtnet start" the kernel often fails with a oops or even a
panic). Could it be the kernel which fails here and not xenomai? I'm
currently out of ideas how to tackle this problem on my own. Maybe somebody
could point me into the right direction.

My dev machine is running on KVM and it as been tested with xenomai 2.6.4
and RTnet 0.9.13 git head, both with different nics (e1000, rtl8139) so I
can rule out possible KVM or Qemu issues.
