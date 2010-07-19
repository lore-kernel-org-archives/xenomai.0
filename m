Message-ID: <4C448815.8050803@domain.hid>
Date: Mon, 19 Jul 2010 19:15:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100316150037.11405209mnid677k@domain.hid>	<4B9FB4A8.6000903@domain.hid>	<20100316183247.34995yxgivc3ilj4@domain.hid>	<4B9FC1F2.1070002@domain.hid>	<20100316191024.117214qo52wr9aps@domain.hid>	<20100709114655.46571rvnivjguu4w@domain.hid>	<4C36F32A.4080404@domain.hid>
	<20100719184826.21461mofq8kwzh7k@domain.hid>
In-Reply-To: <20100719184826.21461mofq8kwzh7k@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Mini2440 on the kernel 2.6.30.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

Michel He wrote:
> Hello Gilles,
> 
>     I just tested the latest I-pipe with Xenomai versions 2.5.3. So  
> the average latency 7000 us has slightly been improved. It is now  
> about 4000 us, that's too much for servo motor controlling. The  
> S3C2410 PWM divider is 1/2 (this is the minimum) and the prescalar is  
> set to 0 (no shift)...

Obviously, there is an issue with your setup, drivers, or kernel because
Xenomai runs on similar ARMs with latencies under 300us, and under 100us
for more powerful processors.

So, if you are interested in running Xenomai, you will have to find
where the latencies come from. I would advise you to use the I-pipe
tracer, but I am afraid it is broken on ARM since the tracer was rebased
on Linux' tracing infrastructure, so, your best luck is with
instrumenting the code.

-- 
					    Gilles.

