MIME-Version: 1.0
From: Luca Barisani <lcbarisa@gmail.com>
Date: Sat, 9 Nov 2019 10:23:36 +0100
Message-ID: <CABe-JLW82TeFyeL5Eft07XZWp1gY1o=aXXv60zCq6JA3vvKfeg@mail.gmail.com>
Subject: rtnet increase default mtu
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

Hi,

I'm testing xenomai 3.1.0-rc2+linux kernel 4.19 with rtnet.
The application sends udp packets between a small number of units (intel
celeron/i5), some with an e1000 and others with igb (i210), connected
to the same switch and isolated from the rest of the network.
Rtnet is loaded without tdma support, I'm using nomac and so far all is
working fine. However, I was wondering if it could be possible to increase
mtu default value of 1500 to improve bandwidth.
I could not find any mtu option within rtifconfig, so I'm asking if this
value is fixed by design, maybe to avoid ip fragmentation, or there are
some ways to change its size.

Thanks
Luca
