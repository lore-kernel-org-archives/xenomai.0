MIME-Version: 1.0
From: Jordan Paul <jordanjp7701@gmail.com>
Date: Tue, 7 Jul 2020 10:32:22 +0800
Message-ID: <CABQtCRFiwDnHmaGqudAxXOp5jrAykjP7cpL=S8Q2Ce2hVkocOQ@mail.gmail.com>
Subject: Question on tx/rx queue in RTnet
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

Hi

I am using i210 driver with xenomai 3.1 on kernel 4.19

rt_igb 0000:01:00.0: Using MSI-X interrupts. 1 rx queue(s), 1 tx queue(s)


based on the above dmesg log, I am currently getting 1 tx and 1 rx queue,
is this by design for RTnet?

igb 0000:01:00.0: Using MSI-X interrupts. 4 rx queue(s), 4 tx queue(s)


compared with linux drivers for igb, I am getting 4 tx and 4 rx queue.

Regards.
