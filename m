Message-ID: <bc4264770703060832x4ddab7b8mbb1d477588af8608@domain.hid>
Date: Tue, 6 Mar 2007 16:32:28 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
Subject: Re: [Xenomai-help] RTCAN and tsc
In-Reply-To: <45ED93AE.5050007@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bc4264770703060706x5dafb942weec4d4c2c5756427@domain.hid>
	<45ED84B8.3010307@domain.hid>
	<bc4264770703060753j1c67d6cat2b04e19f2ca376fa@domain.hid>
	<45ED8FC8.4090103@domain.hid>
	<bc4264770703060811p41e0dff5s80d46c0d14314a15@domain.hid>
	<45ED93AE.5050007@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi

I need to be educated a bit here if you don;t mind.

arming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat worst
RTD|      29.333|      29.333|      31.847|       0|      29.333|      31.847
RTD|      29.333|      29.333|      35.199|       0|      29.333|      35.199
RTD|      29.333|      29.333|      33.523|       0|      29.333|      35.199
RTD|      29.333|      29.333|      32.685|       0|      29.333|      35.199
RTD|      29.333|      29.333|      34.361|       0|      29.333|      35.199
RTD|      29.333|      29.333|      33.523|       0|      29.333|      35.199
RTD|      29.333|      29.333|      33.523|       0|      29.333|      35.199
RTD|      29.333|      29.333|      34.361|       0|      29.333|      35.199
RTD|      29.333|      29.333|      32.685|       0|      29.333|      35.199
RTD|      29.333|      29.333|      34.361|       0|      29.333|      35.199
RTD|      29.333|      31.847|     201.142|       0|      29.333|     201.142
RTD|      29.333|      59.504|     205.333|       0|      29.333|     205.333
RTD|      29.333|      65.371|     201.142|       0|      29.333|     205.333
RTD|      29.333|      68.723|     201.980|       0|      29.333|     205.333
RTD|      29.333|      64.533|     201.142|       0|      29.333|     205.333
RTD|      29.333|      65.371|     204.495|       0|      29.333|     205.333
RTD|      29.333|      52.799|     201.142|       0|      29.333|     205.333
RTD|      29.333|      65.371|     204.495|       0|      29.333|     205.333
RTD|      29.333|      35.199|     201.142|       0|      29.333|     205.333
RTD|      29.333|      29.333|      34.361|       0|      29.333|     205.333
RTD|      29.333|      29.333|      33.523|       0|      29.333|     205.333
---|------------|------------|------------|--------|-------------------------


What you see above (up to where max latecy jumps to 200) is the
behavior while my application is running but the node (rotary encoder)
is not moving so not sending any position signals. The moment I start
turning the encoder shaft the jump takes place.

What does output of latency mean? Is the above result simply stating
that I have a crappy hardware structure and will never be able to
achieve better latency or does it tell me there is something wrong
with my application?

Roland


On 3/6/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> roland Tollenaar wrote:
> > Ah. Will do so. But the problem I am having with the RTCAN gives
> > latencies of the order of 0.2ms fluctuating heavily and visible
> > immediately.
>
> 0.2 ms is 200 us, so I would say that the latencies you observe are
> consistent with the results of the latency program.
>
> --
>                                                  Gilles Chanteperdrix
>

