From: Paul <paul_c@domain.hid>
Date: Fri, 12 Aug 2011 15:06:46 +0100
References: <CAMQsbyZMRUKaSnNREKjxHuJqop7LPH8Wdmty_inEMGCLRJxJHw@domain.hid>
In-Reply-To: <CAMQsbyZMRUKaSnNREKjxHuJqop7LPH8Wdmty_inEMGCLRJxJHw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201108121506.46741.paul_c@domain.hid>
Subject: Re: [Xenomai-help] Cross-compilation of debian package of linux
	patched kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Friday 12 August 2011, alexandre tuleu wrote:
> I'm sure I made some beginner's mistake here. Does anyone have any
> idea of what I would have done wrong. Or the idea to cross-compile
> form amd64 to i386 while generating debian packages is just a really
> bad one ? My target system is very limited in disk size and
> ressource, so its rather hard to cross-compile on it.

A little outside the scope for xenomai-help, but I'd suggest looking at 
the pbuilder and pdebuilder-cross packages - These tools set up a 
chroot jail where you can compile packages with relative ease.

Another alternative would be buildroot, but if you really *have* to have 
deb packages, probably not the answer.


Regards, Paul.



