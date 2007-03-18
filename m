MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5
Content-Transfer-Encoding: 7bit
Message-ID: <17917.29803.267170.622970@domain.hid>
Date: Sun, 18 Mar 2007 18:18:35 +0100
Subject: Re: [Xenomai-help] mem usage and other application
In-Reply-To: <45F97587.9020604@domain.hid>
References: <17913.899.384216.185459@domain.hid>
	<45F90DC1.2030009@domain.hid> <45F97587.9020604@domain.hid>
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
 > > Why changing the RAM size ? 
 > i added RAM before to check if it could help running other non-RT 
 > application.
 > 
 > > Could you double-check with your RAM size
 > > normally set ? Do you observe the "Bad pte" message with latency or
 > > switchbench running, or with your RT application ?
 > 
 > I started 'latency' and then start any perl script. It behavior depends 
 > on configurations:
 >      Problematic configuration are:
 >        1. Kernel 2.6.17.14, Xenomai 2.3.0... r2299, Adeos 1.5-02
Here, I assume you mean Xenomai branch v2.3.x revision 2299

 >        2. Kernel 2.6.19.2, Xenomai r2299, Adeos 1.7-01
Here, I assume you mean Xenomai trunk revision 2299

The problem is that if there is no difference with regard to FPU context
management between release 2.3.0 and latest revision of branch
v2.3.x. So, the difference must be somewhere else.

Could you send me your .config ?

Also, is it possible for you to try bisecting in v2.3.x branch ? v2.3.0
release is revision 2004, and you know that revision 2299 does not work
for you, so you would be able to tell us exactly which revision is the
cause of your problem.

-- 


					    Gilles Chanteperdrix.

