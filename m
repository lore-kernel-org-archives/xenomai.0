MIME-Version: 1.0
From: danwe <daniel.wenninger92@gmail.com>
Date: Thu, 13 Jun 2019 08:22:55 +0200
Message-ID: <CAEmXcAwdGfGetA09TBP4-k7UCgSzdCr4TYA6NGC09Pg3cDtWeA@mail.gmail.com>
Subject: Precision Time Protocol on Xenomai 2
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I am using two Beaglebone Black with Linux kernel version 3.8.13 and
Xenomai version 2.6.3. I have built the Kernel with Xenomai and RTnet with
buildroot.

I have checked the NIC's timestamping capabilities using ethtool: #
ethtool -T eth0

and get the respond: -sh: ethtool: not found.

Does that mean that Xenomai 2 is not able to provide PTP? Or is there
a different command for "ethtool" while using Xenomai? I have also
tried "rtethtool" but same problem. Does anybody know if it works with
Xenomai 3?

Thanks.

Daniel
