Date: Wed, 28 Apr 2021 20:05:09 +0800
From: Jamie Huang <jamienstar@163.com>
Subject: Re: Can printk in the root domain cause the system to hung ?
Message-ID: <20210428200509.3a89d2b5@jamie-ThinkPad>
In-Reply-To: <fa5a2efa-32ff-1386-630b-05099c49a7ff@siemens.com>
References: <20210425183312.12d2e2a5@jamie-ThinkPad>
 <fa5a2efa-32ff-1386-630b-05099c49a7ff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org, rpm@xenomai.org

On Tue, 27 Apr 2021 18:36:02 +0200
Jan Kiszka <jan.kiszka@siemens.com> wrote:

Thank you for reply!

> On 25.04.21 12:33, Jamie Huang via Xenomai wrote:
> > Hi, all:
> > 	We are now porting ipipe on mips architecture. There is a
> > problem, after local_irq_enable() is called in start_kernel(),
> > system looks hung. We found that this may be related to printk in
> > root domain, if we use early_printk instead of printk, the system
> > looks normal and can continue the kernel boot process. Can someone
> > tell me the possible reason, thanks!  
> 
> Is your code published already?

No, but I think we will publish it when it is basically available.
> 
> Also note that the I-pipe architecture is becoming legacy. We are
> moving all archs to dovetail over 5.10 now.
> 
> Jan
> 

Our kernel version is 4.19, so we choose I-pipe now. We will consider
dovetail if use a higher version of kernel.


