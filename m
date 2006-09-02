Message-ID: <20060902103919.21905.qmail@domain.hid>
Date: Sat, 2 Sep 2006 11:39:19 +0100 (BST)
From: somshekar kadam <som_kadam@domain.hid>
Subject: Re: [Adeos-main] ADEOS on MIPS
In-Reply-To: <1157101746.4322.44.camel@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

Hi Philippe Gerum,

   what I see on net is release of ADOES patches like
adeos-ipipe-2.6.13-i386-1.0-05
for linux-2.6.13 kernel version. 

also I see RTAI version rtai-3.3-test3
which includes ADOES support builtin with rtai for
linux kernel verison linux-2.6.13 


which I should use as our aim is to run rtai on ADOES
on mips 4k. 
so which I should port is it RTAI.3.3 or only the
ADOES patch.

First I need to port ADOES ,so which of the above I
should use. one with that comes with RTAI or the
individual patch for ADEOS that one. 

please dont mind it may be a silly question to begin
with. 

Thanks And Regards
Neelu 





--- Philippe Gerum <rpm@xenomai.org> wrote:

> On Fri, 2006-09-01 at 09:51 +0100, somshekar kadam
> wrote:
> > Hi All, 
> > 
> > I am newbie to ADEOS, 
> > we would like to know if ADOES is supported on
> ADOES.
> > when I checked on your release , I dont find MIPS
> arch
> > supported. 
> > well we would like to port ADOES for MIPS. 
> > I hope I will get Help and right pointers from you
> all
> > People.
> > To Begin with We are going to port ADOES to MIPS
> 4kE
> > processor.
> > I would like to know what goes in to porting of
> ADOES
> > to new Architecture is where should i Begin
> > It will be Big time to get it working , but with
> our
> > support i dont feel it will be problem from me
> > Thanks And Regards
> > Neelu 
> > 
> 
> This document is a bit outdated, but the gist of it
> still applies:
> http://download.gna.org/adeos/doc/porting.txt
> 
> Adeos has already been ported to quite different
> archs, this should give
> you some useful insights:
> http://download.gna.org/adeos/patches/v2.6/
> 
> Depending on the complexity of the target interrupt
> sub-system, and how
> familiar you are with it, the initial porting effort
> should be a matter
> of 1-4 weeks.
> 
> > Thanks
> > 
> > 
> > 
> > 		
> >
>
__________________________________________________________
> > Yahoo! India Answers: Share what you know. Learn
> something new
> > http://in.answers.yahoo.com/
> > 
> > _______________________________________________
> > Adeos-main mailing list
> > Adeos-main@domain.hid
> > https://mail.gna.org/listinfo/adeos-main
> -- 
> Philippe.
> 
> 
> 



		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/

