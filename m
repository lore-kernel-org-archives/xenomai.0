Date: Thu, 28 Sep 2006 15:57:55 +0200
Message-Id: <J6B2SJ$418ED72ADEDCBCAD1EED3E97DFDC669A@laposte.net>
Subject: Re: [Xenomai-help] Re: Proper module_cleanup procedure
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
From: "gilles\.chanteperdrix" <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rsmith <rsmith@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

---------- Debut du message initial -----------

De     : xenomai-help-bounces@domain.hid
A      : xenomai@xenomai.org
Copies : 
Date   : Thu, 28 Sep 2006 09:09:36 -0400
Objet  : Re: [Xenomai-help] Re: Proper module_cleanup procedure

> Thanks for all of your help and just a quick follow up on this.
> 
> I added a call to rt_task_delete() in my module cleanup
routine and this 
> cleared the memory error I was getting whenever I tried to
unload the 
> module and then load it again.
> 
> I am still trying to discover some mechanism by which the
kernel module 
> can determine if a particular heap is in use by a user-mode
app without 
> having coordinating code in the user app. Don't want to jerk
the rug out 
> from under the user app by deleting the heap before the user
app is 
> finished with it.

If you are already in the module cleanup function, what are
you going
to do if you detect that a user-mode application is using the
module ?
You can not have the module cleanup function fail, it is too
late. So,
my advice is to lock the module with try_module_get as long as
the heap
are being used by user-space. Of course, this require calling
some ioctl
in user-space, but it looks like a small price to pay.

-- 
                 Gilles Chanteperdrix
=0A=0AAcc=E9dez au courrier =E9lectronique de La Poste 
sur www.laposte.net ou sur 3615 LAPOSTENET (0,34=80 TTC /mn) 
1 Giga de stockage gratuit =96 Antispam et antivirus int=E9gr=E9s 
=0A


