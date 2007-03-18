From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17917.21994.572525.93172@domain.hid>
Date: Sun, 18 Mar 2007 16:08:26 +0100
Subject: Re: [Xenomai-help] question
In-Reply-To: <35481f3d0703160950t6100f375o169a0cfd7bd9e9b8@domain.hid>
References: <35481f3d0703160950t6100f375o169a0cfd7bd9e9b8@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xd yang <yangxd614@domain.hid>
Cc: xenomai@xenomai.org

xd yang wrote:
 > hi all,
 >    i'm not quite clear about  how to communicate between a xenomai driver
 > and a standard linux driver. For exemple, i have a xenomai PCI device driver
 > ,a standard linux driver  and a application in the user  space. I need to
 > enter some commands  by the application,  which will be received by the
 > standard linux driver, and then should be passed to the  xenomai task, also
 > the same thing from xenomai to standard linux .
 > 
 >   I noticed that there is a API message pipe service offered, with this API
 > can i  solve this kind of question?  And for that Xenomai driver should open
 > his side of pipe at the beginning to the end to ensure he could receive or
 > send messages?
 > 
 >    thanks a lot,
 > xd_yang

I am not sure I understand what you need. The usual way for an
application to communicate with a driver, be it a real-time driver or
not, is to use the read/write/ioctl calls. So, if your application needs
to pass a special message to the drivers, implement an ioctl in these
drivers.

Message pipes are only useful if you want a real-time application to
communicate with a non real-time application.

-- 


					    Gilles Chanteperdrix.

