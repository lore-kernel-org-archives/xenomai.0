Message-ID: <4F80C10E.1000804@domain.hid>
Date: Sun, 08 Apr 2012 00:34:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ9eQND3KX-1D1zL4TxcUTSFaw7k4Xd_nuN_6ByGRCRKYA@mail.gmail.com>
In-Reply-To: <CAM1yFZ9eQND3KX-1D1zL4TxcUTSFaw7k4Xd_nuN_6ByGRCRKYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Disadvantages of preempt_rt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anisha Kaul <born.rebel.83@domain.hid>
Cc: xenomai@xenomai.org

On 04/07/2012 07:33 AM, Anisha Kaul wrote:
> Greetings,
> 
> From here: http://www.xenomai.org/index.php/Xenomai:Roadmap#Xenomai_3_FAQ
> 
> Quote:
>> the target hardware platform has limited horsepower, and/or you want the real-time job to put the smallest possible overhead on your system. This is where dual kernels are usually better than a native preemption system.
> 
> 
> Preempt_rt does preempt the whole Linux. In what way does preempting
> Linux put load on the system?

I think you are misunderstanding what preempt_rt is, preempt_rt does 
not preempt linux, preempt_rt is simply linux modified, when a linux 
kernel patched with preempt_rt runs, nothing else than linux runs, so 
nothing preempts the whole linux. This is achieved by means which have 
a global overhead on the whole system. The exact means are described on 
the rt wiki FAQ:
https://rt.wiki.kernel.org/articles/f/r/e/Frequently_Asked_Questions_7407.html

Note the answer to FAQ 3, which explains that improving latencies is a
trade off, and means degrading the average performances of the system.
That is the overhead we are talking about.

-- 
                                                                Gilles.

