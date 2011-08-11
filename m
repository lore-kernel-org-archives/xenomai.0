Message-ID: <4E438724.2070709@domain.hid>
Date: Thu, 11 Aug 2011 09:39:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201108101449.54243.carlosnov@domain.hid>	<201108101657.58176.carlosnov@domain.hid>
	<201108101810.02640.carlosnov@domain.hid>
In-Reply-To: <201108101810.02640.carlosnov@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Trouble with rtdm timers and events
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Carlos Eduardo de Brito Novaes <carlosnov@domain.hid>
Cc: xenomai@xenomai.org

On 08/10/2011 11:10 PM, Carlos Eduardo de Brito Novaes wrote:
> Hello again.
> I traced the errors down and now dicovered that calling printf (as it would 
> be) turns a real time task in a non real time one. so I chaged the code and it 
> is almost working as expected, except for something that now seens to be some 
> kind of bug. If I use any sord of rtdm_event_[timed,]wait, the app returns and 
> there is a trace on kernel about a null pointer, just after the call to wait. 
> It seens similar with
> <http://www.mail-archive.com/xenomai@xenomai.org>
> And I there is no other references on google. So I will try to recompile with 
> some changes and maybe test with another kernel. Hope you can point something
> I am running in a AMD Athlon(tm) 64 X2 Dual Core Processor 4000+, kernel 
> 2.6.38-8, ubuntu natty 11.04 and latest stable xenomai source.
> If it will help, I can send the code.

Please try and reduce the code to a simple, self-contained test case
which we can run to reproduce the issue. It is the only way we can help.

-- 
                                                                Gilles.

