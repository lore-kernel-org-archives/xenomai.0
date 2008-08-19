Message-ID: <48AB34DC.4080907@domain.hid>
Date: Tue, 19 Aug 2008 17:02:20 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] SVN versus git
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I just downloaded the current SVN Xenomai trunk, and in
ksrc/arch/powerpc/patches/README, it says that patch
2.6.26-DENX-2.2-04/powerpc is based on git commit
5abf5fb22279f8b409203a160365edbd51b16406

However, if I try to find that commit in the ipipe-2.6
tree (from the DENX site), the commit is not found.

What is the relationship between the SVN and git
repositories?  Should I be able to find that commit,
or is it in a private tree?

One other comment: I don't even see a branch called
ipipe-2.6.26-powerpc in the git tree, but I do see
arm, x86, and noarch there.  Am I looking at the wrong
tree?

	Steve

