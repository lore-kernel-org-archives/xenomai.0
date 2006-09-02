Message-ID: <20060902114708.45716.qmail@domain.hid>
Date: Sat, 2 Sep 2006 12:47:08 +0100 (BST)
From: somshekar kadam <som_kadam@domain.hid>
Subject: Re: [Adeos-main] ADEOS on MIPS
In-Reply-To: <1157197075.4967.66.camel@domain.hid>
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

Hi Philipe Gerum,

Thanks A lot for Quick Response,

we are more intrested onto porting ADEOS on our MIPS
platform for mips4ke, if it disables core ADEOS
functionality, we stick only to ADOES release.

Getting RTAI run on it is not requrement, basicall we
need ADEOS on MIPS4k, 

I think I go ahead ADOES patches and source for
porting it to MIPS. 

I hope I done the correct decision, as I see no point
going to RTAI if it disables core ADEOS . 
please comment on this. 
And we are happy to have your support 

Thanks And Regards
Neelu 



--- Philippe Gerum <rpm@xenomai.org> wrote:

> On Sat, 2006-09-02 at 11:39 +0100, somshekar kadam
> wrote:
> > Hi Philippe Gerum,
> > 
> >    what I see on net is release of ADOES patches
> like
> > adeos-ipipe-2.6.13-i386-1.0-05
> > for linux-2.6.13 kernel version. 
> > 
> 
> The official source for patches contributed by the
> Adeos project is
> http://download.gna.org/adeos/patches/
> 
> where you can find Adeos/I-pipe versions up to
> 2.6.17, depending on the
> target architecture.
> 
> > also I see RTAI version rtai-3.3-test3
> > which includes ADOES support builtin with rtai for
> > linux kernel verison linux-2.6.13 
> > 
> 
> Please ask the RTAI people for help, since they
> provide their own
> interrupt virtualization patches since v3.2 or so.
> AFAICS, some of these
> patches completely disable the core Adeos code by
> inserting
> RTAI-specific sideways, other patches only enable
> part of the Adeos
> code, and so on. Your best option to understand
> what's going on into the
> RTAI implementation is to get information from the
> RTAI folks directly.
> 
> > 
> > which I should use as our aim is to run rtai on
> ADOES
> > on mips 4k. 
> > so which I should port is it RTAI.3.3 or only the
> > ADOES patch.
> > 
> > First I need to port ADOES ,so which of the above
> I
> > should use. one with that comes with RTAI or the
> > individual patch for ADEOS that one. 
> > 
> 
> Really, I can't help, because it's neither an Adeos
> or Xenomai issue,
> and I do not follow RTAI's development anymore: 
>
https://mail.rtai.org/pipermail/rtai/2005-October/013155.html
> 
> > please dont mind it may be a silly question to
> begin
> > with. 
> 
> > Thanks And Regards
> > Neelu 
> > 
> > 
> > 
> > 
> > 
> > --- Philippe Gerum <rpm@xenomai.org> wrote:
> > 
> > > On Fri, 2006-09-01 at 09:51 +0100, somshekar
> kadam
> > > wrote:
> > > > Hi All, 
> > > > 
> > > > I am newbie to ADEOS, 
> > > > we would like to know if ADOES is supported on
> > > ADOES.
> > > > when I checked on your release , I dont find
> MIPS
> > > arch
> > > > supported. 
> > > > well we would like to port ADOES for MIPS. 
> > > > I hope I will get Help and right pointers from
> you
> > > all
> > > > People.
> > > > To Begin with We are going to port ADOES to
> MIPS
> > > 4kE
> > > > processor.
> > > > I would like to know what goes in to porting
> of
> > > ADOES
> > > > to new Architecture is where should i Begin
> > > > It will be Big time to get it working , but
> with
> > > our
> > > > support i dont feel it will be problem from me
> > > > Thanks And Regards
> > > > Neelu 
> > > > 
> > > 
> > > This document is a bit outdated, but the gist of
> it
> > > still applies:
> > > http://download.gna.org/adeos/doc/porting.txt
> > > 
> > > Adeos has already been ported to quite different
> > > archs, this should give
> > > you some useful insights:
> > > http://download.gna.org/adeos/patches/v2.6/
> > > 
> > > Depending on the complexity of the target
> interrupt
> > > sub-system, and how
> > > familiar you are with it, the initial porting
> effort
> > > should be a matter
> > > of 1-4 weeks.
> > > 
> > > > Thanks
> > > > 
> > > > 
> > > > 
> > > > 		
> > > >
> > >
> >
>
__________________________________________________________
> > > > Yahoo! India Answers: Share what you know.
> Learn
> > > something new
> > > > http://in.answers.yahoo.com/
> > > > 
> > > >
> _______________________________________________
> > > > Adeos-main mailing list
> > > > Adeos-main@domain.hid
> > > > https://mail.gna.org/listinfo/adeos-main
> > > -- 
> > > Philippe.
> > > 
> > > 
> > > 
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

