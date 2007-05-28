From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <465A9AD6.7040008@domain.hid>
References: <7289437c0705280043o7b8eaf85hbbfad33b95c243fb@domain.hid>
	<1180342178.6188.37.camel@domain.hid>  <465A9AD6.7040008@domain.hid>
Content-Type: text/plain
Date: Mon, 28 May 2007 11:12:13 +0200
Message-Id: <1180343533.6188.40.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
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

On Mon, 2007-05-28 at 11:03 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2007-05-28 at 09:43 +0200, Perrine Martignoni wrote:
> >> And after when I want to compile a code with API Posix, the error
> >>is : 
> >>API Posix not available
> >> 
> > 
> > 
> > Xenomai does not output such messsage. Is this verbatim?
> > 
> 
> I thik this message comes from xeno-config when it can not find
> posix.wrappers. But it is normal that xeno-config does not find
> posix.wrappers if installation failed.
> 

Ok, so this is "POSIX support is not available" we should grep then, I
guess. Indeed, the installation seems to be toast.

-- 
Philippe.



