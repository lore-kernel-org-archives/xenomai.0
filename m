Subject: Re: [Adeos-main] ADEOS on MIPS
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20060901085123.15970.qmail@domain.hid>
References: <20060901085123.15970.qmail@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 11:09:06 +0200
Message-Id: <1157101746.4322.44.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: somshekar kadam <som_kadam@domain.hid>
Cc: adeos-main@gna.org

On Fri, 2006-09-01 at 09:51 +0100, somshekar kadam wrote:
> Hi All, 
> 
> I am newbie to ADEOS, 
> we would like to know if ADOES is supported on ADOES.
> when I checked on your release , I dont find MIPS arch
> supported. 
> well we would like to port ADOES for MIPS. 
> I hope I will get Help and right pointers from you all
> People.
> To Begin with We are going to port ADOES to MIPS 4kE
> processor.
> I would like to know what goes in to porting of ADOES
> to new Architecture is where should i Begin
> It will be Big time to get it working , but with our
> support i dont feel it will be problem from me
> Thanks And Regards
> Neelu 
> 

This document is a bit outdated, but the gist of it still applies:
http://download.gna.org/adeos/doc/porting.txt

Adeos has already been ported to quite different archs, this should give
you some useful insights:
http://download.gna.org/adeos/patches/v2.6/

Depending on the complexity of the target interrupt sub-system, and how
familiar you are with it, the initial porting effort should be a matter
of 1-4 weeks.

> Thanks
> 
> 
> 
> 		
> __________________________________________________________
> Yahoo! India Answers: Share what you know. Learn something new
> http://in.answers.yahoo.com/
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



