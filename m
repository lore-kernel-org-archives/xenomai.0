MIME-Version: 1.0
Date: Tue, 5 Jun 2012 17:13:05 +0530
Message-ID: <CAM1yFZ9ndx+EDWAig-nkYmcc-jgirwm6N0UYbK1g-8roQTMMYQ@mail.gmail.com>
From: Anisha Kaul <born.rebel.83@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] ./rtnet start rteth0-mac: unknown interface: No such
 device ioctl: No such device
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Greetings,

I have installed the RTnet over Xenomai without examples.
RTnet compiled well, and I also tested loopback on the single machine
and was able to ping.

However I noticed `./rtnet start` showing the following output:
What should I interpret when all it says is "no such device"?

`
linux-y3pi:/usr/local/rtnet/sbin # ./rtnet start

rteth0: unknown interface: No such device
rteth0-mac: unknown interface: No such device
ioctl: No such device
ioctl: No such device
ioctl: No such device
ioctl: No such device
ioctl (add): No such device
vnic0: unknown interface: No such device
SIOCSIFADDR: No such device
vnic0: unknown interface: No such device
SIOCSIFNETMASK: No such device
Waiting for all slaves...ioctl: No such device
ioctl: No such device

linux-y3pi:/usr/local/rtnet/sbin #
`

-- 
Regards,
Anisha

