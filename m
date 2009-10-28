Message-ID: <4AE84AED.20108@domain.hid>
Date: Wed, 28 Oct 2009 14:45:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <200910281314.00378.leo@domain.hid>
In-Reply-To: <200910281314.00378.leo@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai patches
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Leopold Palomo-Avellaneda <leo@domain.hid>
Cc: xenomai@xenomai.org

Leopold Palomo-Avellaneda wrote:
> Hi,
> 
> I'm having a trouble installing xenomai in a debian machines. Actually the 
> official debian package is not useful. You cannot use it because there's no 
> kernel package that could be patched.

The debian packages are not maintained by the Xenomai project. So, if
you are having problems with these, please contact Roland Stigge. You
will probably find his e-mail address in /usr/share/doc/*xenomai, but
the e-mail address he used the last time he posted on the xenomai
mailing lists is:
stigge@domain.hid


> Anyway, I would like to ask about if, for example, a patch against a 2.6.30 
> could be used against 2.6.30.4 for example or reverse.

Usually, I-pipe patches are for the base release, but work with later
releases. When it happens that there is a conflict, and we find out
about it, we release another I-pipe patch e.g for 2.6.30.4. In that
case, you need to use the I-pipe patch for 2.6.30.4 for 2.6.30.4 and later.


> I don't understand why
> this four numbers instead of the classical 3. Or, how can I modify it to use 
> it.

These are releases from the stable branch:
http://kernelnewbies.org/FAQ/VariousKernelTrees

-- 
                                          Gilles


