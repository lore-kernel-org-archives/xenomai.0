MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5
Content-Transfer-Encoding: 7bit
Message-ID: <17917.33694.978519.801152@domain.hid>
Date: Sun, 18 Mar 2007 19:23:26 +0100
Subject: Re: [Xenomai-help] mem usage and other application
In-Reply-To: <45FD7860.5030308@domain.hid>
References: <17913.899.384216.185459@domain.hid>
	<45F90DC1.2030009@domain.hid> <45F97587.9020604@domain.hid>
	<17917.29803.267170.622970@domain.hid>
	<45FD7860.5030308@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Maksym Veremeyenko <verem@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Maksym Veremeyenko wrote:
 > Gilles Chanteperdrix ~~~~~:
 > 
 > >  >        1. Kernel 2.6.17.14, Xenomai 2.3.0... r2299, Adeos 1.5-02
 > > Here, I assume you mean Xenomai branch v2.3.x revision 2299
 > release 2.3.0 and branch v2.3.x revision 2299 - both
 > 
 > >  >        2. Kernel 2.6.19.2, Xenomai r2299, Adeos 1.7-01
 > > Here, I assume you mean Xenomai trunk revision 2299
 > yes
 > 
 > > The problem is that if there is no difference with regard to FPU context
 > > management between release 2.3.0 and latest revision of branch
 > > v2.3.x. So, the difference must be somewhere else.
 > What is recommended configuration and version of kernel and Xenomai?
 > In my case
 > 2.6.20.3 upgrade failed due to Xenomai compilation,
 > 2.6.19 fault gdb to work properly,
 > 2.6.18 fail due to absent adeos-ipipe version.
 > I have to use 2.6.17.14 .....

As far as I understood, Adeos version does not matter for your bug,
what matters is xenomai revision. So, during your tests, you should keep
the same Adeos version and only change Xenomai version. 

However, if you have difficulties with some versions of Adeos, you
should report the errors here. We are interested in getting them
solved.

 > 
 > > Could you send me your .config ?
 > attached

I see that you you have selected the K7 processor. Be sure to use an
Adeos version greater than 1.5-02, or select a processor that does not
support 3DNow (I think K6 should do).

 > 
 > 
 > > Also, is it possible for you to try bisecting in v2.3.x branch ? v2.3.0
 > > release is revision 2004, and you know that revision 2299 does not work
 > > for you, so you would be able to tell us exactly which revision is the
 > > cause of your problem.
 > What trunk revisions should be tried?

If revision 2299 of branch v2.3.x fails, you should stay in branch
v2.3.x. Try revision 2150, if it fails, try revision 2075, if revision
2150 works, try revision 2225, etc... Do not forget to rebuild kernel
and reboot between tests. And tell us when you have found that revision
n works and revision n+1 does not work.

-- 


					    Gilles Chanteperdrix.

