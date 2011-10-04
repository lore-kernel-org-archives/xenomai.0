Message-ID: <4E8B3744.2030407@domain.hid>
Date: Tue, 04 Oct 2011 18:41:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGc_wL0GYwEPJVMOBR_niJCd9bz2VWoTA7-q-MLOAR_WW2vm2g@domain.hid>	<4E8AEB1D.2060706@domain.hid>	<CAGc_wL11cKQhxRmgYB0wU-bFii3YaqjibjgWB+=Tob3tFjsfQQ@mail.gmail.com>	<4E8B0DEA.8030102@domain.hid>
	<CAGc_wL2wb76-t7RBWJnKxgcvsrcKgnFgV4qkjvUgh5AvM7ie3g@domain.hid>
In-Reply-To: <CAGc_wL2wb76-t7RBWJnKxgcvsrcKgnFgV4qkjvUgh5AvM7ie3g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel configuration suggestions/hints
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Julien Delange <julien.delange@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 10/04/2011 03:51 PM, Julien Delange wrote:
> On Tue, Oct 4, 2011 at 9:45 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Your "rate" looks more like a period to me (that is, the reciprocal).
> 
> Yes, exactly.
> 
>> 1000000000.0 * 0.0001 is 100000, that is 100us, not 1ms. As of why you
>> get 2ms (or 200us, maybe ?) is still a mystery. Could you send us your
>> kernel configuration?
> 
> My bad, the value of rate is 0.001, this is due to a copy/paste error.
> Also, I attach the kernel configuration as requested.
> 
>> Are not the analogy calls blocking?
> 
> I think so but on the other hand, I don't think it would take so much
> time : performing the command list would take less than 1ms (I hope
> so).

Another mail in that thread seem to suggest that it could be long. Have
you tried timing the various parts of your loop to see where the time is
spent?

-- 
					    Gilles.

