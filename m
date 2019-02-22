Date: Fri, 22 Feb 2019 12:33:17 +0100
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: xenomai-3.0.5 include path
Message-ID: <20190222123317.62f7fb3f@md1za8fc.ad001.siemens.net>
In-Reply-To: <2019022210543291904613@aliyun.com>
References: <2019022210543291904613@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "demon.han--- via Xenomai" <xenomai@xenomai.org>
Cc: "demon.han@aliyun.com" <demon.han@aliyun.com>

Hi,

did you compare the two files? My guess would be that you are on a
system where a careless "make install" was run on multiple versions of
xenomai, possibly with prefix dirs set.

Once you are sure that both headers are indeed coming out of the same
installation, it would be time to look the the install target of make.

Henning

Am Fri, 22 Feb 2019 10:54:33 +0800
schrieb demon.han--- via Xenomai <xenomai@xenomai.org>:

> Hi,
> I am working on xenomai3.0.5 with Eherlab Ethercat.
> Here I got a problem.
> After installing xenomai,I got 2 include directory:
> 1. /usr/include/xenomai
> 2./usr/xenomai/include
> I find rtdm_driver.h in /usr/include/xenomai but
> out /usr/xenomai/include. This cause a problem,I think:
> when I compile Etherlab,I got error as"/master/rtdm.c:37:30: fatal
> error: rtdm/rtdm_driver.h: No such file or directory", so I copy the
> header to /usr/xenomai/include/rtdm,and the error is fixed. Is there
> another way to fix the problem? Best Wishes.
> demon.
> 
> 
> 
> demon.han@aliyun.com


