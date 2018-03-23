MIME-Version: 1.0
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Fri, 23 Mar 2018 19:06:30 +0530
Message-ID: <CAOuPNLhfiTB7cXcs45yDMGceHzHc_Zvuv0Vx335Of9uPJb=W6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] Upgrading xenomai-3 patches in existing xenomai kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I just came across a situation about Xenomai upgrade, and wanted to
know your opinion.

Some 4 months back, I applied Xenomai-3 (and ipipe) patches to my x86
kernel 4.9.51, using the prepare_kernel script, and I am using it
since then.

But, now I wanted to upgrade to latest Xenomai kernel patches from
Xenomai-3 git.
Can I simply cherrypick the patches from Xenomai and apply to my Kernel ?
I guess the folder structures are different, so I guess it may not work cleanly.

So, what is the best way to apply the latest Xenomai Kernel patches,
on to existing Xenomai converted kernel repo, without disturbing the
previously applied patches ?

If there is any standard procedure you follow, please let me know.


Thanks,
Pintu

