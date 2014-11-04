MIME-Version: 1.0
Date: Tue, 4 Nov 2014 11:57:58 +0200
Message-ID: <CADLCHM+eyrDUh4fBdTEk4TrDzsPmnGghaH-07XT=zFLxojtS4g@mail.gmail.com>
From: Seda Seda <seda9seda9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Communicate to a device
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have a non real time device. I communicated it using syscall
functions.Now, I am writing a kernel module and an user space
application. When I attach device to pc, ttyACM0 file creates under /dev.

When I install my module as device name is "ttyACM0", I see a driver
in proc/rtdm/named_devices file. But when I write "/dev/ttyACM0" and
install module, I get an error. It says that "Cannot allocate memory".
