Message-ID: <53FE1832.7080808@nta-inc.net>
Date: Wed, 27 Aug 2014 12:41:06 -0500
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai-3: RTDM with Mercury?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

 From the recent traffic on the mailing list, and the website makeover, it sounds like Xenomai 3 is close to maturity, so I am trying to become familiar with the new technology.  I am very interested in the idea of having one code base that can be used in Linux, PREEMPT-RT, and dual-kernel applications.  Even with Xenomai 2, I have moved close to this goal by using the POSIX skin and using compiler directives to build my code as a standard linux application, or a real-time Xenomai version.

The main thing I am missing now is a unified interface to hardware devices, and it sounds like Xenomai 3 might be able to provide that.  From the introduction on the web site ( http://xenomai.org/introducing-xenomai-3/ ), it sounds like I should be able to use RTDM drivers with the standard linux kernel through the Mercury core.  How does this work?  Figure 3 shows a "native RTDM" block.  Is this block a kernel module that translates RTDM-specific calls into standard linux calls?  Does the translation happen at compile time or run-time?  Is there documentation on how I can write an RTDM driver that will work with both the Cobalt and Mercury cores?  For starters, can I access the 16550 RTDM driver from mercury?

I apologize if all of this is documented, and I've just missed it.  I also realize that Xenomai 3 is a work in progress and you haven't gotten to everything yet.  The documentation you have is very good, and I appreciate all the work you have put into it.

Thanks,

Jeff

