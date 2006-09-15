Subject: Re: [Xenomai-help] invalid use of FPU in Xenomai context
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4509DBEB.7020707@domain.hid>
References: <4509DBEB.7020707@domain.hid>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 10:25:20 +0200
Message-Id: <1158308720.5009.37.camel@domain.hid>
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2006-09-14 at 17:47 -0500, Jeff Webb wrote:
> I made some more progress in porting my RTLinux application, but now I'm spinning my wheels trying to track down the source of the following error:
> 
>   "invalid use of FPU in Xenomai context at ..."

This message also gives the faulty location/symbol+offset. Where does it
point to?

-- 
Philippe.



