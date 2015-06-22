MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Mon, 22 Jun 2015 09:43:33 +0100
Message-ID: <CAKk99t2XmS1FSxmoJJ7DSCfgsPw5vOrf60BxK15w2XE9zgTe6g@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] How to make user space app wait to read from driver with
 rtdm_select? (Xenomai 3.x)f
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>, Helder Daniel <hdaniel@ualg.pt>

Hi,

I am writing a Xenomai 3.x RTDM driver.
This driver gets data from a device and stores it a buffer. This takes a
while.
After buffer is filled a user space application issues a read call to the
driver fd get data.

The problem is how to make user space app wait for the buffer to be filled.

One could think on using the poll interface (http://linux.die.net/man/2/poll
),
but as I understood from Xenomai 3.0-rc5 API reference there is no real
time implementation of poll or epoll.

However I found there a real time implementation of select:
RTDM_select_handler.
I am assuming that (can I?) in user space an app use select the same way as
with POSIX (http://linux.die.net/man/2/select)

Unfortunately I did not find any example of programming the rtdm_select
driver handler.
In (https://xenomai.org/migrating-from-xenomai-2-x-to-3-x/) shows how to
declare the handler in a (struct rtdm_driver) but not how to program the
handler function.

Is there any example of implementing rtdm_select handler? For instance in
the Xenomai 3.x-rc4 source code? I tried to find it in the drivers section
but I didn't (I might be looking in the wrong place).

Or there is another (better?) way to make an user space app (real time)
wait for the driver before reading from it?

Thanks,

Helder Daniel
