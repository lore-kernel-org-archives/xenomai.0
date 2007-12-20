Message-ID: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>
Date: Thu, 20 Dec 2007 15:43:14 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-core] Auto closing of file descriptors and fork.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I have a problem with auto closing of file descriptors and fork. I
have an application (a modified pppd, to name it), which in a certain
mode (pppd "updetach" mode) opens some real-time file descriptors,
forks and exit the parent, continuing to use the file descriptors in
the child. The problem is that when exiting the parent, file
descriptors are automatically destroyed and therefore can not be used
in the child.

Any ideas for a fix ?

-- 
                                               Gilles Chanteperdrix

