From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: AW: [Xenomai-help] prepare kernel fails
Date: Wed, 20 Dec 2006 21:09:33 +0100
References: <5D63919D95F87E4D9D34FF7748CE2C2A6F92C7@domain.hid>
	<45897603.5070703@domain.hid> <45897750.6000905@domain.hid>
In-Reply-To: <45897750.6000905@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612202109.34082.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Am Mittwoch, 20. Dezember 2006 18:48 schrieb Gilles Chanteperdrix:
> Jan Kiszka wrote:
> > (Gilles?) has to run bootstrap
>
> Done.
Thanks. 

If would simplify setting up the buildbot if I could run "make distcheck" 
without a need to use sudo.

Calling "make SUDO= distcheck" resulted in errors like:
make[3]: Nothing to be done for `install-data-am'.
mknod: `/tmp/am-dc-17903//dev/rtp0': Operation not permitted

If you need too much time, I will just modify my sudoers to add another
script (to the scripts able to use sudo without passwords). But I would 
prefert to be able to go the other way.

Niklaus

