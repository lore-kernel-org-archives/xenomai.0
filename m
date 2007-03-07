Subject: Re: [Adeos-main] port 2.6.19 x86_64 to 2.6.20
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45EB0295.5070506@domain.hid>
References: <45E220D7.6060004@domain.hid> <1172469398.1764.79.camel@domain.hid>
	<45E9F580.3010107@domain.hid> <1172962682.13721.74.camel@domain.hid>
	<45EB0295.5070506@domain.hid>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 00:31:26 +0100
Message-Id: <1173310287.5059.57.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: trem <trem@domain.hid>
Cc: adeos-main@gna.org

On Sun, 2007-03-04 at 18:32 +0100, trem wrote:
> Hi
> 
> As I've got your start now, I've ported (at least tried) the 2.6.19
> x86_64 adeos patch to 2.6.20.
> I've tried it and it seems to works fine, here the latency :
> 
> [trem@domain.hid ~]$ cat latency_xenomai_2_6_20.txt
> [trem@domain.hid bin]$ sudo ./latency -T 10
> == Sampling period: 100 us
> == Test mode: periodic user-mode task
> == All results in microseconds
> warming up...
> RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|       0.737|       1.067|       3.332|       0|       0.737|      
> 3.332
> RTD|       0.744|       1.067|       3.568|       0|       0.737|      
> 3.568
> RTD|       0.724|       1.080|       3.362|       0|       0.724|      
> 3.568
> RTD|       0.730|       1.070|       2.900|       0|       0.724|      
> 3.568
> RTD|       0.711|       1.071|       3.441|       0|       0.711|      
> 3.568
> RTD|       0.733|       1.066|       3.547|       0|       0.711|      
> 3.568
> RTD|       0.735|       1.079|       4.523|       0|       0.711|      
> 4.523
> RTD|       0.716|       1.072|       3.307|       0|       0.711|      
> 4.523
> RTD|       0.715|       1.066|       3.507|       0|       0.711|      
> 4.523
> ---|------------|------------|------------|--------|-------------------------
> RTS|       0.711|       1.071|       4.523|       0|    00:00:10/00:00:10
> 
> 
> The patch (2.6.20 x86_64) can be found here :
> http://zarb.org/~trem/adeos-ipipe-2.6.20-x86_64-1.7-07-trem.patch
> 

s,1.7-07,1.0-07,

> I hope it could be used.
> 

Nice. Will use this work as the upcoming 2.6.20/x86_64 baseline in my
git repo. Thanks.

-- 
Philippe.



