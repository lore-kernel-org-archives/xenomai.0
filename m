From: Sebastian Smolorz <ssm@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
Date: Tue, 6 Mar 2007 17:45:58 +0100
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<45ED93AE.5050007@domain.hid>
	<bc4264770703060832x4ddab7b8mbb1d477588af8608@domain.hid>
In-Reply-To: <bc4264770703060832x4ddab7b8mbb1d477588af8608@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HOcnN-0005Ys-PH@mailer.emlix.com>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roland Tollenaar <rolandtollenaar@domain.hid>
Cc: xenomai@xenomai.org

roland Tollenaar wrote:
> Hi
>
> I need to be educated a bit here if you don;t mind.
>
> arming up...
> RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst RTD|      29.333|      29.333|      31.847|       0|      29.333|    
>  31.847 RTD|      29.333|      29.333|      35.199|       0|      29.333|  
>    35.199 RTD|      29.333|      29.333|      33.523|       0|      29.333|
>      35.199 RTD|      29.333|      29.333|      32.685|       0|     
> 29.333|      35.199 RTD|      29.333|      29.333|      34.361|       0|   
>   29.333|      35.199 RTD|      29.333|      29.333|      33.523|       0| 
>     29.333|      35.199 RTD|      29.333|      29.333|      33.523|      
> 0|      29.333|      35.199 RTD|      29.333|      29.333|      34.361|    
>   0|      29.333|      35.199 RTD|      29.333|      29.333|      32.685|  
>     0|      29.333|      35.199 RTD|      29.333|      29.333|      34.361|
>       0|      29.333|      35.199 RTD|      29.333|      31.847|    
> 201.142|       0|      29.333|     201.142 RTD|      29.333|      59.504|  
>   205.333|       0|      29.333|     205.333 RTD|      29.333|      65.371|
>     201.142|       0|      29.333|     205.333 RTD|      29.333|     
> 68.723|     201.980|       0|      29.333|     205.333 RTD|      29.333|   
>   64.533|     201.142|       0|      29.333|     205.333 RTD|      29.333| 
>     65.371|     204.495|       0|      29.333|     205.333 RTD|     
> 29.333|      52.799|     201.142|       0|      29.333|     205.333 RTD|   
>   29.333|      65.371|     204.495|       0|      29.333|     205.333 RTD| 
>     29.333|      35.199|     201.142|       0|      29.333|     205.333
> RTD|      29.333|      29.333|      34.361|       0|      29.333|    
> 205.333 RTD|      29.333|      29.333|      33.523|       0|      29.333|  
>   205.333
> ---|------------|------------|------------|--------|-----------------------
>--
>
>
> What you see above (up to where max latecy jumps to 200) is the
> behavior while my application is running but the node (rotary encoder)
> is not moving so not sending any position signals. The moment I start
> turning the encoder shaft the jump takes place.
>
> What does output of latency mean? Is the above result simply stating
> that I have a crappy hardware structure and will never be able to
> achieve better latency or does it tell me there is something wrong
> with my application?

That is still to discover. Please change the priorities of your RT Tasks lower 
than 99 and run again, Alternatively, do it with rtcansend/rtcanrecv as I 
told you before.

-- 
Sebastian

