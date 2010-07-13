From: jmf <xeno.nonono@domain.hid>
Date: Tue, 13 Jul 2010 22:49:55 +0000 (UTC)
Message-ID: <loom.20100714T004823-633@domain.hid>
References: <001b01cb1e9c$54ddbae0$fe9930a0$@com>	<4C35CC27.1000407@domain.hid>
	<loom.20100713T211010-119@domain.hid>
	<4C3CD1AF.8080204@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help]
	=?utf-8?q?fatal=3A_error_xeno=5Fnucleus_not_found?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:

> 
> jmf wrote:
> > Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:
> > 
> >> Gilson Bellon wrote:
> >>>
> >>> Dear all,
> >>
> > 
> > I've got exactly the same situation!
> > Followed this for setup: http://www.xenomai.org/index.php/...
> > 
> > In /usr/share/xenomai/testsuite/ there's:
> > clocktest  cyclic  irqbench  klatency  latency  sigtest  switchtest  unit
> > 
> > 
> > $ bash xeno-test (/usr/bin/xeno-test)
> > 
> > part of the output:
> > 
> > Is this just a question of invalid filepaths?
> 
> As I already said (it is the fourth time I tell it in this thread
> actually), the "run" script seem not to work any longer. We are going to
> fix them. But in the mean time, simply run the binaries directly.
> 
> Now, if my explanation is not clear, simply tell me instead of repeating
> the question over and over again.
> 

When I googled the error message, the *only* thing that came up was
the thread started by Gilson Bellon which ended with your unanswered
question what command he ran. So I thought I'd answer for him.
No idea where your previous three answers to this could be found in
this thread.

Anyway, thanks. So I take it as this is no sign for an incomplete setup
and we shall just run the tools cyclictest/switchtest/latency manually.
If that's wrong, then your explanation is not clear to me.


