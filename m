MIME-Version: 1.0
Date: Fri, 6 Sep 2013 11:02:33 -0400
Message-ID: <CAGQdp5xsj_rFLHiiYzOk1yb2fkFT_gLAQKrAkLYOvgoL+sfFZw@mail.gmail.com>
From: Robert McCullough <robmccullough13@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] rt_dev_open returns 0, not working
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

Hi,

I am using Xenomai 2.6.2.1.

I have a  RTDM driver "rt_kmdpr" that I have developed and used for many
years.
When I open it with our older application rt_dev_open returns 1 for the
file number and everything works fine.
With a different application on a different device when I open it
rt_dev_open returns 0.
>From the Xenomai API, a zero returned from  rt_dev_open should be
valid.  "Positive
file descriptor value on success, otherwise a negative error code."
But when I call rt_dev_ioctl (0,...) it returns a -9, which I assume is
-EBADF ("Bad file number").

Is zero returned from rt_dev_open a valid file number?
If so, why is rt_dev_ioctl returning a -9?

Best Regards,
Rob McCullough
