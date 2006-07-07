From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17582.49402.69117.801222@domain.hid>
Date: Fri, 7 Jul 2006 22:15:54 +0200
Subject: Re: [Xenomai-help] xenomai beginner problem.
In-Reply-To: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
References: <e325d110607071259g5ebc019bs2565887803265adc@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kim Chuan Lim <lim.kim.chuan@domain.hid>
Cc: xenomai@xenomai.org

Kim Chuan Lim wrote:
 > The following is the result of my locate..
 > 
 > locate xeno_native
 > /home/username/linux-2.6.17.4/kernel/xenomai/skins/native/.xeno_native.o.cmd
 > /home/username/linux-2.6.17.4/kernel/xenomai/skins/native/xeno_native.o

This may mean two things:
- either you did not compile the native skin as a module, it is
  built-in, and as suggested by the error message
  you disabled CONFIG_XENO_OPT_PERVASIVE in the "real-time subsystem"
  menu of the kernel configuration menu;
- or the compilation of the xeno_native module (and linux kernel) failed.

In order to conclude, posting /home/username/linux-2.6.17.4/.config as
well as the build logs if compilation failed, may help.

-- 


					    Gilles Chanteperdrix.

