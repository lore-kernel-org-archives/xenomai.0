From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 18 Jun 2012 10:08:19 -0400
Message-ID: <20120618140819.GA32727@csclub.uwaterloo.ca>
References: <CAKKWdtcnn+EYfEQ=j4by6YtBRWn4nsFRMaCK=uWvKA1ubZ=EeA@mail.gmail.com>
	<20120611141444.GU32727@csclub.uwaterloo.ca>
	<CAKKWdtdvPGDsz3fJz0b64bPELR9RH92B3a=nPCCPtga7ZVUwNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKKWdtdvPGDsz3fJz0b64bPELR9RH92B3a=nPCCPtga7ZVUwNg@mail.gmail.com>
Subject: Re: [Xenomai] the Linux kernel and operating system
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ali hagigat <hagigatali@gmail.com>
Cc: xenomai@xenomai.org

On Sun, Jun 17, 2012 at 05:25:08PM +0430, ali hagigat wrote:
> I think SMI needs some initialization from BIOS and then Linux kernel.
> The Linux kernel has some CONFIG_ variables to disable/enable SMI.
> In theory a motherboard can be built to generate SMI without the
> software help. But I think OEMs do not build such a board. So I think
> an x86 PC hard real time system is possible for today's PCs.
> 
> Please correct me if I am wrong.

The majority of systems I have seen do have SMI enabled at all times
and no way to turn it off.

IBM even released a kernel driver to allow linux users to disable SMI on
some xSeries servers, but they must also handle certain fan controllers
from linux in that case since the SMI BIOS code is no longer doing it.
For those doing real time, this is acceptable to have to do, certainly
much better than having the SMI BIOS code interrupting real time just
to check on the fans.

I do not believe linux has any way to turn it off.  It is rather system
specific.  All I see is CONFIG_GOOGLE_SMI which is specific to google's
machines.  Also CONFIG_IBM_RTL (IBM Premium Real Time Mode).

-- 
Len Sorensen

