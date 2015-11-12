References: <2396B4D2166B62479FBBE370D4A7C1F30A706120@mb2010-3.intra.tut.fi>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5644C066.6050804@xenomai.org>
Date: Thu, 12 Nov 2015 17:37:58 +0100
MIME-Version: 1.0
In-Reply-To: <2396B4D2166B62479FBBE370D4A7C1F30A706120@mb2010-3.intra.tut.fi>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Error:Xenomai: /dev/rtheap is missing & Testing of
 Xenomai 3.0.1 with kernel 3.14.39
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Umair Ali <ali.umair@tut.fi>, =?UTF-8?Q?Xenomai_=e2=80=8e_, , xenomai@xenomai.org, , _=e2=80=8e?= <xenomai@xenomai.org>

On 11/12/2015 01:47 PM, Umair Ali wrote:
> Hello,
> 
> I have the following setup
> 
> 
> But when i run the xeno-regression-test under load i get the following error
> root@cpc:/usr/lib/xenomai/testsuite# xeno-regression-test -l "dohell -s 192.168.0.5 -m /mnt -l /ltp" -t 2
> Started child 6467: /bin/bash /usr/lib/xenomai/testsuite/xeno-test-run-wrapper /usr/bin/xeno-regression-test -t 2
> ++ echo 0
> ++ /usr/lib/xenomai/testsuite/arith
> Xenomai: /dev/rtheap is missing
> (chardev, major=10 minor=254)
>

Your installation mixes 3.x and legacy 2.6.x Xenomai libraries and
executables. /dev/rtheap is gone in 3.x, so
/usr/lib/xenomai/testsuite/arith most likely belongs to a former 2.6.x
install.


> In the result of the test i found that "rtdm skipped (no kernel support)", is this a problem because i have read that xenomai uses RTDM service for the drivers. I want to use the rt_8139too and if rtdm is not supported will it work fine or not?
> 

The RTDM test was skipped, which does not mean RTDM is absent. In fact,
it cannot be absent in 3.x, since it is built in the Cobalt core. You
need to build and install the module-only driver from the Testing
section (CONFIG_XENO_DRIVERS_RTDMTEST), for that test to be runnable by
the smokey test suite.

-- 
Philippe.

