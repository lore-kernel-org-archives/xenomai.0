MIME-Version: 1.0
From: Means Lee <leemeaner@gmail.com>
Date: Tue, 20 Nov 2018 05:57:45 +0800
Message-ID: <CALUpYNbg342eACKbNoxZkKV-ykGjRxJhS_xz0oJxzyeSKgxh6Q@mail.gmail.com>
Subject: rt_e1000e: Detected Hardware Unit Hang
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

I am porting newer e1000e driver to Xenomai 3.0.7. When I using my ported
driver to setup an
RTnet connection, something goes wrong. What I got is an Hardware Unit hang:

[ 1598.783133] rt_e1000e: Detected Hardware Unit Hang:
                 TDH                  <f5>
                 TDT                  <1e>
                 next_to_use          <1e>
                 next_to_clean        <f5>
               buffer_info[next_to_clean]:
                 time_stamp           <10004ea14>
                 next_to_watch        <f5>
                 jiffies              <10004f458>
                 next_to_watch.status <0>
               MAC Status             <40080083>
               PHY Status             <796d>
               PHY 1000BASE-T Status  <3800>
               PHY Extended Status    <3000>
               PCI Status             <10>

I'm sure that transmit and receive function works fine for I can send TDMA
sync frame normally.
But this message shown during the end of RTcfg ready stage. Is anybody has
any clue about how to fix this bug?
