Message-ID: <4D1FAC60.4020705@domain.hid>
Date: Sat, 01 Jan 2011 23:36:16 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikSv9m0efGfxgcQ=0Bee5DPxZSC+4U=Csd4ccwM@mail.gmail.com>
In-Reply-To: <AANLkTikSv9m0efGfxgcQ=0Bee5DPxZSC+4U=Csd4ccwM@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_dev_read hangup
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Warner <xenomai.start@domain.hid>
Cc: xenomai@xenomai.org

Peter Warner wrote:
> Hi Xenomai Users,
> 
> first I Will Give the Details of My System:
> 
> Processor: core2duo
> RAM: 4GB
> Operating System: Ubuntu 10.04
> kernel: 2.6.32.15 (Patched with xenomai)
> Xenomai: 2.5.4
> 
> I am Using UART sample code Code Provided with xenomai. It is working fine
> for about few minutes I am able to send and receive data accurately.
> I am using rt_dev_read()  and rt_dev_write() from the user space to read and
> write the data respectively. However the code is getting hanged after some
> time I tried to debug and Finally I found the code is getting hanged every
> time at rt_dev_read() it is not coming back from there.
> 
> What Might be wrong here I tried to find out the documentation of
> rt_dev_read() but I did not get it.

rt_dev_read is documented here:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__userapi.html#g89c490849c0e1879ae672a23b84a1eda

> Again I tried the same with xenomai-2.5.5.2 and I found it is getting hanged
> Immediately i.e It is not running at all.
> 
> can any of you Please Suggest whats the Wrong Here.
> any Suggestion?

2.5.5 introduced a multi-processor scheduler bug. This, along with a few
other bugs, should be fixed in the next release of the 2.5 branch.

In the mean-time, you can try running a kernel compiled without
CONFIG_SMP, or apply the following patch:
http://git.xenomai.org/?p=xenomai-head.git;a=commit;h=1e71e8300dfc64fef918033663567d6a65ad638c

-- 
                                                                Gilles.

