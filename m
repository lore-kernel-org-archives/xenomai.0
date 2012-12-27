Message-ID: <50DCB69A.9000004@nta-inc.net>
Date: Thu, 27 Dec 2012 14:59:06 -0600
From: Jeff Webb <jeff.webb@nta-inc.net>
MIME-Version: 1.0
References: <50CD8E87.2070906@xenomai.org>	<201212170945.47992.leo@alaxarxa.net>
	<50CEFB24.9000306@antcom.de>	<201212171453.44318.leo@alaxarxa.net>
	<50DC9C51.9090300@antcom.de> <50DCA2B1.6070805@xenomai.org>
In-Reply-To: <50DCA2B1.6070805@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Another dpkg build issue for Xenomai 2.6.2
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When building dpkgs on Ubuntu 12.04, this line in the debian/rules file gives me trouble because there are no longer any adeos-ipipe-*.patch files for the x86 architecture:

cp adeos-ipipe-*.patch $(CURDIR)/debian/linux-patch-xenomai/usr/src/kernel-patches/diffs/xenomai

As a workaround, I did this before building:

touch ./ksrc/arch/x86/patches/adeos-ipipe-2.6.0-x86-dummy.patch

-Jeff


