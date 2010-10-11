Message-ID: <4CB33738.206@domain.hid>
Date: Mon, 11 Oct 2010 18:11:36 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai and capabilities
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

We are planning to extend our use of xenomai to a wider audience at our
department, and therefore I would like to know which is the better way to let
users run xenomai programs with a minimum of system privileges, the
possibilities I can see are:

1. Let the user run anything as root; simple but obviously a security nightmare.
2. Write a suid program that let's its children inherit the right capabilities
and then does a seteuid and does an execve; unfortunately this implies that the
program that is execve'd has the right capabilties set [which has to be done by
the suid program as well], and this can only be done on filesystems that can
have extended attributes (i.e. no FAT, NFS, etc).
3. Write a suid program that drops all unneeded privileges and then use dlopen
and friends to execute the user code.

I guess that there exists better ways, so somebody please enlighten me.

Regards

Anders Blomdell
-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

