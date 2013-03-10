Message-ID: <513CDF10.8000305@xenomai.org>
Date: Sun, 10 Mar 2013 20:29:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] recursive dependency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>


Hi,

I get this warning when compiling Xenomai based on Linux 3.8 for ARM:

kernel/ipipe/Kconfig:1:error: recursive dependency detected!
kernel/ipipe/Kconfig:1: symbol IPIPE is selected by XENOMAI
init/Kconfig:1763:      symbol XENOMAI depends on IPIPE_CORE
kernel/ipipe/Kconfig:16:        symbol IPIPE_CORE depends on IPIPE

Any idea how to avoid this?


-- 
                                                                Gilles.

