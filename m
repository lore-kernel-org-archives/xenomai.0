MIME-Version: 1.0
In-Reply-To: <5066A426.7060900@xenomai.org>
References: <CAKKWdtctThpDZ=_QTGrLRXVkoc16hVg-CbFO1U7MsdWRtywFFg@mail.gmail.com>
	<5066A426.7060900@xenomai.org>
Date: Sat, 29 Sep 2012 11:29:28 +0330
Message-ID: <CAKKWdte3Y9CFJXwjaVRuAE0ee=syRzcpTq6XGH+nX+hYppUj6g@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] some errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

CONFIG_XENO_DRIVERS_TIMERBENCH=y
but i do not see any xeno_timerbench module!

Can you write the path?


On Sat, Sep 29, 2012 at 11:02 AM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 09/29/2012 09:20 AM, ali hagigat wrote:
>
>> I am using Xenomai, 2.6.0.
>
>
> That is stupid.
>
>>
>> The man page of latency program should be corrected:
>>
>> "The system must run a suitable Xenomai enabled kernel with the respective
>>        module (xeno_timerbench)"
>>
>> There is no xeno_timerbench module in the system!
>
>
> See CONFIG_XENO_DRIVERS_TIMERBENCH in kernel configuration.
>
> --
>                                                                 Gilles.

