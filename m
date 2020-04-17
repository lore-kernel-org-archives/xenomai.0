From: =?gb2312?B?z8S67sG/?= <xia.h.l@lynuc.cn>
Subject: linux4.14+xenomai3.1 real-time
Date: Fri, 17 Apr 2020 17:36:39 +0800
Message-ID: <002c01d6149b$b2460cf0$16d226d0$@lynuc.cn>
MIME-Version: 1.0
Content-Language: zh-cn
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: huang.c.h@lynuc.cn

dear Xenomai Team:

When we tested on the Intel(r) Celeron(r) processor 1047ue (third
generation) motherboard (using kernel version: 4.1.18, xenomai version: 2.6.
5, patch: ipipe-core-4.1.18-x86-3. ), The real-time test results meet the
requirements.But the 4.1.18 version of the kernel (xenomai version 2.6.5)
running on the Intel(r) Celeron(r) processor 3955U (sixth generation)
motherboard can not guarantee real-time performance

And on Intel(r) Celeron(r) processor 3955U (sixth generation) motherboard
(kernel version: 4.14.134, xenomai version: 3.1, patch:
ipipe-core-4.14.134-x86-2. Patch ), We have done many configuration
modification tests. However, the maximum jitter is 25u under 1ms, the
real-time test results cannot meet our requirements. Our goal is a maximum
jitter of around 10u. 

We would like to ask what relevant content needs to be modified.

 

