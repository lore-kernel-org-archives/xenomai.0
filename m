Message-ID: <4FE5A583.2010401@xenomai.org>
Date: Sat, 23 Jun 2012 13:16:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACKGRaU=LSM8HYOQAeZvLzGuMPsn+juQKrEHCZbfz=hZOKP_sg@mail.gmail.com>
In-Reply-To: <CACKGRaU=LSM8HYOQAeZvLzGuMPsn+juQKrEHCZbfz=hZOKP_sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] How to fix error "incompatible ABI revision levels on
 Ubuntu Linux 3.6.38 on ARM?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: aungkyas@gmail.com
Cc: xenomai@xenomai.org

On 06/23/2012 12:31 PM, AKS wrote:
> Hi
> 
> I am trying to use Xenomai after patching 2.6.rc5 onto Linux 2.6.38 kernel

This version is outdated, you should use xenomai 2.6.0

> based on ARM based TI OMAP processor and Ubuntu 11.10 OS. After the
> Xenomai patched kernel is booted, I tried to install Xenomai using the apt
> utility by sudo apt-get install xenomai-runtime. However, when I tried to
> run example applications such as /usr/lib/xenomai/clocktest and latency,
> I got the following error
> "Xenomai: incompatible ABI revision level
> (user space requires '3' and kernel provides '4')

It means you are mixing user-space support and kernel-space support of
different versions, for instance mixing kernel-space support of xenomai
2.6.x, with user-space support of xenomai version 2.5.y

You should not do that, it is not supported, xenomai only support
user-space of the same branch as kernel-space, so, for instance,
kernel-space support version 2.6.x with user-space support version 2.6.y.

-- 
                                                                Gilles.

