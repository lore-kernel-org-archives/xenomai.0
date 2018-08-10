References: <973624104.26400815.1533887406369.JavaMail.zimbra@triolcorp.com.ua>
From: greg gallagher <greg@embeddedgreg.com>
Message-ID: <8ace4cad-88f1-f718-75b1-fa2012b429dd@embeddedgreg.com>
Date: Fri, 10 Aug 2018 11:50:00 -0400
MIME-Version: 1.0
In-Reply-To: <973624104.26400815.1533887406369.JavaMail.zimbra@triolcorp.com.ua>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Xenomai] ioctl call long time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?0KjQtdCy0YfQtdC90LrQviDQotCw0YDQsNGBINCT0YDQuNCz0L7RgNGM0LU=?= =?UTF-8?B?0LLQuNGH?= <shevchenko.taras@triolcorp.com.ua>, xenomai <xenomai@xenomai.org>



On 2018-08-10 03:50 AM, Шевченко Тарас Григорьевич wrote:
> Good day!
> I try to use ioctl from user space to call ioctl_rt in my module
>
> code user space
>
> QDateTime t1 = QDateTime::currentDateTime();
> for (int ij =0; ij<1000; ij++) {
> ret=ioctl(fpga_fd, XDMA_EXCHANGE_DATA, lenErpPcie_wr); // if comment this line , runtime abaut 1 mks
> }
> QDateTime t2 = QDateTime::currentDateTime();
> qint64 tt = t2.toMSecsSinceEpoch() - t1.toMSecsSinceEpoch();
> printf("readwriteFPGA 1000 time = %d \n",(int)tt);
>
> driver code:
>
> int xilinx_ioctl_rt( struct rtdm_fd *fd, unsigned int cmd, void __user *arg) {
> long ret = -EINVAL;
> case XDMA_EXCHANGE_DATA:
> // printk(KERN_INFO "time start");
> ret=rtdm_event_timedwait(&fpga_event,25000,NULL);
> //printk(KERN_INFO "time end");
> break;
>
> }
> return ret;
> }
>
> the problem is I always get time aproximately 200mks + xxx 000 mks time to wait
> but if I uncomment printk lines I can see time to wait are respected in kernel log
> How I can minimaze ioctl call delay ? I need exchange data every 100 mks
>
> Xenomai 3.0.6
> skin posix
> CONFIG_HZ=1000
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
Do the QT functions call the Xenomai services under the hood?  Can you 
confirm that rtdm_event_timedwait isn't timing out?

-Greg

