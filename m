Date: Mon, 13 Jul 2015 13:36:13 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150713113613.GB1586@hermes>
References: <000201d0bd45$f08167b0$d1843710$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201d0bd45$f08167b0$d1843710$@gmail.com>
Subject: Re: [Xenomai] Xenomai 2.6.4 on Linux w/ PREEMPT_RT
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

On Mon, Jul 13, 2015 at 10:28:46AM +0200, Giorgio Buffa wrote:
> Hello list!
> Have you ever set up a dual-kernel system using Xenomai 2 and a Linux
> kernel patched with PREEMPT_RT?
> 
> I was trying with Linux 3.14.39 on x86_64 using "patch-3.14.39-rt37.patch"
> and "ipipe-core-3.14.39-x86-9.patch". First I've applied the
> PREEMPT_RT

The ipipe-core-3.14.39-x86-9.patch is made for an unpatched Linux
kernel. Combo patches are specific patches, I am not sure we even
have one in the download area.

-- 
					    Gilles.
https://click-hack.org

