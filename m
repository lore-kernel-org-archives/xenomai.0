Date: Fri, 4 Jan 2013 09:50:19 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20130104085019.GA13416@localhost.localdomain>
References: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>
	<9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
	<20130103085312.GA8132@localhost.localdomain>
	<5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
	<20130103141552.GB9656@localhost.localdomain>
	<50E5E7D9.7020605@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50E5E7D9.7020605@xenomai.org>
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Jan 03, 2013 at 09:19:37PM +0100, Gilles Chanteperdrix wrote:

> Of course some of the code they contain is not really acceptable in
> mainline, but at least it is there and takes less time to debug than it
> would if starting from scratch.

That it takes "less time" is only sometimes true.
 
> Just trying to give a different opinion from Richard.

I actually agree with you, Gilles. If you are developing a consumer device

  - with a three year product lifetime
  - that will never receive a firmware upgrade
  - where time to market is most important

then the TI kernel is the best choice. But if you want to build, let's
say, a platform for a family of products with a five to ten year
scope, then maybe using TI's heavily modified v3.2 kernel is not best
way.

In any case, what is clearly best for the community is having mainline
support. I myself am interested in and am willing to help out with
xenomai on the beaglebone, but I will not waste my time with the TI
kernel. It is just too far away for me.

Thanks,
Richard



