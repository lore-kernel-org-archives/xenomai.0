From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17972.56456.733824.718865@domain.hid>
Date: Sun, 29 Apr 2007 19:57:28 +0200
In-Reply-To: <4634D43D.3070800@domain.hid>
References: <f10l2a$rdk$1@domain.hid> <463457A0.7030008@domain.hid>
	<4634B1DA.4040705@domain.hid> <4634D43D.3070800@domain.hid>
Subject: Re: [Xenomai-help] very simple example for rtdm
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
Cc: trem <tremyfr@domain.hid>, xenomai@xenomai.org

Jan Kiszka wrote:
 > trem wrote:
 > > Jan Kiszka wrote:
 > >> trem wrote:
 > >>  o As RTDM is mainly about "RT", why not switching to .read_rt and
 > >>    .write_rt? That means of course creating a shadow thread in
 > >>    read_simple_rtdm.
 > >>
 > >>   
 > > I supose that it needs to add a rt task in read_simple_rtdm,
 > > and all read/write will be done in this task. My goal was to
 > > do a as simple as possible example, but this idea add some
 > > code. Is this added code really usefull for a simple example ?
 > 
 > Well, the complication consists of a rt_task_shadow() in
 > read_simple_rtdm's main. But as I said later, you may also come to this
 > topic incrementally.

... or you could use the POSIX skin, in which case the shadowing of the
main thread is automatically done by the skin.

-- 


					    Gilles Chanteperdrix.

