Message-ID: <4E9ECF3A.40908@domain.hid>
Date: Wed, 19 Oct 2011 15:23:06 +0200
From: hauptmech <hauptmech@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] ARM build instructions wrong?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

  One thing I found confusing about the arm section in README.INSTALL is 
that it uses the same $build_root for the kernel and xenomai. The first 
time through I followed the instructions and later ran into problems 
trying to rebuild some kernel modules. I'm guessing that the xenomai 
configure script trashed the kernel stuff since they are sharing a build 
directory?

I found that using a $build_root_kernel for the kernel and a separate 
$build_root_xenomai for xenomai avoided this.

Can someone confirm I'm not missing something and that this is indeed an 
issue and maybe update the docs for the next hapless newb?

-hauptmech

