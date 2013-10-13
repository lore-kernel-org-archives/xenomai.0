Message-ID: <525A7127.3050101@xenomai.org>
Date: Sun, 13 Oct 2013 12:08:39 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5257A979.7080208@siemens.com>
In-Reply-To: <5257A979.7080208@siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PULL] forge: Cleanup COPYING files
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 10/11/2013 09:32 AM, Jan Kiszka wrote:
> Hi Philippe,
>
> The following changes since commit 926e0441446aae116bf5b0701753e4b87a5386a2:
>
>    doc: update installation guidelines (2013-10-04 15:46:23 +0200)
>
> are available in the git repository at:
>
>    git://git.xenomai.org/xenomai-jki.git for-forge
>
> for you to fetch changes up to f1559e40a39b1a54e0348732402a68eb0dfef0a4:
>
>    Rename include and lib copying files (2013-10-10 15:15:56 +0200)
>
> If you do not like COPYING.* renaming, just skip the second patch. The
> first on is important as we currently have code that is formally under
> no COPYING file.
>

Thanks for the heads up. However, I disagree with both patches. GPL has 
never been our default license. The common rule for Xenomai is to state 
the licensing terms on a per-file basis, explicitly. When present, the 
COPYING files basically emphasize the fact that all files in the 
relevant directory and below share that license. In other words, not 
having COPYING file in some hierarchy does not mean that we have no 
license, it's most often right there into each individual files.

The files which do not state any licensing terms in a way or another in 
-forge are as follows:

./lib/boilerplate/tlsf/target.h
./utils/can/rtcansend.c
./utils/can/rtcanrecv.c
./utils/ps/rtps.c
./utils/analogy/wf_facilities.h
./utils/analogy/wf_facilities.c
./testsuite/*

The first one (target.h) is merely a build configuration file. 
$top_srcdir/testsuite/* should not default to GPL, although it's 
perfectly fine that contributors do state GPL licensing explicitly in 
such code if they wish to. The few others implementing small utilities 
are indeed lacking license information.

AFAICS, all other files state their license explicitly, or depend on a 
COPYING file present in the file hierarchy they belong to. If the file 
belongs to the kernel support, the additional requirement to have it 
GPLv2 compatible is even implicit per the linux kernel licensing terms, 
all of our kernel code abide by strictly.

At any rate, contributors may want to clarify licensing terms for the 
code they authored if need be.

-- 
Philippe.

