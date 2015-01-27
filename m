Date: Tue, 27 Jan 2015 09:19:01 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20150127081901.GA5658@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] rtdm on mercury
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hallo list,

I have been just getting to know xenomai-3 after a long time of
xenomai abstinence.  IIRC, there has been some talk in the past of
supporting rtdm in mercury for both user space and drivers.  But
looking at the present state, I don't see any sign of this having been
implemented.

Am I missing something?

[ background: wanting to write a driver for custom FPGA based hardware
  device, and the driver should work with and without cobalt.  I have
  done this before by making the driver code portable to both normal
  kernel and rtdm.  It would be nice to be able to write a pure rtdm
  driver and have it "just work" in a plain kernel. ]

Thanks,
Richard



