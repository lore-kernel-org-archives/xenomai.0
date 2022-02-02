Date: Wed, 02 Feb 2022 16:12:50 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: UDD with shared interrupts?
Message-ID: <A9p1YZoCjJLY022S76mAXuvt70QWpXy_dZ-qDq4aUPqDLINgdbSY7qUhHeUmAa0FML6gZWvd7_q2SUQyTBNVeq2r-liU6CnL_ZrzuesB0dc=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I am updating and reworking a UDD driver stub and happened to notice a diff=
erence between the UDD and UIO APIs.  It looks like udd_register_device() a=
lways passes "0" as the rtdm_irq_request() "flags" argument, whereas uio_re=
gister_device() allows flags to be passed in to request_irq().  Does this m=
ean that shared interrupts are not currently possible with UDD drivers?  Is=
 there a reason for this difference in the UDD and UIO APIs?

Thanks,

-Jeff Webb


