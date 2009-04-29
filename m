From: Vikesh Rambaran <vikesh.rambaran@domain.hid>
In-Reply-To: <1240927256.6990.382.camel@domain.hid>
References: <49F69924.8070001@domain.hid> <1240913240.6990.347.camel@domain.hid>
	<49F6F4DD.6000902@domain.hid> <1240926119.6990.368.camel@domain.hid>
	<49F70883.4080005@domain.hid>  <1240927256.6990.382.camel@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 29 Apr 2009 09:52:07 +0200
Message-Id: <1240991527.6300.21.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-core] xenomai 2.5 rc1 timing computations.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi

On Tue, 2009-04-28 at 16:00 +0200, Philippe Gerum wrote:
> On Tue, 2009-04-28 at 15:45 +0200, Gilles Chanteperdrix wrote:
> > > We don't care that much about changing the ABI between -rc1 and -rc2
> > > actually, so it mostly depends whether we want to backport the fix to
> > > 2.4 regarding the tsc->ns conversion, since we do not have any nodiv
> > > implementation for the ns->tsc one there yet.
> > 
> > But we have llmulshft, do we ? which means that we do have the problem
> > of approximate cpu frequency.
> > 
>  
> So I guess your answer to the "should backport" question is yes, we
> should. Ok, so we do have to run xnarch_init_u32frac and friends from
> userland. I will try to find a better excuse for procrastinating then...
> 

Thanx for the effort 

Just for info, i tested adeos patch 2.6.28.9-x86-2.2-07 with Xenomai
2.4.7 with regards the timing (as described in the thread "adeos patch
2.6.28.9-x86-2.2-07 feedback" on the xenomai-help mailing list)

I compared those results with the ones i obtained from
adeos-ipipe-2.6.24-x86-2.0-07.patch with Xenomai 2.4.5.

My testing with Xenomai 2.5 rc1 was just to boot and see if the lockup
problem was still present. Would you would like me to do the latency
tests with Xenomai 2.5 rc1 ?

Keep well
Vicki





