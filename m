MIME-Version: 1.0
From: John Allwine <john@allwinedesigns.com>
Date: Thu, 14 Dec 2017 10:07:49 -0700
Message-ID: <CAA9ERVojO-dEBt_ouEdnmnucu+znLbTfg1UvhQWodntaGnSbLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Xenomai: halcmd[1311] cannot map MAYDAY page
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm using the latest machinekit image for the 3.8 kernel on the Beaglebone
Black (
https://rcn-ee.com/rootfs/bb.org/testing/2017-02-12/machinekit/bone-debian-8.7-machinekit-armhf-2017-02-12-4gb.img.xz).
It's using xenomai 2.6.3. I follow the steps in this document to set up
machinekit as a systemd service:
https://github.com/PocketNC/pocketnc/blob/master/README.md

When I start machinekit manually after bootup, it seems to work fine. When
the services are started during boot up as a systemd service, I get the
following error (I can provide the full stack trace if that would help):
[ 19.501859] Xenomai: halcmd[1311] cannot map MAYDAY page
[ 19.956681] Unable to handle kernel NULL pointer dereference at virtual
address 00000004
[ 19.965136] pgd = de414000, hw pgd = de414000
[ 19.969675] [00000004] *pgd=9e7c4831, *pte=00000000, *ppte=00000000
[ 19.976229] Internal error: Oops: 817 [#1
<https://github.com/machinekit/machinekit/issues/1>] THUMB2
[ 19.981128] Modules linked in: g_ether libcomposite cpufreq_userspace

I filed this issue on machinekit's github repo as well:
https://github.com/machinekit/machinekit/issues/1332

Any thoughts on what the problem could be? Or how to debug this further?

-John
