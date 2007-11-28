Message-ID: <474D3D0D.3090403@domain.hid>
Date: Wed, 28 Nov 2007 11:03:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE3BBE9@domain.hid>	<18252.36930.625870.462352@domain.hid>
	<1196223312.6012.5.camel@domain.hid>
In-Reply-To: <1196223312.6012.5.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] question about
	patch:	adeos-ipipe-2.6.23-bf5xx-1.7-00.patch
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
To: adam - Li Yi <yi.li@domain.hid>
Cc: xenomai@xenomai.org

adam - Li Yi wrote:
> Hi Philippe,
> 
> I tried to apply patch "adeos-ipipe-2.6.23-bf5xx-1.7-00.patch" to
> Blackfin uClinux kernel SVN trunk 2007-Nov-27 but failed. The problem is
> that the blackfin uclinux kernel is still 2.6.22. I am wondering at
> which svn revision the patch is made?

This patch is against v2.6.23 vanilla. GIT commit
bbf25010f1a6b761914430f5fca081ec8c7accd1. I don't track the Blackfin SVN
repo anymore since 2.6.23, but rather the mainline tree.

-- 
Philippe.

