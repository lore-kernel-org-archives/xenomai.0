MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17665.34890.77536.711227@domain.hid>
Date: Fri, 8 Sep 2006 17:12:10 +0200
Subject: Re: [Xenomai-help] Porting / API Questions
In-Reply-To: <45007AF4.4050808@domain.hid>
References: <44FF3C26.10501@domain.hid>
	<17663.64870.945605.117981@domain.hid>
	<45007AF4.4050808@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

Jeff Webb wrote:
 > I will probably make this switch, but I would rather get the code ported to xenomai with as few changes as possible.  After that, I will try to go "the POSIX way" to future-proof the code as much as possible.

The most future-proof design is probably, as outlined by Ulrich, to only
develop drivers in kernel-space using the RTDM skin, and to use the
posix or native skins in user-space. Note that the RTDM and posix skins
are integrated, I mean that once you create a driver with RTDM, you
can access it in user-space with open, read, write, ioctl and close.

-- 


					    Gilles Chanteperdrix.

