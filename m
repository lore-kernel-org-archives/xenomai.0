Subject: Re: [Xenomai-help] Strange deadlock.
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45CF604F.4030706@domain.hid>
References: <45CCCD10.9000008@domain.hid> <45CD44EF.6080807@domain.hid>
	<45CD9FD1.9040509@domain.hid>  <45CF604F.4030706@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Sun, 11 Feb 2007 20:05:20 +0100
Message-Id: <1171220721.5035.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

On Sun, 2007-02-11 at 20:28 +0200, Maksym Veremeyenko wrote:
> Jan Kiszka пишет:
> 
> > You are holding the mutex across the serial transaction, i.e. a
> > secondary mode switch, right? If you haven't set
> > CONFIG_XENO_OPT_RPIDISABLE, you might be are affected by the bug in the
> > priority coupling between Xenomai and the Linux kernel. Already tried
> > latest v2.3.x SVN?
> i tried with r2170 and rewrited code for RT serial - situation the same.
> 
> Solution for me is to change tasks priority - set lower priority to task 
> that perform read/write serial driver operations under lock.
> 
> Perhaps i should rewrite code to exclude I/O operations under locked 
> mutex at all.
> 

In any case, possibly sleeping while holding a mutex and moreover in the
Linux context is not recommended, to say the least. This said, could you
try just replacing your mutex with a simple counting semaphore (RT_SEM)
and report the outcome? This would give us mome hints about what could
be involved in the issue. TIA,

> 
-- 
Philippe.



