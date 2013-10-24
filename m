Message-ID: <5268C6D3.7040701@xenomai.org>
Date: Thu, 24 Oct 2013 09:05:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU0-SMTP361A4801D1D3A47014E894BAF010@phx.gbl>,
 <5264FD93.2070705@xenomai.org>
 <DUB123-W36A18BFF7B209662EE8979AF010@phx.gbl> <52650713.3060807@xenomai.org>
 <BLU0-SMTP278EEBC31356A65C16755F1AF030@phx.gbl>,
 <5268BE43.7010906@xenomai.org> <DUB123-W3326B51B0B1E7C8ED2DE7EAF0C0@phx.gbl>
In-Reply-To: <DUB123-W3326B51B0B1E7C8ED2DE7EAF0C0@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help with the histogram of latency test
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Chiara Capretti <chiaracapretti@hotmail.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/24/2013 09:01 AM, Chiara Capretti wrote:
>> Date: Thu, 24 Oct 2013 08:29:23 +0200
>> From: gilles.chanteperdrix@xenomai.org
>> To: chiaracapretti@hotmail.it
>> CC: xenomai@xenomai.org
>> Subject: Re: [Xenomai] Help with the histogram of latency test
>>
>> On 10/23/2013 11:42 PM, Chiara wrote:
>>> Hi Gilles,
>>> I tried latency test and xeno-test..
>>> I would compare my histogram with yours but I think that our parameters are different..
>>> In my histogram the scale of the user space latency arrives on 300 microseconds and the difference between the values is 50 microseconds, while your's 5..could you say me how can I reproduce the same histogram? So I can compare them!
>>
>> On what platforms are you running the test? Except on at91rm9200, 300 
>> microseconds is an abnormal latency. See:
>> http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_the_latency_test_shows_high_latencies
>
> I'm running the test on an X86.. Intel core i7, 2.9 GHz. I installed >
Ubuntu and Xenomai on a virtual machine.

The latencies you get do not mean anything then.

Please, no top posting.

-- 
                                                                Gilles.

