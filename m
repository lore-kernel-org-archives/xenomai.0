From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B882134.8090001@domain.hid>
References: <1e62d1371002261025t6c65ed03s726ab070d9b25ace@domain.hid>
	<4B882134.8090001@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Feb 2010 23:47:41 +0100
Message-ID: <1267224461.3405.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Hello,
 A really dumb/newbie question ! (Is FPU supported on Blackfin
 (in	kernel) ? )
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2010-02-26 at 20:29 +0100, Gilles Chanteperdrix wrote:
> Fawad Lateef wrote:
> > Hello,
> > 
> > I am working on porting x86 RTAI based application/kernel-modules to
> > Xenomai for Blackfin (BF537). We are using RTAI's FPU and I want to
> > ask: Do Xenomai support FPU operations on Blackfin platform (in
> > kernel) ?
> 
> I am no blackfin expert, but from the code, I am afraid not. But it
> seems Linux does not support Blackfin FPU either. And in fact, blackfins
> have no FPU.
> 

Confirmed.


-- 
Philippe.



