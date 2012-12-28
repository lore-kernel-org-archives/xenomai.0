Message-ID: <50DCEAC6.9020900@xenomai.org>
Date: Fri, 28 Dec 2012 01:41:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50dcddf63f5d48.40617259@wp.pl>
In-Reply-To: <50dcddf63f5d48.40617259@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 2.6.2 + Kernel 3.5.3 + AMD Phenom II X6 1055
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mariusz Janiak <mariuszjaniak@wp.pl>
Cc: Xenomai <xenomai@xenomai.org>

On 12/28/2012 12:47 AM, Mariusz Janiak wrote:

> Hi
> 
> As soon as you publish new Xenomai 2.6.2 release, I have tried to launch it on my desktop, and unfortunately I went into trouble. My testbed:
> 
>  - Xenomai 2.6.2,
> 
>  - Kernel 3.5.3 (I haven't testes earlier versions),
> 
>  - AMD Phenom II X6 1055 + Gigabyte GA-890GPA-UD3H
> 
>  - Ubuntu 12.10.
> 
> The problem is following (from dmesg):


The problem real problem is here (from your dmesg):

> System has AMD C1E enabled
> Switch to broadcast mode on CPU1
> Switch to broadcast mode on CPU2
> Switch to broadcast mode on CPU3
> Switch to broadcast mode on CPU4


> I went through installation manual, troubleshooting guide and forum

> archives, maybe I have missed something. What is more I have tested this

> kernel on my laptop HP pavilion dm1 with AMD E-350 and it work
> without problems.

We have a message saying:
I-pipe: cannot use LAPIC as a tick device
I-pipe: disable C1E power state in your BIOS

For some reason, however, it does not get printed in your case. I agree
that we should document this in the TROUBLESHOOTING guide.

-- 
                                                                Gilles.

