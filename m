Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Sep 2006 14:40:32 +0530
Message-ID: <9D98C51005D80D43A19A3DF329A61D69515623@domain.hid>
From: "Nilanjan Roychowdhury" <Nilanjan.Roychowdhury@domain.hid>
Subject: [Xenomai-help] driver migration
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org




Hi,
I had a linux driver with functionalities like it blocks a thread on an
ioctl and wakes it up when an interrupt occurs and does some processing.
Now I want to migrate to xenomai space. Can I write a user  space device
driver for this like I create an user space rt_task and call
rt_intr_wait in the entry fuction of the task and whenever I get an
interrupt I wake up and do the processing. Will I have any performance
hit?? I will make sure the priority of this xenomai task is higher than
any other xenomai task as it will do some interrupt processing.

In general, if I need to migrate a traditional linux device driver with
only user space clients to xenomai space can I write a user - space
device driver ???

Under what scenario we place a driver as a kernel module in xenomai
space??
Thanks,
-Nilanjan



