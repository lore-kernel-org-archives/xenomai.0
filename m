Subject: Re: dovetail: posix-clock: Sporadic test failures
References: <0f37ffe247f634ac64ebe1dda8ec691300d5d9fe.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5bf33b59-828d-905e-34d9-eeeb904d8fb2@siemens.com>
Date: Tue, 22 Jun 2021 10:18:35 +0200
MIME-Version: 1.0
In-Reply-To: <0f37ffe247f634ac64ebe1dda8ec691300d5d9fe.camel@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 22.06.21 10:09, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
> Hi,
> 
> would be interesting to know if someone else is seeing sporadic test
> failures of the posix-clock tests. There are two failures that I can
> regularly reproduce on one of our (quite big) test machines:
> 
> Hardware info:
> 32 cores, Intel Xeon E5-2640, Sandy Bridge EP
> 
> a)
> posix-clock.c:285, assertion failed: diff >= 5500000000LL && diff <= 6500000000LL
> /usr/xenomai/bin/smokey: test posix_clock failed: Invalid argument
> 
> b)
> posix-clock.c:409, assertion failed: ticks == 1
> /usr/xenomai/bin/smokey: test posix_clock failed: Invalid argument
> 
> After restarting the test suite multiple times there is normally a run
> which does not report any error.
> 

There is no ntp etc. service running on that box? We have
systemd-timesyncd disabling via xeno_test now, but that might be
incomplete (or was not used here).

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

