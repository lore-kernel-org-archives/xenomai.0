Message-ID: <4DC990BF.8040102@domain.hid>
Date: Tue, 10 May 2011 21:23:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <201105101823.50226.lux-integ@domain.hid>
In-Reply-To: <201105101823.50226.lux-integ@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: luxInteg <lux-integ@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 05/10/2011 07:23 PM, luxInteg wrote:
> greetings
> 
> I normally  compile stuff as an ordinary user,  but   I noticed in this area   
> people often compile as root as  kernel  modules are involved.   I note 
> xenomai can be compiled either as user or root so  is there a preferred way ?

As others have said, compile as ordinary user, run make install or make
modules_install as root, or run "sudo make install". Another reason for
running "make install" as root, is that root privilege is also required
to create the device nodes (/dev/rtheap, /dev/rtp*) needed by Xenomai
applications.

-- 
                                                                Gilles.

