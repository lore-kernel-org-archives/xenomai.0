From: Krzysztof =?UTF-8?Q?B=C5=82aszkowski?= <kb@domain.hid>
In-Reply-To: <4C6EA6E0.2020402@domain.hid>
References: <1282319702.5255.405.camel@domain.hid>
	<4C6EA6E0.2020402@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 20 Aug 2010 18:14:39 +0200
Message-Id: <1282320879.5255.408.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-core] rt timer jitter
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2010-08-20 at 18:01 +0200, Gilles Chanteperdrix wrote:
> Krzysztof Błaszkowski wrote:
> > Can i do something with this ?
> 
> Do you observe the same latencies with the "latency" test?
> 

this test does not produce reliable results except some hints.

e.g. min. latency shifts about 1.5usec when i run on 2nd console dd
if=/dev/urandom of=/dev/null bs=16k.

as i recall max latency was more than 10 usec.



> 


-- 
Krzysztof Blaszkowski


