Message-ID: <4F06C291.6020402@domain.hid>
Date: Fri, 06 Jan 2012 10:44:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAP1XtZx2JdZAs3SvbWGC8vkuwo+V5v8d69EBvBGzKmKLGi0iPQ@mail.gmail.com>
In-Reply-To: <CAP1XtZx2JdZAs3SvbWGC8vkuwo+V5v8d69EBvBGzKmKLGi0iPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with installation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Santiago Focke <focke.85@domain.hid>
Cc: xenomai@xenomai.org

On 01/05/2012 08:16 PM, Santiago Focke wrote:
> Hi all
> 
> I'm quite new with Linux and Xenomai. I'm using Ubunto kernel
> 2.6.32-24-generic. I tied to install Xenomai-2.6 following the
> README.INSTALL document. First of all I cloned the GIT repository in
> 
> /usr/src/xenomai-2.6
> 
> After that, I tried to run the prepare-kernel.sh script as follows:
> 
> /usr/src/xenomai-2.6/scripts/prepare-kernel.sh
> --linux=/usr/src/linux-headers-2.6.32-24-generic/

That is not going to work. Xenomai patches the kernel sources, and ask
you to rebuild a kernel, just supplying the headers will not work.


-- 
					    Gilles.

