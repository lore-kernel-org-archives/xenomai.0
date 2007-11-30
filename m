Message-ID: <2ff1a98a0711300903u4908ed6t81009f0684824e90@domain.hid>
Date: Fri, 30 Nov 2007 18:03:52 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47503D54.3030005@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <18252.31008.17258.994903@domain.hid>
	<BF58A8AFB316514587D61EADBFBF4C410165FD36@domain.hid>
	<18252.34775.863059.743025@domain.hid>
	<47503D54.3030005@domain.hid>
Subject: Re: [Xenomai-help] Interrupts lost during sleep / unblock cycles
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

On Nov 30, 2007 5:41 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
> > Usually, a Xenomai version is compatible with past I-pipe releases. But
> > you should expect problems using a new I-pipe release with an older
> > version of Xenomai.
> >
>
> To be more specific about this: we try really, really, really, awfully
> and painfully hard to keep recent I-pipe patches compatible with
> (reasonably) older Xenomai releases. No kidding. You may have noticed
> that the I-pipe API has been quite stable over time for that particular
> reason, and when we have to break it, there is most often some built-in
> compat code.

Then, I really have a problem with the newer ARM I-pipe patches, the
ones that no longer shut irqs over the mm switch, because they will
probably compile with a Xenomai 2.2.x, but will not work properly.

The only way I see to work around this is to make the ARM patch depend
on a CONFIG_ symbol which would be set by the newer Xenomai.

-- 
                                               Gilles Chanteperdrix

