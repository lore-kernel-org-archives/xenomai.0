Message-ID: <4D45C174.1010507@domain.hid>
Date: Sun, 30 Jan 2011 20:52:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTim_=XGD=Qi-92do496o=q8=itz03jHdSj1EAu-+@mail.gmail.com>	<4D45821D.5090501@domain.hid>
	<AANLkTinBoW=kEeFB3xpfi+Jkjhek32v9kvJdZ=uN0Kz7@domain.hid>
In-Reply-To: <AANLkTinBoW=kEeFB3xpfi+Jkjhek32v9kvJdZ=uN0Kz7@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question on using Xenomai patch on Ubuntu 10.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Huub van Niekerk <huubvanniekerk@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Huub van Niekerk wrote:
> Thank you. It doesn't run. For ubuntu 10.10, it said that all I have to do
> is use apt-get to install xenomai. I did that and the packagemanager tells
> me they necessary packages are installed now. Now on
> http://www.xenomai.org/index.php/Xenomai_quick_build_quide is says that
> after manual install you should end up with a kernel-<version>-xenomai. I
> don't have that. Can you point me to info where it says what I should do
> after an apt-get install ? I've been looking but can't find anything useful.

Xenomai is a Linux kernel extension. As such, it requires re-building a
Linux kernel. So, it appears that you do not really understand what
Xenomai is. Before running head-on into installing Xenomai and compiling
applications without really understand what Xenomai is, I suggest you
read a few things, here:

http://www.xenomai.org/index.php/Publications

Most notably, the "life with adeos" and "native API Tour" documents.

Please beware: if later posts on this list show that you have not done
your homework, you will be properly flamed.

The installation guide using Debian packages may be found here:
http://www.xenomai.org/index.php/Building_Debian_packages

Next private mail will receive no answer.
Please do not top-post.

-- 
                                                                Gilles.

