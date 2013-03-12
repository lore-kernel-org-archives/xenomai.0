Message-ID: <513F879F.6000500@antcom.de>
Date: Tue, 12 Mar 2013 20:53:03 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
References: <513F5C23.2090603@yahoo.com> <513F7196.2070305@antcom.de>
	<513F849C.1050505@yahoo.com>
In-Reply-To: <513F849C.1050505@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] problems while patching Debian kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Tom Z <tomz30@yahoo.com>
Cc: xenomai@xenomai.org

On 03/12/2013 08:40 PM, Tom Z wrote:
> I don't quite understand "...Debian stable currently contains Xenomai
> 2.5.4 (with patches)...":
> It seems the Xenomai source code & binaries are not automatically
> included after I installed Debian 6.0.7. Before I switched to Debian, to
> install Xenomai on my another Ubuntu laptop, what I do is:
> 1. Get a Linux kernel tarball from kernel.org and a Xenomai tarball from
> Xenomai.org
> 2. Patch the kernel and make menuconfig
> 3. compile & build the patched Linux kernel, and generate a kernel image
> 4. make & make install Xenomai binaries
> So, if "Debian stable currently contains Xenomai 2.5.4", which of the
> above steps can be skipped?

1. and 4. can be skipped since Debian includes Xenomai's binaries and
the kernel patch. 2. and 3. still need to be done, as documented in the
README you already found.

Roland

