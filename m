From: Alexander Frolov <frolov@nicevt.ru>
Subject: Xenomai with isolcpus and workqueue task
Message-ID: <c25a1993-e0e1-eebf-a4f8-a5c5f0d7604c@nicevt.ru>
Date: Sat, 11 Jul 2020 17:25:48 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all!

I am using Xenomai 3.1 with 4.19.124 I-pipe patchon a smp motherboard.=C2=
=A0=20
For my RT task I allocate few CPU cores
with isolcpus option. However, large latency spikes are noticed due to=20
igb watchdog activities (I am using common
igb driver, not rt_igb).

Looking into igb sources, it was understood that workqueue is used for=20
some tasks (afaiu, it is used to link status
monitoring)

from igb_main.c
...
 =C2=A0 INIT_WORK(&adapter->reset_task, igb_reset_task);
 =C2=A0 INIT_WORK(&adapter->watchdog_task, igb_watchdog_task);
...

The Linux kernel scheduler runs this igb activities on isolated CPUs=20
disregarding isolcpus option, ruining real-time
system behavior.

So the question, is it a correct way to use normal igb on Xenomai at all=20
or it is not recommended? What can be done
to prohibit Linux scheduler to allocate those tasks on isolated cores?

Thank you!

Best,
 =C2=A0=C2=A0 Alex

