Message-ID: <482DCAD0.1010408@domain.hid>
Date: Fri, 16 May 2008 19:56:32 +0200
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
References: <A3B06EAFE0D9C14096681C935E0B300802110A0C@zue-s-15.zue.zwick.de>	<4829613B.3000500@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DBF6@domain.hid><48297566.1010607@domain.hid><0C9896A4B6D338488AD6FFFE58BAEF100276DC66@domain.hid>	<4829AA19.8070405@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DD0C@serveur3.lgm.com>	<4829C8C9.4020300@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276DDDE@serveur3.lgm.com>	<482B3BCF.8090700@domain.hid>	<482B3EE5.9030702@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276E025@domain.hid>	<482D33B3.9070700@domain.hid>	<0C9896A4B6D338488AD6FFFE58BAEF100276E212@domain.hid>
	<482D6FF9.3050008@domain.hid> <482D82EB.3050608@domain.hid>
	<482D885A.7080706@domain.hid> <482D8B50.5090502@domain.hid>
In-Reply-To: <482D8B50.5090502@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Serial driver and TX events
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
Cc: xenomai-help <xenomai@xenomai.org>

Jan Kiszka wrote:
> Anders Blomdell wrote:
>> Jan Kiszka wrote:
>>> Anders Blomdell wrote:
>>>> Are there any reason why the serial driver could not be changed to give an event
>>>> when all characters has left the TX buffer?
>>> No, I don't think so. Somehow I have the feeling someone requested this
>>> feature before, but I cannot find any reference  or even code ATM.
>>> However. Patch would be welcome.
>> OK, I'll see what I can do. Is patch against 2.4.2 OK (pressing deadline -> I do
>> not have the time to uprade right now).
> 
> Such a patch would currently apply against trunk as-is, at least /wrt
> 16550A - but I would take care of porting in any case.
> 
>> My need for it is to make it possible to wait until all characters has left the
>> FIFO (needed for autobaud detection), so perhaps a ioctl RTIOC_DRAIN (similar to
>> RTIOC_PURGE) is a better choice (you decide what you prefer, and I'll try to
>> implement it)
> 
> Hmm, for that particular use case I guess it shouldn't be problematic to
> wait the required time after writing some probe character(s).
> 
> Otherwise, a blocking RTIOC_DRAIN sounds reasonable. That could become
> an (optional) common feature of all buffering RTDM devices.

OK, now I know why it is a bad idea. There is no way to get an interrupt when
all characters has left the FIFO and shift register (i.e. no interrupts on TEMT
indicator, and using THRE indicator means that there is still data waiting to
get out). So one could just as easily do it from user space. I.e. like:

  while (1) {
    int err;
    struct rtser_status status;

    err = rt_dev_ioctl(fd, RTSER_RTIOC_GET_STATUS, &status);
    if (err < 0) { break; }
    if (status.line_status & RTSER_LSR_TRANSM_EMPTY) { break; }
    rt_task_sleep(1000000);
  }

Sorry about the noise...

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

