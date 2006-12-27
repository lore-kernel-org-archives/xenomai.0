Subject: Re: [Xenomai-help] Re: A fairly small rtnet/Xenomai...
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45923BEE.6020302@domain.hid>
References: <1166786437.4960.180.camel@domain.hid>
	<458BB057.9090009@domain.hid> <458ACFDA.8070300@domain.hid>
	<25528819.1166701882755.JavaMail.ngmail@domain.hid>
	<13574091.1166708188484.JavaMail.ngmail@domain.hid>
	<1166710393.4960.13.camel@domain.hid>
	<12420573.1166713240349.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210717u4b8f0505m65d01bc2824a144a@domain.hid>
	<8403506.1166715370788.JavaMail.ngmail@domain.hid>
	<b647ffbd0612210743m2b208cb2w6e9054336fd68028@domain.hid>
	<9212697.1166778373331.JavaMail.ngmail@domain.hid>
	<458BA432.2000205@domain.hid>
	<b647ffbd0612220140m504db8e4x52ca45477e425d44@domain.hid>
	<9386881.1166783234553.JavaMail.ngmail@domain.hid>
	<28348634.1166787644219.JavaMail.ngmail@domain.hid>
	<45923BEE.6020302@domain.hid>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 11:44:47 +0100
Message-Id: <1167216287.31795.18.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, 2006-12-27 at 10:25 +0100, Gilles Chanteperdrix wrote:
> M. Koehrer wrote:
> > Hi Philippe, 
> > 
> > I agree. To fix the root cause is actually the very best to do!
> > This eases the life of users and developers.
> > 
> > Regards
> > 
> > Mathias
> 
> Hi Mathias,
> 
> here comes a workaround for the COW issue on Linux 2.6.19. The patch
> relies on a new VM_NOCOW flag which should be set for real-time
> application if you use Xenomai trunk.
> 
> It would be nice if you could test it.
> 

You will additionally need to apply this patch to the Xenomai tree in
order to activate the COW-disable feature:

--- ksrc/nucleus/shadow.c.orig	2006-12-27 11:42:50.000000000 +0100
+++ ksrc/nucleus/shadow.c	2006-12-27 11:42:55.000000000 +0100
@@ -839,6 +839,8 @@
 #ifdef CONFIG_MMU
 	if (!(current->mm->def_flags & VM_LOCKED))
 		send_sig(SIGXCPU, current, 1);
+	else
+	    current->mm->def_flags |= VM_NOCOW;
 #endif /* CONFIG_MMU */
 
 	current->cap_effective |=

-- 

Philippe.



