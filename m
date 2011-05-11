From: luxInteg <lux-integ@domain.hid>
Date: Wed, 11 May 2011 16:31:00 +0100
References: <201105101823.50226.lux-integ@domain.hid>
	<4DC990BF.8040102@domain.hid>
In-Reply-To: <4DC990BF.8040102@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201105111631.00882.lux-integ@domain.hid>
Subject: Re: [Xenomai-help] preferred  uid?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

On Tuesday 10 May 2011 20:23:43 Gilles Chanteperdrix wrote:
> On 05/10/2011 07:23 PM, luxInteg wrote:
> > greetings
> > 
> > I normally  compile stuff as an ordinary user,  but   I noticed in this
> > area people often compile as root as  kernel  modules are involved.   I
> > note xenomai can be compiled either as user or root so  is there a
> > preferred way ?
> 
> As others have said, compile as ordinary user, run make install or make
> modules_install as root, or run "sudo make install". Another reason for
> running "make install" as root, is that root privilege is also required
> to create the device nodes (/dev/rtheap, /dev/rtp*) needed by Xenomai
> applications.

yes this is my rule of thumb  too

However   as I read through the install file  in the xenomai tarball   I 
noticed  there  was only reference   to 'make install' (at least on x86 
platforms).  i did this   and did not bother with running make.  Is this 
acceptable?

sincerely
luxInteg

