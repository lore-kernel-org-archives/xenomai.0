From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] Compiling Linux+Xenomai 32bits
	kernel	on	FC6	x86_64?
Date: Thu, 18 Jan 2007 20:36:14 +0000
References: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>
	<45AF5E27.9040600@domain.hid> <45AF5FA5.3080201@domain.hid>
In-Reply-To: <45AF5FA5.3080201@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701182036.14132.paul_c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


Hi Jan

On Thursday 18 January 2007 11:53, Jan Kiszka wrote:
> BTW, posting your current status as patch would be the best start for a
> discussion and for inviting others to join the hack. Even if it's just
> uncompilable incomplete stuff.

http://zathras.tuxcnc.org/ipipe contains a snapshot of the hacks to date..

adeos-ipipe-2.6.19-i386-1.6-01.patch - The baseline patch being used as a 
reference.

adeos-ipipe-2.6.19-x86_64-1.6.patch - A diff of a vanilla kernel + the above 
patch.

linux-2.6.19-xeno_x86_64.tar.bz2 - Tarball of the tree with the above patches 
applied.

linux-2.6.19.tar.bz2 - The original virgin tarball.

Please note: The x86_64 stuff is incomplete, will not compile, and will eat 
the cat.

I've tried to get to grips with git and Wolfgang's repository, but somehow 
managed to trash copies on my main dev box and zathras (my web server).


Regards, Paul.

