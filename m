From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17457.5070.917000.693950@domain.hid>
Date: Mon, 3 Apr 2006 14:23:42 +0200
Subject: Re: [Xenomai-help] Problem with posix skin and Xenomai 2.1.0
In-Reply-To: <20060403111703.593b2b15@domain.hid>
References: <20060403111703.593b2b15@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jens Niehaus <niehaus@domain.hid>
Cc: xenomai@xenomai.org

Jens Niehaus wrote:
 > Hi,
 > 
 > I am experiencing problems with xenomai 2.1.0 and pthread_mutex_init. The second initialization in the following program returns with a value of 16 (EBUSY). What is wrong with the code (or with xenomai)?

There was a bug in syscall.c, which should be fixed by revision 870 in
the trunk and by revision 871 in 2.1 branch.

Thanks for reporting.

-- 


					    Gilles Chanteperdrix.

