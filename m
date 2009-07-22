From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <898521.61258.qm@domain.hid>
References: <898521.61258.qm@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Jul 2009 11:07:30 +0200
Message-Id: <1248253650.3992.374.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] xenomai exceptions tracing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Yigal Goldberger <yigal_gold@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-07-22 at 01:28 -0700, Yigal Goldberger wrote:
> Hi all,
> I'm using kernel 2.6.29.4 with xenomai .
> I'm getting an exception 769 . I'd like to know what this exception means (or hints where to look for it ).
> 

It looks like you are running a ppc system. Those are minor MMU faults,
due to PTE misses that happen on some platforms (83xx and 85xx come to
mind). Those get reported because you turned the nucleus debug switch
on. Nothing bad in your case.

> 6>MTD_open
> <6>MTD_ioctl
> <6>MTD_open
> <6>MTD_ioctl
> <6>Xenomai: Switching 802Rdr to secondary mode after exception #769 from user-sp
> ace at 0x10017cec (pid 974)
> <6>Xenomai: Posix: closing message queue descriptor 3.
> <6>Xenomai: Posix: closing message queue descriptor 4.
> <6>Xenomai: Posix: closing message queue descriptor 5.
> <6>Xenomai: Posix: closing message queue descriptor 7.
> <6>Xenomai: Posix: closing message queue descriptor 8.
> <6>Xenomai: Posix: closing message queue descriptor 9.
> <6>Xenomai: Posix: closing message queue descriptor 10.
> <6>Xenomai: Posix: closing message queue descriptor 11.
> <6>Xenomai: Posix: closing message queue descriptor 12.
> <6>Xenomai: Posix: closing message queue descriptor 14.
> <6>Xenomai: Posix: closing message queue descriptor 15.
> 
> Thanks,
> Yigal Goldberger.
> 
> 
>       
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



