MIME-Version: 1.0
Date: Mon, 9 Jul 2012 22:30:27 -0400
Message-ID: <CAKSrRNzt7tRjShU79EFYv71SbYwhjmagP11KCAk7-LUCTqXdzA@mail.gmail.com>
From: Sunetra Sashi <snmgmt19@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] XDDP and inter-driver API.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I am trying to use the XDDP module in order to achieve linux-xenomai domain
cross communication. However, when I install my module which creates a
socket and binds its to the XDDP port, via the *rtdm_socket(AF_RTIPC,
SOCK_DGRAM, IPCPROTO_XDDP)* call, it fails. Also, when I try to open the
device on the linux side, via an *rtdm_open("/dev/rtp0", O_RDWR)*, it also
fails.

Do I need to install any specific xenomai modules for this to work?

Thanks
Shweta
