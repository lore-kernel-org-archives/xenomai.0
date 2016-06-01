From: Ali Umair <ali.umair@tut.fi>
Date: Wed, 1 Jun 2016 13:03:18 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A73A888@mb2010-1.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A739854@mb2010-1.intra.tut.fi>
 <20160601122543.GA14103@hermes.click-hack.org>
In-Reply-To: <20160601122543.GA14103@hermes.click-hack.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_timer_start causes switching to secondary mode
 and Bug
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello

Thanks Gilles and sorry for first incomplete email. The code files and kernel log files are attached with this email

The system is x86 architecture and 3.14.39-xenomai-3.0.1.

root@cpc:/usr/xenomai/sbin# /usr/xenomai/bin/xeno-config --info|grep -i build 
Build args: --with-core=cobalt --enable-smp --enable-pshared --enable-x86-vsyscall --enable-dlopen-libs --enable-tls

I hope new information will be helpful. I am extremely sorry I am missing anything still

Thanks & BR
ali

-----Original Message-----
From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
Sent: June-01-16 3:26 PM
To: Ali Umair
Cc: xenomai@xenomai.org
Subject: Re: [Xenomai] rtdm_timer_start causes switching to secondary mode and Bug

On Wed, Jun 01, 2016 at 12:15:57PM +0000, Ali Umair wrote:
> Hello
> 
> I am using 3.14.39-xenomai-3.0.1. I am trying following

Please use Xenomai 3.0.2

> 
> Kernel module:
> - Make a buffer i.e. char  buffer[4000][126] and initializing the 
> buffer using memset in the initial thread
> - Filled the buffer in the read thread of module
> - After filling the buffer start the timer
> 
> As I start the timer after filling the buffer the kernel displays the 
> message that switching to secondary  mode and A bug. The whole message 
> is end of the email

The data you sent are unreadable. If you want help, and do not want to give all the details asked by the https://xenomai.org//asking-for-help/ page, then at least send properly formatted logs.

Anyway, very much likely the timer address you pass to rtdm_timer_start is not initialized, or the address you pass is invalid, or becomes invalid because you used an object on stack.

In such a case, posting the code of the module would help: the description you send describes what you think you are doing, the code shows what you are really doing, and usually, if there is a bug, it is because there is a difference between the two.

-- 
					    Gilles.
https://click-hack.org
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: kernel_log.txt
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160601/95c9e9b9/attachment.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: pcap_replay.c
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160601/95c9e9b9/attachment.c>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: raw_packet.c
URL: <http://xenomai.org/pipermail/xenomai/attachments/20160601/95c9e9b9/attachment-0001.c>
