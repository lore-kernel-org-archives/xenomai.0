Message-ID: <48343EA1.9000905@domain.hid>
Date: Wed, 21 May 2008 11:24:17 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------010502050607030105080805"
Subject: [Xenomai-help] How do you recommend installing ipipe patches?
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

This is a multi-part message in MIME format.
--------------010502050607030105080805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I have a question regarding the ipipe patches.  There appear to be three
places to get them:

1) Contained within the Xenomai tar
2) From the gna adeos downloads page
3) From the DENX ipipe git

I have been getting the patches from the Xenomai tar, but I ran into a
problem, because I needed to use a newer version of the kernel, to get
some other powerpc features.  The patch from the Xenomai tar was not new
enough to apply cleanly.

So, can I use the gna-ipipe patches with the Xenomai tar, or am I better
off extracting a patch from the DENX ipipe git?

Even if you recommend the gna-ipipe patches, I'd like to know what git
commands one would use to extract a patch file from the DENX ipipe git. 
I assume it is some variant of git-diff, but I am still learning git, so
a hint would be appreciated.

Also, I'm not clear on the best way to set up my local git tree.  Do I
clone from linux-2.6-denx.git
<http://git.denx.de/?p=linux-2.6-denx.git;a=summary> or ipipe-2.6.git
<http://git.denx.de/?p=ipipe-2.6.git;a=summary>?  Whichever I clone
from, do I create branches to track both of those remote git
repositories?  Once I apply the ipipe patch to my local git tree, do you
recommend committing that, perhaps on some other branch?

I guess this boils down to: what is the "best practice" for setting up a
local git given that I want Xenomai plus a very recent kernel.  I also
want to be able to apply updates for ipipe, Xenomai, and the kernel, and
I'm not clear on how that interacts with the ipipe patch model.  Do I
back out one ipipe patch to apply a newer one, or somehow create a diff
between two patches?  I'm so confused... :-)

    TIA for any guidance you can offer,
    Steve


--------------010502050607030105080805
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>I have a question regarding the ipipe patches.  There appear to be
three places to get them:<br>
<br>
1) Contained within the Xenomai tar<br>
2) From the gna adeos downloads page<br>
3) From the DENX ipipe git<br>
<br>
I have been getting the patches from the Xenomai tar, but I ran into a
problem, because I needed to use a newer version of the kernel, to get
some other powerpc features.  The patch from the Xenomai tar was not
new enough to apply cleanly.<br>
<br>
So, can I use the gna-ipipe patches with the Xenomai tar, or am I
better off extracting a patch from the DENX ipipe git?<br>
<br>
Even if you recommend </tt><tt>the gna-ipipe patches, I'd like to know
what git commands one would use to extract a patch file from the </tt><tt>DENX
ipipe git.  I assume it is some variant of git-diff, but I am still
learning git, so a hint would be appreciated.<br>
<br>
Also, I'm not clear on the best way to set up my local git tree.</tt><tt> 
Do I clone from <a
 href="http://git.denx.de/?p=linux-2.6-denx.git;a=summary" target="_top">linux-2.6-denx.git</a>
or <a href="http://git.denx.de/?p=ipipe-2.6.git;a=summary"
 target="_top">ipipe-2.6.git</a>?  Whichever I clone from, do I create
branches to track both of those remote git repositories?</tt><tt>  Once
I apply the ipipe patch to my local git tree, do you recommend
committing that, perhaps on some other branch?<br>
<br>
I guess this boils down to: what is the "best practice" for setting up
a local git given that I want Xenomai plus a very recent kernel.  I
also want to be able to apply updates for ipipe, Xenomai, and the
kernel, and I'm not clear on how that interacts with the ipipe patch
model.  Do I back out one ipipe patch to apply a newer one, or somehow
create a diff between two patches?  I'm so confused... <span
 class="moz-smiley-s1"><span> :-) </span></span><br>
<br>
    TIA for any guidance you can offer,<br>
    Steve<br>
<br>
</tt>
</body>
</html>

--------------010502050607030105080805--

