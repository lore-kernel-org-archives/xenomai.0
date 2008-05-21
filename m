Message-ID: <48349225.10609@domain.hid>
Date: Wed, 21 May 2008 17:20:37 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <48343EA1.9000905@domain.hid>
	<18484.32692.342560.863708@domain.hid>
In-Reply-To: <18484.32692.342560.863708@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Steven A. Falco wrote:
>  > I have a question regarding the ipipe patches.  There appear to be three
>  > places to get them:
>  > 
>  > 1) Contained within the Xenomai tar
>  > 2) From the gna adeos downloads page
>  > 3) From the DENX ipipe git
>  > 
>  > I have been getting the patches from the Xenomai tar, but I ran into a
>  > problem, because I needed to use a newer version of the kernel, to get
>  > some other powerpc features.  The patch from the Xenomai tar was not new
>  > enough to apply cleanly.
>
> You can try to pick a newer Xenomai tar, if you stay in the same major
> version (for instance, you had a 2.3.1 tar and choose to go for 2.3.5),
> the newer Xenomai version should not break your application.
>   

Agreed - that is what I tried first.  The problem was that I was already
using the newest Xenomai (stable) tar, but the patch didn't apply
cleanly against the bleeding-edge kernel I was trying to run.  That is
why I started looking for other ipipe patches.
>  > 
>  > So, can I use the gna-ipipe patches with the Xenomai tar, or am I better
>  > off extracting a patch from the DENX ipipe git?
>
> In general, you can use a newer gna-ipipe patch (there are some
> exceptions of course, but usually, this does not even compile).

This sounds like the best option.  Thank you.
> I see
> the ipipe git mainly as a tool for architectures patch maintainers, but
> of course you can use it, this can be used as a way to switch easily
> between I-pipe revisions.
>
>  > 
>  > Even if you recommend the gna-ipipe patches, I'd like to know what git
>  > commands one would use to extract a patch file from the DENX ipipe git. 
>  > I assume it is some variant of git-diff, but I am still learning git, so
>  > a hint would be appreciated.
>
> Well, you do not have to extract a patch from the git repository, the
> content of the repository is an already patched kernel.
>   

I understand.  However, I asked for the hint for two reasons.  1) so I
can learn more about how people really use git, and 2) so that I could
try extracting a very current patch if I need something even newer than
the gna-ipipe patch.  If there is a one-liner example you can give, for
how someone creates the gna-ipipe patch from the ipipe-git, I would
appreciate it.
>  > 
>  > Also, I'm not clear on the best way to set up my local git tree.  Do I
>  > clone from linux-2.6-denx.git
>  > <http://git.denx.de/?p=linux-2.6-denx.git;a=summary> or ipipe-2.6.git
>  > <http://git.denx.de/?p=ipipe-2.6.git;a=summary>?  Whichever I clone
>  > from, do I create branches to track both of those remote git
>  > repositories?  Once I apply the ipipe patch to my local git tree, do you
>  > recommend committing that, perhaps on some other branch?
>
> You have to clone ipipe-2.6.git. And yes, you have to create a local
> branch which tracks a remote branch or a tag (every I-pipe release is
> tagged).
>   

I'd like to restate the question.  In using Xenomai, is it useful to
have multiple remotes in my local git?  I.e., should I just clone
linux-2.6-denx.git or should I additionally track ipipe-2.6.git (using
git-remote)?  I'm groping for how people really deal with pulling
changes from multiple places - in my case this would be from Josh
Boyer's PPC4xx tree and from Xenomai.

Thanks for taking the time to educate me.  I appreciate it!

    Steve


