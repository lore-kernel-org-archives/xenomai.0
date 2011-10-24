Message-ID: <4EA5538E.8000704@domain.hid>
Date: Mon, 24 Oct 2011 14:01:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4EA53A99.1050305@domain.hid>
In-Reply-To: <4EA53A99.1050305@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] some problems with interrupts
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 10/24/2011 12:14 PM, Roberto Bielli wrote:
> Hi,
> 
> i installed the patch 'adeos-ipipe-2.6.31-arm-1.16-02.patch' on a kernel 
> 2.6.31 for imx257 processor.
> I have a xenomai complex application that read touchscreen events with 
> tslib when pressed.
> In the kernel log i try these lines: ( the read job is made in a 
> not-realtime thread )
> 
> ------------[ cut here ]------------
> WARNING: at drivers/input/touchscreen/mxc_tsc.c:599 
> mxc_tsc_interrupt+0x19c/0x30c [mxc_tsc]()
> (...)
> 
> Do you know the meaning in xenomai of this error (so i can modify 
> something to resolve the problem )?

This looks more like a warning than an error. At first glance, it has
nothing to do with xenomai. Besides, you seem not to be using a mainline
version of the kernel, because in the versions I have, there is no
drivers/input/touchscreen/mxc_tsc.c, so, it is hard for me to debug this
issue.

What has file drivers/input/touchscreen/mxc_tsc.c on line 599?

You may want to try a more recent version, as linux 2.6.31 starts being
seriously outdated.

-- 
					    Gilles.

