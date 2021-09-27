MIME-Version: 1.0
From: Marco Barletta <barlettamarco8@gmail.com>
Date: Mon, 27 Sep 2021 15:58:33 +0200
Message-ID: <CAK6DXL1SrqJ=n2md4cWqYefzEE+t_Lkqvdmcf0h=ePraF2z3dw@mail.gmail.com>
Subject: failed RTnet ping
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

Hi everyone. I had some issues configuring my rtnet setup. I have a couple
of machine with NIC I217-LM by Intel. They are attached to a switch. When i
try to setup rtnet everything goes fine through the stages of rtnet start
that correctly returns on both sides. However when I try to ping I have
some failures. I digged deep down in the kernel calls and I discovered that
after a little from the configuration the kernel logs messages of "Failed
to transmit sync frame". I discovered that alloc_rtskb in
tdma_xmit_sync_frame fails because inside of it rtskb_pool_dequeue return
null. It happens since __rtskb_pool_dequeue return null because the pool is
empty. Can someone help me?
I run a 5.4.77 kernel with xenomai 3.1.1

-- 
Marco Barletta
