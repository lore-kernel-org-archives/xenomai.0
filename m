Message-ID: <5268BE43.7010906@xenomai.org>
Date: Thu, 24 Oct 2013 08:29:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BLU0-SMTP361A4801D1D3A47014E894BAF010@phx.gbl>,
 <5264FD93.2070705@xenomai.org>
 <DUB123-W36A18BFF7B209662EE8979AF010@phx.gbl> <52650713.3060807@xenomai.org>
 <BLU0-SMTP278EEBC31356A65C16755F1AF030@phx.gbl>
In-Reply-To: <BLU0-SMTP278EEBC31356A65C16755F1AF030@phx.gbl>
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
To: Chiara <chiaracapretti@hotmail.it>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/23/2013 11:42 PM, Chiara wrote:
> Hi Gilles,
> I tried latency test and xeno-test..
> I would compare my histogram with yours but I think that our parameters are different..
> In my histogram the scale of the user space latency arrives on 300 microseconds and the difference between the values is 50 microseconds, while your's 5..could you say me how can I reproduce the same histogram? So I can compare them!

On what platforms are you running the test? Except on at91rm9200, 300 
microseconds is an abnormal latency. See:
http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#_the_latency_test_shows_high_latencies

-- 
                                                                Gilles.

