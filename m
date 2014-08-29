From: "Yogi A. Patel" <yapatel@gatech.edu>
Message-Id: <7DEE8379-159F-470A-B22D-01B16FBEECB3@gatech.edu>
Date: Thu, 28 Aug 2014 22:13:36 -0400
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain;
	charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Analogy PCI Slot issues?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi -

We=92ve been using analogy_config to load our NI DAQ cards for quite =
some time. Recently, we ran into a strange issue and can=92t figure out =
what the problem is.

The DAQ card we have is PCI-6036E. We use analogy_ni_pcimio. We have =
other machines that work with this DAQ and the same analogy driver.

We run $ sudo analogy_config analogy0 analogy_ni_pcimio 0x1,0a=20

and get: $ analogy_config: attach failed err=3D-2 ERROR: Analogy device =
loading failed.

We run $ sudo analogy_config analogy0 analogy_ni_pcimio 0x1,0a=20

and still get: $ analogy_config: attach failed err=3D-2 ERROR: Analogy =
device loading failed.

dmesg shows:

[  185.109375]  [<ffffffff81d45c52>] start_kernel+0x418/0x423
[  185.109378]  [<ffffffff81d45643>] ? repair_env_string+0x5c/0x5c
[  185.109381]  [<ffffffff81d4532c>] =
x86_64_start_reservations+0x130/0x133
[  185.109384]  [<ffffffff81d4544a>] x86_64_start_kernel+0x11b/0x11e
[  185.109386] ---[ end trace 58713d25bdf2b468 ]---
[  220.695488] Xenomai: RTDM: closing file descriptor 0.
[  258.008414] Analogy: a4l_assign_driver: call(drv->attach) failed =
(ret=3D-2)
[  596.236449] Analogy: a4l_assign_driver: call(drv->attach) failed =
(ret=3D-2)

Is it possible that the issue is because the device number has a letter =
in it? This is the first time I am seeing a DAQ card being assigned a =
letter for the device number.

Any help appreciated - thank you!

Yogi

