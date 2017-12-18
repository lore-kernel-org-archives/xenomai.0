MIME-Version: 1.0
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 18 Dec 2017 09:12:59 -0500
Message-ID: <CALLqZ8SeLUSSexYTnW7=ZDMKCom6HNDssrwZ2FcUgCNDpqOYWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] rt_imx_uart
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
  I looked into why this driver isn't compiling, basically it needs to
be brought up to match the newer imx serial driver.  It's relying on
files and structures that existed in earlier versions of the kernel
before a reorganization happened (around 3.18 I think).  I have access
to a i.mx6 board and don't mind taking this on unless someone else as
already done it?

Thanks

Greg

