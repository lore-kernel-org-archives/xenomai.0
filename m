MIME-Version: 1.0
Date: Fri, 4 Nov 2011 11:01:13 +0800
Message-ID: <CAEcCJg8a=qDPkn1pdPz5Jy=J_HrkrimiqMy2iP=saE4L1OYEkA@mail.gmail.com>
From: yibo dai <strlcopy@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] xenomai thread crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help <Xenomai-help@domain.hid>
Cc: Xenomai-core@domain.hid

In my current project, there is a xenomai thread in the user space,It
doing the following things:
1.recieve the TIPC message from other services then handle it
2.recieve the packet from RTNet then handle it
Program is probably as follows:
while(1) {
	select(...); /*block and waiting for TIPC messages */
	/*do something*/
	
	do {
		ret = rt_dev_recvmsg(...,MSG_DONTWAIT); /*recieve packets from RTNet*/
		/* do something */
	} while(ret > 0);
}

the RTNet stack will trigger a virtual interrupt(use the
rtdm_nrtsig_pend) when recieved a packet,then the virtual interrupt
handler will send a SIGUSR2 to the xenomai thread,...,at last the
xenomai thread wake up.the problem is the xenomai thread will crash
when calling rt_dev_recvmsg sometimes.i found that
ops->operation##_nrt(i.e. ops->recvmsg_nrt) will be call(in the
MAJOR_FUNCTION_WRAPPER_TH),but ops->recvmsg_nrt is NULL,so the xenomai
thread crash.
is my usage wrong?why the current domain become linux when executing
xenomai syscall?by the way,what is the reason to remove
CONFIG_XENO_OPT_ISHIELD?

system info:
Xenomai version:2.5.3/2.5.6
RTNet version:0.9.12
Linux version:2.6.28
Adeos patch:adeos-ipipe-2.6.28.10-arm-1.12-07.patch
processor:at91sam9260

Thanks very much!!

