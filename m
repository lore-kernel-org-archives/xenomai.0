Date: Wed, 18 Mar 2015 08:21:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150318072126.GH16113@hermes.click-hack.org>
References: <87992833e1e7483097a81f9a55c800a6@MUC-S-EX13B.advaoptical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87992833e1e7483097a81f9a55c800a6@MUC-S-EX13B.advaoptical.com>
Subject: Re: [Xenomai] version connection between xenomai, ipipe and kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Sagi Maimon <SMaimon@advaoptical.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Mar 18, 2015 at 06:08:30AM +0000, Sagi Maimon wrote:
> Hi, I have read all xenomai documents, but I still can't
> understand the version connection between xenomai, ipipe and
> kernel.
> 
> 1) Does the latest xenomai version (2.6.4), supports all the
> kernel vanilla versions?

It supports all kernel versions up to the latest ones for which it
contains a patch. For instance xenomai 2.6.4 contains I-pipe patches
for version 3.14, so it supports all kernel versions up to 3.14.

> 
> 2) When I choose a xenomai version, How can I find the kernel
> versions it supports?

Look at the latest I-pipe patch it contains.

> 
> 3) If there is no Ipipe version that fits my Linux kernel version
> (I am using Linux version 3.12.21) , what is the ipipe version I
> can use? Thanks, Sagi

None. You would have to port the I-pipe patch to that version.

-- 
					    Gilles.

