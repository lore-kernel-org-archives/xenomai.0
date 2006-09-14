Subject: Re: [Xenomai-help] premetion
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <9D98C51005D80D43A19A3DF329A61D6951562F@INDEXCH2003.gmi.domain>
References: <9D98C51005D80D43A19A3DF329A61D6951562F@INDEXCH2003.gmi.domain>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 14:17:44 +0200
Message-Id: <1158236264.5040.78.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Nilanjan Roychowdhury <Nilanjan.Roychowdhury@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-09-14 at 17:37 +0530, Nilanjan Roychowdhury wrote:
> Can a normal Linux thread ( pthread with priority 90) can preempt any
> user space XENOMAI thread with priority (85). If the XENOMAI thread is
> running in primary domain ???

No, only if the latter runs in secondary mode.
https://mail.gna.org/public/xenomai-help/2006-08/msg00196.html


> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



