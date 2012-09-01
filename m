Message-ID: <504210A3.2080402@xenomai.org>
Date: Sat, 01 Sep 2012 15:41:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20120901153825.3f232f97@dell>
In-Reply-To: <20120901153825.3f232f97@dell>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] imx1 and imx27 boot problem with __ipipe_tsc_get()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "gwenhael.goavec" <gwenj@trabucayre.com>
Cc: xenomai@xenomai.org

On 09/01/2012 03:38 PM, gwenhael.goavec wrote:

> Hi,
> 
> I have 2 boards, the first is based on imx1 and the second on imx27.
> With this 2 boards, I'm unable to boot a 2.6.38.8 kernel.
> For the imx1 with 3.2.21 the result is the same.
> 
> I have enabled early_printk. On every boards the boot stop with a kernel panic.
> The message start with : "Unable to handle kernel paging request at virtual
> address 10003010" on imx27.
> 
> This is due to the call of __ipipe_tsc_get() in __ipipe_tsc_update()
> 
> To verify my toolchain I have tested 2.6.38.8 with at91 successfully.
> 
> If someone has a idea?


Not enough information, to understand what happens we need the kernel
oops (at least the register values).

-- 
                                                                Gilles.

