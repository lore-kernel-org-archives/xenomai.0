Date: Thu, 05 Mar 2015 13:30:08 +0100
From: "Mariusz Janiak" <mariuszjaniak@wp.pl>
Message-ID: <54f84c50d46d43.78129076@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Subject: Re: [Xenomai] status of rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: rtnet-developers@lists.sourceforge.net, Aaron.Wu@analog.com, Xenomai <xenomai@xenomai.org>

> On 2015-03-05 06:51, Wu, Aaron wrote:
> > Hello,
> > 
> >>From http://www.rtnet.org I saw the latest release of rtnet is years ago, latest kernel support is 3.2. What's the status and roadmap of this project? Any plan/schedule to support the newer version of kernel and xenomai?
> 
> Fortunately, RTnet has been "adopted" by the Xenomai project (its list
> is on CC). So the next RTnet release will actually be the next major
> Xenomai release: 3.0. You can already pick up the latest 3.0-rc of
> Xenomai to obtain a more recent version than what can be found in the
> RTnet git.

The second option is to chose Xenomai 2.6.4, kernel 3.14.17, and RTnet git with patch 0001-Fix-compilatin-issues-on-kernel-above-3.10.patch available here

http://sourceforge.net/p/rtnet/mailman/attachment/548fe484eab803.95654079%40wp.pl/1/

Regards,
Mariusz



