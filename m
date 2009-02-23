Message-ID: <49A2F11E.2040204@domain.hid>
Date: Mon, 23 Feb 2009 19:55:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <a0ef0a9d0902230831t1f1cb440tc4bc7fdeab134fc8@domain.hid>
In-Reply-To: <a0ef0a9d0902230831t1f1cb440tc4bc7fdeab134fc8@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Adeos patch for arm ??
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ghanem Lafi <lafi.ghanem@domain.hid>
Cc: xenomai@xenomai.org

Ghanem Lafi wrote:
> Hello,
> 
>    To install  xenomai, I should  have a patch adeos for  arm architecture
> related to kernel Linux 2.6.11.8
> 
>    The problem is that the oldest  version of arm adeos  patch  is related
> to  linux2.6.14... and my work
>  must work with linux2.6.11.8 !!
> 
>    I would appreciate comments and suggestions. If this is already
> discussed somewhere else then I would be grateful if you could point me
> in the right direction.
> 
>    Thanks in advance for your help

If you are starting a new work, you have no reason of using an old
kernel version, so pick the latest kernel version, and focus on getting
it to run on your board. There has been a bunch of bug fixes and
improvements since 2.6.11 or 2.6.14, both on the Linux kernel side and
on the Xenomai side.

-- 
                                                 Gilles.

