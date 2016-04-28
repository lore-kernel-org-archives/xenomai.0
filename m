Date: Thu, 28 Apr 2016 12:56:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160428105612.GB10481@hermes.click-hack.org>
References: <CABUerAFN6zT_DPbF7uEU=2jLj5iE1K6RaTEJHYsbovGhuxW_WA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABUerAFN6zT_DPbF7uEU=2jLj5iE1K6RaTEJHYsbovGhuxW_WA@mail.gmail.com>
Subject: Re: [Xenomai] kernal2.6.38.8
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ravi kanth <xenomai412@gmail.com>
Cc: xenomai@xenomai.org

On Thu, Apr 28, 2016 at 12:03:41PM +0530, ravi kanth wrote:
> when I am patching  linux kernal 2.6.38.8 with xenomai 2.6-2.2.6.3

Linux 2.6.38 is outdated.
Xenomai 2.6.3 is doubly outdated (the latest release in the 2.6
branch is Xenomai 2.6.4, and the latest stable release of Xenomai is
3.0.2, a completely new branch which you should consider using if
starting a project now).

> (...)
> prepare-kernel.sh: Unable to patch kernel 2.6.38.8 with
> ipipe-core-3.8.13-x86-4.patch

the ipipe-core-3.8.13 patch is for kernel version 3.8.13 and so has
no chances to apply to Linux 2.6.38, and is also outdated, Xenomai
3.0 dropped support for anything older than Linux 3.10.

Regards.

-- 
					    Gilles.
https://click-hack.org

