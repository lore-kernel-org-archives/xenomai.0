Message-ID: <4505C732.5030507@domain.hid>
Date: Mon, 11 Sep 2006 15:29:38 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
References: <44FF3A22.5060901@domain.hid> <44FFE509.3090009@domain.hid>	
	<4500789C.9070804@domain.hid> <1157723967.4992.13.camel@domain.hid>
	<1157817917.5033.19.camel@domain.hid>
In-Reply-To: <1157817917.5033.19.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Philippe Gerum wrote:
> The following patch against stock 2.2.2 improves the RTAI fifo
> emulation. It reduces the overhead induced by sending highly scattered
> data over a short period of time, and basically provides a much saner
> implementation.
> 
> I'd be interested to have some feedback about this; I plan to change the
> data streaming mode of message pipes from the native API the same way.
> TIA,

I applied this patch on my linux-2.6 and 2.4 systems.  The simple 'fifotestk.c' example I posted now works fine, with no apparent memory leaks.  I can now allocate a 128 MB RTAI FIFO, which sure beats 100 KB!  Thanks for the fix!

If I try to allocate a FIFO larger than the available vmalloc space, the rtf_create routine now fails with ENOMEM, which is much better than failing on the rtf_put call.  Unfortunately, the RT-FIFO device is now EBUSY forever.  I can switch to another device, and I can allocate space for my 128 MB FIFO once again, so that is good, at least.  Here is the printk output from my program:

[ 128 MB allocation, which works ....]

Sep 11 14:43:26 kernel: fifotest_init
Sep 11 14:43:26 kernel: rtf_create returned: 2
Sep 11 14:43:26 kernel: rtf_put: 6
Sep 11 14:43:29 kernel: fifotest_cleanup
Sep 11 14:43:29 kernel: rtf_destroy returned: 0
Sep 11 14:43:32 kernel: fifotest_init
Sep 11 14:43:32 kernel: rtf_create returned: 2
Sep 11 14:43:32 kernel: rtf_put: 6
Sep 11 14:43:35 kernel: fifotest_cleanup
Sep 11 14:43:35 kernel: rtf_destroy returned: 0

[switched to 256 MB allocation here... should fail]

Sep 11 14:44:29 kernel: fifotest_init
Sep 11 14:44:29 kernel: rtf_create returned: -12
Sep 11 14:44:29 kernel: rtf_put: -22
Sep 11 14:44:33 kernel: fifotest_cleanup
Sep 11 14:44:33 kernel: rtf_destroy returned: -22

[switched back to 128 MB allocation, but the device is now busy...]

Sep 11 14:44:45 kernel: fifotest_init
Sep 11 14:44:45 kernel: rtf_create returned: -16
Sep 11 14:44:45 kernel: rtf_put: -16
Sep 11 14:44:48 kernel: fifotest_cleanup
Sep 11 14:44:48 kernel: rtf_destroy returned: -16


I modified my program to check the return value of rtf_create, but I still have the same problem:


Sep 11 15:15:23 kernel: fifotest_init
Sep 11 15:15:23 kernel: rtf_create returned: 1
Sep 11 15:15:23 kernel: rtf_put: 6
Sep 11 15:15:31 kernel: fifotest_cleanup
Sep 11 15:15:31 kernel: rtf_destroy returned: 0
Sep 11 15:15:33 kernel: fifotest_init
Sep 11 15:15:33 kernel: rtf_create returned: 1
Sep 11 15:15:33 kernel: rtf_put: 6
Sep 11 15:15:35 kernel: fifotest_cleanup
Sep 11 15:15:35 kernel: rtf_destroy returned: 0
Sep 11 15:15:51 kernel: fifotest_init
Sep 11 15:15:51 kernel: rtf_create returned: -12
Sep 11 15:15:51 kernel: could not create FIFO
Sep 11 15:16:05 kernel: fifotest_init
Sep 11 15:16:05 kernel: rtf_create returned: -16
Sep 11 15:16:05 kernel: could not create FIFO

Thanks!

-Jeff


