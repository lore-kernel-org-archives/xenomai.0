MIME-Version: 1.0
Date: Sat, 23 Jun 2012 03:31:13 -0700
Message-ID: <CACKGRaU=LSM8HYOQAeZvLzGuMPsn+juQKrEHCZbfz=hZOKP_sg@mail.gmail.com>
From: AKS <aungkyas@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] How to fix error "incompatible ABI revision levels on
 Ubuntu Linux 3.6.38 on ARM?
Reply-To: aungkyas@gmail.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

I am trying to use Xenomai after patching 2.6.rc5 onto Linux 2.6.38 kernel
based on ARM based TI OMAP processor and Ubuntu 11.10 OS. After the
Xenomai patched kernel is booted, I tried to install Xenomai using the apt
utility by sudo apt-get install xenomai-runtime. However, when I tried to
run example applications such as /usr/lib/xenomai/clocktest and latency,
I got the following error
"Xenomai: incompatible ABI revision level
(user space requires '3' and kernel provides '4')

I have cross compiled once but I still want to learn easier ways to fix it.
I will be glad if you can share insights and pointers. Thanks!

Rgds

Aung

