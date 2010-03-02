From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B8C49FA.7050002@domain.hid>
References: <4B8C49FA.7050002@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 02 Mar 2010 10:27:07 +0100
Message-ID: <1267522027.3405.132.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running SOLO without superuser privileges?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michael Buksas <mwbuksas@domain.hid>
Cc: xenomai@xenomai.org

On Mon, 2010-03-01 at 16:12 -0700, Michael Buksas wrote:
> Hi all,
> 
> Is it possible to run, or perhaps build Xenomai/SOLO to run without 
> superuser privileges?  I don't need real-time performance guarantees for 
> this particular application.

No, this won't work. The entire emulation engine assumes that your
threads may be given different static priorities above 0; the current
implementation won't work with SCHED_OTHER threads. Besides, this does
not make much sense to emulate a priority-based scheduler without any
consideration for priority levels.

/etc/security/limits.conf may help to allow selected non-root users to
gain RT priority.

> 
> Thanks,
> Mike Buksas
> 


-- 
Philippe.



