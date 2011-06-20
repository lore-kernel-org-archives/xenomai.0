Message-ID: <4DFF86DB.1090003@domain.hid>
Date: Mon, 20 Jun 2011 19:43:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DF9CA75.1040903@domain.hid>	<4DF9DCE3.70703@domain.hid>	<BANLkTinki=NqJ1f1vyGNBMHLZuwiCtrmMw@domain.hid>	<4DFBA463.3090902@domain.hid>	<4DFBAEB9.8060106@domain.hid>	<4DFBB08B.5020005@domain.hid>	<4DFCC18F.3060207@domain.hid>
	<BANLkTin00xA-LMikumq1C4_nFyFbCdgi+Q@mail.gmail.com>
	<4DFF610F.5070602@domain.hid> <4DFF664C.5030504@domain.hid>
In-Reply-To: <4DFF664C.5030504@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on i7-870
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jakub Nowacki <j.s.nowacki@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/20/2011 05:25 PM, Jakub Nowacki wrote:
> On 06/20/2011 04:02 PM, Gilles Chanteperdrix wrote:
>> To make proper benchmarks, you should:
>> - let the latency run long
>> - provide some load, you can use the dohell script in xenomai-head to
>> generate the load.
>>
> I've generated a load using 'dd if=/dev/zero of=/dev/null' one for each 
> core (8 in total), which is roughly the way how xeno-test does it. The 
> test was running for 30 min, which is not very long but I should see the 
> long latencies by that time, I think at least.

xeno-test adds many more way to generate load, which you should use if
you intend to have good results (I mean, really pessimistic ones). If
you do not have time to run LTP completely, you can use hackbench for a
few hours.

-- 
                                                                Gilles.

