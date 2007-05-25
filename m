Message-ID: <4656AA07.20506@domain.hid>
Date: Fri, 25 May 2007 11:19:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4656A529.5000405@domain.hid> <4656A71C.2010801@domain.hid>
	<4656A7FA.9000408@domain.hid>
In-Reply-To: <4656A7FA.9000408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem compiling for user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Rodolfo Bamberg wrote:
> I thought I did compile xenomai for the same target by passing the
> --build=i386-linux-uclibc option to .configure.

No, to cross compile, you should pass --host=i386-linux-uclibc not
--build. For informations on cross-compiling Xenomai, see README.INSTALL.

-- 
                                                 Gilles Chanteperdrix


