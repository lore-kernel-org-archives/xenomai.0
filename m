Message-ID: <48AC50F4.8090109@domain.hid>
Date: Wed, 20 Aug 2008 19:14:28 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48AB34DC.4080907@domain.hid>
In-Reply-To: <48AB34DC.4080907@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] SVN versus git
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

Steven A. Falco wrote:
> I just downloaded the current SVN Xenomai trunk, and in
> ksrc/arch/powerpc/patches/README, it says that patch
> 2.6.26-DENX-2.2-04/powerpc is based on git commit
> 5abf5fb22279f8b409203a160365edbd51b16406
> 
> However, if I try to find that commit in the ipipe-2.6
> tree (from the DENX site), the commit is not found.
> 

git://www.denx.de/git/linux-2.6-denx.git

> What is the relationship between the SVN and git
> repositories?

The I-pipe code is maintained in the ipipe-2.6 GIT tree, patches are made from
that tree, and published there http://download.gna.org/adeos/patches/. Some of
those patches (well, most of them actually) are picked by the Xenomai project
and committed to the SVN repo.

  Should I be able to find that commit,
> or is it in a private tree?
> 

The reference tree is DENX's one.

> One other comment: I don't even see a branch called
> ipipe-2.6.26-powerpc in the git tree, but I do see
> arm, x86, and noarch there.  Am I looking at the wrong
> tree?

No, I'm just late pushing this branch out of my local tree. I need to rebase it
on DENX-v2.6.26-stable first.

> 
> 	Steve
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 
Philippe.

