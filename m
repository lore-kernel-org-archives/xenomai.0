From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17933.25582.933046.866029@domain.hid>
Date: Fri, 30 Mar 2007 21:24:30 +0200
Subject: Re: [Xenomai-help] Problem with vxworks skin
In-Reply-To: <OF810D1AC7.5B426A02-ONC12572AE.00398437-C12572AE.004281A6@domain.hid>
References: <OF810D1AC7.5B426A02-ONC12572AE.00398437-C12572AE.004281A6@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Erler <Andreas.Erler@domain.hid>
Cc: xenomai@xenomai.org

Andreas Erler wrote:
 > Hello all,
 > 
 > I want to use xenomai with vxworks skin enabled.
 > I decided to configure vxworks skin support to be a loadable module.
 > When I tried to insert this module, I got a message that I'm using the 
 > wrong timer mode (aperiodic ...), therefor I confiured periodic timer mode 
 > and recompiled the kernel.
 > Unfortunately now the kernel freezes at startup after the message 
 > 'Creating /var/log/boot.msg'
 > 
 > Any hints, what I did wrong?

You selected a timer period of 100 ns, this hangs the system. You should
select something like 1000000 for a 1000 Hz frequency, or 10000000 for a
100 Hz frequency. Be careful, if you select a 100 Hz frequency for
Xenomai, to select a 100 Hz frequency for Linux, otherwise Xenomai will
fail to initialize.

-- 


					    Gilles Chanteperdrix.

