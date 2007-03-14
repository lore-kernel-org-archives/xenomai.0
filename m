Subject: Re: Re: [Xenomai-help] Howto catch SEGV signals in Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <21950566.1173862047952.JavaMail.ngmail@domain.hid>
References: <22180008.1173860253238.JavaMail.ngmail@domain.hid>
	<1173825460.16997.107.camel@domain.hid>
	<11906791.1173797505269.JavaMail.ngmail@domain.hid>
	<45F6C278.4040709@domain.hid> <1173801179.16997.56.camel@domain.hid>
	<17910.63947.624116.867944@domain.hid>
	<1173825266.16997.105.camel@domain.hid>
	<21950566.1173862047952.JavaMail.ngmail@domain.hid>
Content-Type: text/plain; charset="utf-8"
Date: Wed, 14 Mar 2007 11:35:00 +0100
Message-Id: <1173868500.32259.10.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-03-14 at 09:47 +0100, M. Koehrer wrote:
> Hi all,
> 
> one additional thing I found out:
> I used the Xenomai SVN version not on a 2.6.20.2 but on the 2.6.19.2 kernel.
> And here I had the freeze again. 
> As I have written in my previous mail, it worked fine with 2.6.20.2
> It seems as if kernel 2.6.19.2 is causing the trouble...

Could you confirm that, Adeos-wise, you tried both 2.6.19-1.6-03 (not
working) and 2.6.20-1.7-02 (working)? if so, does 2.6.19-1.7-02 (or -03)
also work in your configuration?

> No idea why...
> For me it is fine to switch over to 2.6.20, however I'd like to use a "stable" version
> of Xenomai for it.
> Is there a schedule for the next "stable" xenomai version that supports 2.6.20?
> 

2.3.1 is scheduled on 3/19.

> Thanks for all support!
> 
> Regards
> 
> Mathias
> > thanks for all the feedback on that issue.
> > Since yesterday I did a couple of tests on kernel 2.6.19.2
> > 1. I used the adeos patch provided with xenomai-2.3.0 
> > SMP mode => freeze with my program. I have enclosed the kernel config for
> > this one
> > UP mode => freeze with my program
> > 
> > 2. I added the patch from Philippe (the second one):
> > 
> > --- ksrc/nucleus/pod.c		 (revision 2293)
> > +++ ksrc/nucleus/pod.c		 (working copy)
> > @@ -1420,6 +1420,11 @@
> >  		 		    the KICKED bit set, so that xnshadow_relax() is never
> >  		 		    prevented from blocking the current thread. */
> >  		 		 if (xnthread_test_info(thread, XNKICKED)) {
> > +		 		 		 XENO_ASSERT(NUCLEUS, (mask & XNRELAX) == 0,
> > +		 		 		 		     xnpod_fatal("Relaxing a kicked thread"
> > +		 		 		 		 		 		 "(thread=%s, mask=%lx)?!",
> > +		 		 		 		 		 		 thread->name, mask);
> > +		 		 		 		 );
> >  		 		 		 xnthread_clear_info(thread, XNRMID | XNTIMEO);
> >  		 		 		 xnthread_set_info(thread, XNBREAK);
> >  		 		 		 goto unlock_and_exit;
> > 
> > I used this patch on the UP kernel 2.6.19.2. Same adeos version as before.
> > The result  was the same => PC freeze
> > 
> > 3. I tried kernel 2.6.20.2 and the same (SMP) configuration as with
> > 2.6.19.2
> > I used the Xenomai subversion #2292 and the adeos patch that is in
> > subversion
> > (adeos-ipipe-2.6.20-i386-1.7-02.patch).
> > And with that combination it is working! I get the expected "Segmentation
> > fault" message.
> > I don't know why, but it seems to be working!
> > 
> > I will try to use the same Xenomai svn version on the 2.6.19.2 to see if
> > this is a 2.6.19 issue...
> > 
> > Regards
> > 
> > Mathias
> > 
> > 
> > 
> > 
> > -- 
> > Mathias Koehrer
> > mathias_koehrer@domain.hid
> > 
> > 
> > Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
> > ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: günstig
> > und schnell mit DSL - das All-Inclusive-Paket für clevere Doppel-Sparer,
> > nur  39,85 €  inkl. DSL- und ISDN-Grundgebühr!
> > http://www.arcor.de/rd/emf-dsl-2
> 
-- 
Philippe.



