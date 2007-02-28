Subject: Re: [Xenomai-help] Compile-time error with xenomai x86_64
	port	(probably dualcore related)
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45E589D3.6090206@domain.hid>
References: <45E45506.10208@domain.hid> <45E456EC.2090207@domain.hid>
	<45E5865B.1020602@domain.hid> <45E58710.3020601@domain.hid>
	<45E589D3.6090206@domain.hid>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 15:36:01 +0100
Message-Id: <1172673361.23961.38.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Matthias Scheer <scheer@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

On Wed, 2007-02-28 at 14:55 +0100, Matthias Scheer wrote:
> Jan Kiszka wrote:
> >>> I'm sorry but including linux/cpumask.h doesn't fix the problem. The
> >> error stays the same. Any more tips?
> > 
> > Please post your .config then.
> 
> Using a clean defconfig together with your patch fixed it.
> 

Does the bug trigger again if you remove the patch while retaining your
defconfig?

> Thanx again.
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



