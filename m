Message-ID: <50EB4DB3.4040207@xenomai.org>
Date: Mon, 07 Jan 2013 23:35:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Debian squeeze packages preview for the amd64
	architectures
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

For the Debian squeeze users, the xenomai packages are available on
xenomai server, for the amd64 architecture. To use them, add:

deb http://www.xenomai.org/debian squeeze main

to /etc/apt/sources.list, then:
apt-get update
apt-get install xenomai-keyring
apt-get install linux-image-3.5.7-xenomai-2.6.2 xenomai-runtime

You should then be able to reboot on the new kernel, and launch:
xeno latency

These packages are a preview version, not really 2.6.2, but not yet the
next release.

Regards.

-- 
                                                                Gilles.

