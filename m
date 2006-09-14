From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17673.18829.576156.702825@domain.hid>
Date: Thu, 14 Sep 2006 14:22:37 +0200
Subject: Re: [Xenomai-help] premetion
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D6951562F@INDEXCH2003.gmi.domain>
References: <9D98C51005D80D43A19A3DF329A61D6951562F@INDEXCH2003.gmi.domain>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nilanjan Roychowdhury <Nilanjan.Roychowdhury@domain.hid>
Cc: xenomai@xenomai.org

Nilanjan Roychowdhury wrote:
 > Can a normal Linux thread ( pthread with priority 90) can preempt any
 > user space XENOMAI thread with priority (85). If the XENOMAI thread is
 > running in primary domain ???

No, but a Xenomai thread in secondary domain can, if
CONFIG_XENO_OPT_RPIDISABLE is not enabled.

-- 


					    Gilles Chanteperdrix.

