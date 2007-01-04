Message-ID: <459CD96D.2000209@domain.hid>
Date: Thu, 04 Jan 2007 11:39:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel Oops with latest SVN Xenomai
References: <459CC97B.6030402@domain.hid>
	<7803102.1167838186182.JavaMail.ngmail@domain.hid>
	<23779652.1167906253258.JavaMail.ngmail@domain.hid>
In-Reply-To: <23779652.1167906253258.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

M. Koehrer wrote:
> Hi Gilles, 
> 
> enclosed is the .config file.
> 
> Regards

There seem to be nothing suspicious in your configuration. Maybe you
could try disabling CONFIG_X86_PM_TIMER. Also, the error you have seem
to happen in the filesystem code, so maybe you should try running fsck
on your filesystems.

-- 
                                                 Gilles Chanteperdrix

