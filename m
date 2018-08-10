Date: Fri, 10 Aug 2018 10:50:06 +0300 (EEST)
From: =?windows-1251?B?2OXi9+Xt6u4g0uDw4PEgw/Do4+7w/OXi6Pc=?=
 <shevchenko.taras@triolcorp.com.ua>
Message-ID: <973624104.26400815.1533887406369.JavaMail.zimbra@triolcorp.com.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] ioctl call long time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Good day! 
I try to use ioctl from user space to call ioctl_rt in my module 

code user space 

QDateTime t1 = QDateTime::currentDateTime(); 
for (int ij =0; ij<1000; ij++) { 
ret=ioctl(fpga_fd, XDMA_EXCHANGE_DATA, lenErpPcie_wr); // if comment this line , runtime abaut 1 mks 
} 
QDateTime t2 = QDateTime::currentDateTime(); 
qint64 tt = t2.toMSecsSinceEpoch() - t1.toMSecsSinceEpoch(); 
printf("readwriteFPGA 1000 time = %d \n",(int)tt); 

driver code: 

int xilinx_ioctl_rt( struct rtdm_fd *fd, unsigned int cmd, void __user *arg) { 
long ret = -EINVAL; 
case XDMA_EXCHANGE_DATA: 
// printk(KERN_INFO "time start"); 
ret=rtdm_event_timedwait(&fpga_event,25000,NULL); 
//printk(KERN_INFO "time end"); 
break; 

} 
return ret; 
} 

the problem is I always get time aproximately 200mks + xxx 000 mks time to wait 
but if I uncomment printk lines I can see time to wait are respected in kernel log 
How I can minimaze ioctl call delay ? I need exchange data every 100 mks 

Xenomai 3.0.6 
skin posix 
CONFIG_HZ=1000 
