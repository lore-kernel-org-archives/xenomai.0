References: <CAHoW4hE=sh9dL_+LpCmO8qKhzfnMYQbu9Yx-2jf+6Cu4gDFUrg@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <570E8F94.1000600@xenomai.org>
Date: Wed, 13 Apr 2016 20:27:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAHoW4hE=sh9dL_+LpCmO8qKhzfnMYQbu9Yx-2jf+6Cu4gDFUrg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i-pipe patched 4.1.18 fails to boot on
 BeagleBoard-x15 (AM5728 processor)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Kiorpes <ckiorpes@gmail.com>, xenomai@xenomai.org

On 04/13/2016 08:04 PM, Charles Kiorpes wrote:
> Hello,
> 
> I have been trying to bring up a Rev A2 BeagleBoard-x15 with i-pipe, in
> order to test Xenomai co-kernel functionality on this board.
> 
> I have verified that the kernel configuration settings that I'm using
> create a bootable mainline 4.1.18 kernel.
> 
> Once I patch the 4.1.18 kernel with ipipe-core-4.1.18-arm-4.patch, and make
> the same configuration changes, I am unable to boot the resulting kernel.
> 
> I have attached my kernel config and the kernel output from a failed boot.
> 
> The first major error (aside from some lock debug printouts) occurs at

Those printouts are due to CONFIG_PROVE_LOCKING. The virtual interrupt
state the pipeline introduces confuses that machinery, so you may want
to disable this option until the pipeline is fixed regarding that
particular issue.

> 2.141340, when the kernel attempts to dereference a NULL pointer.
> It appears that the problem is related to the PALMAS driver, but I am not
> well-versed in kernel development and don't know how to proceed.
> 
> What steps can I take to better debug and eventually correct the problem?
> 

A NULL handler is called, weird. You can use addr2line on the vmlinux
image of your kernel to match the faulty call site at 0xc00d00cc. Or
dump that image as an annotated assembly file
(arm-linux-gnueabihf-objdump -dl ...), looking for the call site in the
output.

You will need CONFIG_DEBUG_INFO enabled.

-- 
Philippe.

