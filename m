MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18484.32692.342560.863708@domain.hid>
Date: Wed, 21 May 2008 22:01:56 +0200
In-Reply-To: <48343EA1.9000905@domain.hid>
References: <48343EA1.9000905@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] How do you recommend installing ipipe patches?
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
 > I have a question regarding the ipipe patches.  There appear to be three
 > places to get them:
 > 
 > 1) Contained within the Xenomai tar
 > 2) From the gna adeos downloads page
 > 3) From the DENX ipipe git
 > 
 > I have been getting the patches from the Xenomai tar, but I ran into a
 > problem, because I needed to use a newer version of the kernel, to get
 > some other powerpc features.  The patch from the Xenomai tar was not new
 > enough to apply cleanly.

You can try to pick a newer Xenomai tar, if you stay in the same major
version (for instance, you had a 2.3.1 tar and choose to go for 2.3.5),
the newer Xenomai version should not break your application.

 > 
 > So, can I use the gna-ipipe patches with the Xenomai tar, or am I better
 > off extracting a patch from the DENX ipipe git?

In general, you can use a newer gna-ipipe patch (there are some
exceptions of course, but usually, this does not even compile). I see
the ipipe git mainly as a tool for architectures patch maintainers, but
of course you can use it, this can be used as a way to switch easily
between I-pipe revisions.

 > 
 > Even if you recommend the gna-ipipe patches, I'd like to know what git
 > commands one would use to extract a patch file from the DENX ipipe git. 
 > I assume it is some variant of git-diff, but I am still learning git, so
 > a hint would be appreciated.

Well, you do not have to extract a patch from the git repository, the
content of the repository is an already patched kernel.

 > 
 > Also, I'm not clear on the best way to set up my local git tree.  Do I
 > clone from linux-2.6-denx.git
 > <http://git.denx.de/?p=linux-2.6-denx.git;a=summary> or ipipe-2.6.git
 > <http://git.denx.de/?p=ipipe-2.6.git;a=summary>?  Whichever I clone
 > from, do I create branches to track both of those remote git
 > repositories?  Once I apply the ipipe patch to my local git tree, do you
 > recommend committing that, perhaps on some other branch?

You have to clone ipipe-2.6.git. And yes, you have to create a local
branch which tracks a remote branch or a tag (every I-pipe release is
tagged).

 > 
 > I guess this boils down to: what is the "best practice" for setting up a
 > local git given that I want Xenomai plus a very recent kernel.  I also
 > want to be able to apply updates for ipipe, Xenomai, and the kernel, and
 > I'm not clear on how that interacts with the ipipe patch model.  Do I
 > back out one ipipe patch to apply a newer one, or somehow create a diff
 > between two patches?  I'm so confused... :-)
 > 
 >     TIA for any guidance you can offer,
 >     Steve


-- 


					    Gilles.

