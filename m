From: Paul <paul_c@domain.hid>
Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
Date: Fri, 2 Feb 2007 14:55:51 +0000
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170426719.4981.66.camel@domain.hid> <45C34DEE.2020101@domain.hid>
In-Reply-To: <45C34DEE.2020101@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200702021455.51991.paul_c@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Friday 02 February 2007 14:42, Jan Kiszka wrote:
> >> =A0Tested on K8 x86_64 SMP and K8 x86 UP : SMP system leaks memory, UP
> >> doesn't.

> Must be .config-dependent. My UP box (.config attached) doesn't expose
> any leak on /proc/interrupt loops with 2.6.19.2.

x86_64 SMP on 2.6.19.2 doesn't appear to leak here either. Perhap=20
http://lkml.org/lkml/2006/12/26/112 might have been a contributary fix..


Regards, Paul.


