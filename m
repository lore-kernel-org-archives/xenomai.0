Message-ID: <529DCF2F.1070702@xenomai.org>
Date: Tue, 03 Dec 2013 13:31:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
In-Reply-To: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kurijn Buys <kurijn.buys@open.ac.uk>
Cc: Xenomai@xenomai.org

On 12/03/2013 12:38 PM, Kurijn Buys wrote:
> Hardware: Pentium IV (lspci: 3,2GHz, i686, 32,64bit, 2 cpu's), 2Gb
> RAM Software: Ubuntu 10.04, kernel&patch 2.6.38.8, Xenomai 2.6.3

2.6.38 is rather old, could you try a more recent kernel like 3.8.13 to
see if you get the same problem?

> -I've set the SMI workaround by adding "xeno_hal.smi=-1" on the
> kernel command line
> (http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/index.html#SMI),
> but maybe it makes a difference when it is set in the kernel config,
> as proposed here
> (http://www.xenomai.org/index.php/Configuring_x86_kernels), by
> setting the CONFIG_XENO_HW_SMI_WORKAROUND variable. However, I didn't
> find this variable in my kernel configuration...

Yes, the SMI workaround has changed from a compile-time option to a
run-time option, in order to avoid having to recompile the kernel to
change the option.

-- 
                                                                Gilles.

