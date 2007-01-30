Message-ID: <cbe23c50701300019n18723a22pdca64636412a1a09@domain.hid>
Date: Tue, 30 Jan 2007 09:19:10 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
Subject: Re: [Xenomai-help] installing-what about adeos
In-Reply-To: <bc4264770701300000p1efec34fme7d1db2d4a0441aa@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770701300000p1efec34fme7d1db2d4a0441aa@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

2007/1/30, roland Tollenaar <rolandtollenaar@domain.hid>:
> Hi,
>
> I am completely new to xenomai so please forgive stupid questions.
>
> I am trying to follow the installation instructions README.INSTALL but
> in the the first step (
> running kernel-prepare.sh) I am confused by the adeos argument. I do
> not have adeos installed or  patched my kernel with it.

The purpose of kernel-prepare.sh scripts is to patche (i.e. modify)
the linux kernel source you find on www.kernel.org which are often
called "vanilla" kernel.

>
> I have seen adeos mentioned a lot in all the documentation, but what
> is it, where must I find it and  how must I install it?

ADEOS consist in a set of patches to the "vanilla" linux kernel
which are necessary for Xenomai.

Xenomai rely on a modified (i.e. patched) linux kernel
the patch is ADEOS.

I think you should prepare yourself to both
1) Compile a Linux Kernel
2) Understand a little of ADEOS purpose:
http://home.gna.org/adeos/index.en.html
http://snail.fsffrance.org/www.xenomai.org/documentation/branches/v2.0.x/pdf/Life-with-Adeos.pdf


-- 
Erk

