From: adam - Li Yi <yi.li@domain.hid>
In-Reply-To: <1196223312.6012.5.camel@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2AE3BBE9@domain.hid>
	<18252.36930.625870.462352@domain.hid>
	<1196223312.6012.5.camel@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Nov 2007 18:17:30 +0800
Message-Id: <1196245050.6012.30.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] question about
	patch:	adeos-ipipe-2.6.23-bf5xx-1.7-00.patch
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

Hi Philippe,

Now I understand that this patch is against vanilla linux-2.6.23 git
tree. But since the blackfin uclinux linux kernel will be synced to
vanilla tree when the we do the next release, the kernel in blackfin
uclinux svn trunk is still 2.6.22.

Do you think it make sense to make an adeos patch based on blackfin
uclinux linux-kernel SVN trunk, to allow people working on blackfin
uclinux SVN to use adeos/xenomai? (I tried to merge, but it is not
smooth.)

Thanks,
-Yi


On Wed, 2007-11-28 at 12:15 +0800, adam - Li Yi wrote:
> Hi Philippe,
> 
> I tried to apply patch "adeos-ipipe-2.6.23-bf5xx-1.7-00.patch" to
> Blackfin uClinux kernel SVN trunk 2007-Nov-27 but failed. The problem is
> that the blackfin uclinux kernel is still 2.6.22. I am wondering at
> which svn revision the patch is made?
> 
> Thanks!
> 
> -Yi 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

