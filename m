Message-ID: <45E9F580.3010107@domain.hid>
Date: Sat, 03 Mar 2007 23:24:00 +0100
From: trem <trem@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] port 2.6.19 x86_64 to 2.6.20
References: <45E220D7.6060004@domain.hid> <1172469398.1764.79.camel@domain.hid>
In-Reply-To: <1172469398.1764.79.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

Philippe Gerum wrote:
> On Mon, 2007-02-26 at 00:50 +0100, trem wrote:
>   
>> Hi
>>
>> I've tried to port the 2.6.19 x86_64 adeos patch to 2.6.20. you can find
>> it here :
>> http://zarb.org/~trem/adeos-ipipe-2.6.20-x86_64-1.7-03-trem.patch
>>     
>
> The good news is that moving to 2.6.20 does not seem to be too much of a
> hell. Right?
>
>   
Yes, there are few conflict so it's quite easy to port xenomai to 2.6.20.
>> I can apply it with with prepare_kernel.sh (from xenomai svn), but I haven't
>> tested it yet (I mean run kernel).
>>
>> I hope this patch is good enough to be used. Otherwise, I'd be pleased
>> to fix it (maybe with a bit of help).
>>
>>     
>
> We are hopefully close to have a reasonably good patch for 2.6.19. Once
> we achieve this, porting to 2.6.20 should be the next step. Thanks.
>
>   
I've seen ths in the Changelog : "this closes the implementation phase
of the x86_64 port."
So I suppose that the patch for 2.6.19 is finished. I've tried it and it
works fine.
The result of latency is :

[trem@domain.hid bin]$ sudo ./latency -T 10
== Sampling period: 100 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 100 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|       0.760|       1.073|       3.660|       0|       0.760|      
3.660
RTD|       0.737|       1.063|       3.012|       0|       0.737|      
3.660
RTD|       0.741|       1.083|       3.396|       0|       0.737|      
3.660
RTD|       0.755|       1.088|       2.344|       0|       0.737|      
3.660
RTD|       0.754|       1.093|       3.431|       0|       0.737|      
3.660
RTD|       0.755|       1.089|       5.119|       0|       0.737|      
5.119
RTD|       0.724|       1.091|       3.126|       0|       0.724|      
5.119
RTD|       0.762|       1.089|       3.171|       0|       0.724|      
5.119
RTD|       0.751|       1.097|       5.508|       0|       0.724|      
5.508
---|------------|------------|------------|--------|-------------------------
RTS|       0.724|       1.085|       5.508|       0|    00:00:10/00:00:10

If I don't mistake, I see a max latency of 5us. Is it realistic ?

Now, the port to 2.6.20 is open ? we can work on ?


trem




