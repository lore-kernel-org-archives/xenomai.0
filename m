Message-ID: <4CB33888.9010807@domain.hid>
Date: Mon, 11 Oct 2010 18:17:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4CB33738.206@domain.hid>
In-Reply-To: <4CB33738.206@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and capabilities
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

Anders Blomdell wrote:
> We are planning to extend our use of xenomai to a wider audience at our
> department, and therefore I would like to know which is the better way to let
> users run xenomai programs with a minimum of system privileges, the
> possibilities I can see are:
> 
> 1. Let the user run anything as root; simple but obviously a security nightmare.
> 2. Write a suid program that let's its children inherit the right capabilities
> and then does a seteuid and does an execve; unfortunately this implies that the
> program that is execve'd has the right capabilties set [which has to be done by
> the suid program as well], and this can only be done on filesystems that can
> have extended attributes (i.e. no FAT, NFS, etc).
> 3. Write a suid program that drops all unneeded privileges and then use dlopen
> and friends to execute the user code.
> 
> I guess that there exists better ways, so somebody please enlighten me.

Did you try:
http://www.xenomai.org/index.php/Non-root_RT

-- 
					    Gilles.

