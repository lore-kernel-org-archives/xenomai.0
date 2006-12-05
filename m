Message-ID: <457571B6.4030409@domain.hid>
Date: Tue, 05 Dec 2006 14:18:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai install problems
References: <20061204133717.GA20186@domain.hid> <457445AB.8060203@domain.hid>
	<20061205120830.GA8491@domain.hid>
In-Reply-To: <20061205120830.GA8491@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Anthony Sharobaiko <anthony@domain.hid>
Cc: xenomai@xenomai.org

Anthony Sharobaiko wrote:
> On Mon, Dec 04, 2006 at 04:58:35PM +0100, Gilles Chanteperdrix wrote:
> 
>>>I try to get Xenomai running on arm (PXA board). Currently everything
>>>compiles perfectly, but testsuite examples simply segfault:
>>
>>Maybe you got the syscall interception wrong ? Could you show us the
>>difference between your version of arch/arm/kernel/entry-common.S and
>>the original ?
> 
> 
> Yep, thanks! I've overlooked some minor modification there.
> 
> Now, I'm getting this:
> === cut here ===
> root@domain.hid# ./run 
> *
> *
> * Type ^C to stop this application.
> *
> *
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|      14.153|      14.769|      39.384|       0|      14.153|
> 39.384
> RTD|      14.153|      14.461|      35.384|       0|      14.153|
> 39.384
> RTD|      14.153|      14.769|      39.692|       0|      14.153|
> 39.692
> === cut here ===
> 
> After printing these lines board hangs in some strange way: it does not reply
> to ping, does not reply on serial console, but heartbeat LED works =/
> 
> Number of output lines seems to be random (sometimes it ends on 'warming up...')
> Changing priority in latency.c to LOPRIO didn't help.
> 
> Hmm, any suggestions? 

100us is probably not enough, you should pass -p 1000 to latency.

-- 
                                                 Gilles Chanteperdrix

