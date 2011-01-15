Message-ID: <4D3227DA.9080909@domain.hid>
Date: Sun, 16 Jan 2011 00:03:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4D31B6C3.5060007@domain.hid>
In-Reply-To: <4D31B6C3.5060007@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Question on periodic task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wong Sheng Chao <wong@domain.hid>
Cc: xenomai@xenomai.org

Wong Sheng Chao wrote:
> Hi
> 
> I'm a newbie in real time programming and I recently came to know of 
> Xenomai. After patching the Xenomai to the linux kernel, I ran some 
> examples that I found from the Internet to get a better understanding of 
> the periodic task. Everything seems to run fine when I start two tasks 
> with period of 1s and 2s, but the system freezes when I added more tasks 
> ( more than 2 tasks). The period is at 1s, 2s and 3s so i think the 
> processor has more than enough time to process the tasks.
> 
> I also read that the periodic mode is emulated by a software driver 
> which uses one-shot mode programming. Thus i did not enable periodic 
> timing when I compile the Linux kernel, is this the cause of the problem?
> 
> I'm using a system with Core i7, ubuntu 10.04, linux kernel 2.6.32.15, 
> xenomai 2.5.4
> 
> Do let me know what I did wrong in the code, thanks in advance!!

You almost send us all the information we ask on this page:
http://www.xenomai.org/index.php/Request_for_information

We lack:
- the version of the Adeos patch you use
- the kernel logs from the boot up to the bug itself.

-- 
                                                                Gilles.

