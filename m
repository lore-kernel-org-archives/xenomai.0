Date: Tue, 30 Jun 2015 11:56:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150630095614.GD2038@hermes.click-hack.org>
References: <000a01d0b270$6c0e6b70$442b4250$@gmail.com>
 <20150629202243.GE10993@hermes.click-hack.org>
 <00c401d0b30b$6bc243d0$4346cb70$@gmail.com>
 <20150630091018.GC2038@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150630091018.GC2038@hermes.click-hack.org>
Subject: Re: [Xenomai] R: Device drivers and networking stack (RTnet) on
 Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giorgio Buffa <giorgiobuffa.work@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Jun 30, 2015 at 11:10:18AM +0200, Gilles Chanteperdrix wrote:
> 3- upon high packet rate, the Linux kernel moves handling of the
> NIC driver interrupts to a kernel thread without a real-time
> scheduling policy, so even with PREEMPT_RT it can cause the handling
> of the NIC driver to not be real-time.

Please disregard the comment about PREEMPT_RT. I am sure the
PREEMPT_RT developers have thought about that.

-- 
					    Gilles.
https://click-hack.org

