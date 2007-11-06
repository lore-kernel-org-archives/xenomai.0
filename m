Message-ID: <f48df4840711060101w4f444247rcfd574e78b29425d@domain.hid>
Date: Tue, 6 Nov 2007 10:01:00 +0100
From: "Bruno Rouchouse" <brouchouse@domain.hid>
In-Reply-To: <18224.10799.628508.676548@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_31070_1411861.1194339660920"
References: <C46506B0-FC87-46CE-9FEE-F6E031CB95C9@domain.hid>
	<2ff1a98a0711050704s51a976cp96257f2712bd15ff@domain.hid>
	<f48df4840711050730t4309e500p715314c77caa28bb@domain.hid>
	<2ff1a98a0711050749n4237a818p5838896f84dc9dc8@domain.hid>
	<2ff1a98a0711051123l1348ed85se7a46ab420276346@domain.hid>
	<18224.10799.628508.676548@domain.hid>
Subject: Re: [Xenomai-core] About Xenomai test framework and publishing
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_31070_1411861.1194339660920
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles,

I did manage to start the script and get everything downloaded but nothing
got compiled indeed.

I'll try again tonight with your updated version.

Thanks.

--Bruno

2007/11/6, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> Gilles Chanteperdrix wrote:
> > On 11/5/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> > > On 11/5/07, Bruno Rouchouse <brouchouse@domain.hid> wrote:
> > > > Hi Gilles,
> > > >
> > > > yes please, if you can send me your script, it would be great.
> > > >
> > > > TIA.
> > >
> > > Here comes a tarball with the script (called bx/bin/bx2.sh) and an
> > > example configuration which you can untar in your home directory.
> > > Please be careful, do not mix the directories used by the script with
> > > other directories of yours since the script routinely removes the
> > > useless files (in order to avoid using too much space if you use it
> > > every night).
> >
> > I am trying to run this script, so a few words of advice:
> > - the script parse the output of a few commands, so will not work
> > properly if your linux is non-english. Add export LANG=C at the
> > beginning of the script to avoid this issue;
> > - you will need gpg properly installed and configured with kernel.org
> > signature imported for the script to verify kernel.org archives
> > signatures. Once gpg is configured, importing kernel.org signature is
> > easy:
> > gpg --keyserver wwwkeys.pgp.net --recv-keys 0x517D0F0E
> > - the script will spend a lot of time downloading kernel archives and
> > patches when you run it, do not worry, this will happen only once.
>
> Ok. The script needed some changes to work anew.
> New version here:
> http://sisyphus.hd.free.fr/~gilles/bx.tar.bz2
>
> The scripts result, when run with the example configuration can be found
> here:
> http://sisyphus.hd.free.fr/~gilles/bx
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_31070_1411861.1194339660920
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Gilles,<br><br>I did manage to start the script and get everything downloaded but nothing got compiled indeed.<br><br>I&#39;ll try again tonight with your updated version.<br><br>Thanks.<br><br>--Bruno<br><br><div><span class="gmail_quote">
2007/11/6, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Gilles Chanteperdrix wrote:<br> &gt; On 11/5/07, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:<br> &gt; &gt; On 11/5/07, Bruno Rouchouse &lt;<a href="mailto:brouchouse@domain.hid">
brouchouse@domain.hid</a>&gt; wrote:<br> &gt; &gt; &gt; Hi Gilles,<br> &gt; &gt; &gt;<br> &gt; &gt; &gt; yes please, if you can send me your script, it would be great.<br> &gt; &gt; &gt;<br> &gt; &gt; &gt; TIA.<br> &gt; &gt;
<br> &gt; &gt; Here comes a tarball with the script (called bx/bin/bx2.sh) and an<br> &gt; &gt; example configuration which you can untar in your home directory.<br> &gt; &gt; Please be careful, do not mix the directories used by the script with
<br> &gt; &gt; other directories of yours since the script routinely removes the<br> &gt; &gt; useless files (in order to avoid using too much space if you use it<br> &gt; &gt; every night).<br> &gt;<br> &gt; I am trying to run this script, so a few words of advice:
<br> &gt; - the script parse the output of a few commands, so will not work<br> &gt; properly if your linux is non-english. Add export LANG=C at the<br> &gt; beginning of the script to avoid this issue;<br> &gt; - you will need gpg properly installed and configured with 
<a href="http://kernel.org">kernel.org</a><br> &gt; signature imported for the script to verify <a href="http://kernel.org">kernel.org</a> archives<br> &gt; signatures. Once gpg is configured, importing <a href="http://kernel.org">
kernel.org</a> signature is<br> &gt; easy:<br> &gt; gpg --keyserver <a href="http://wwwkeys.pgp.net">wwwkeys.pgp.net</a> --recv-keys 0x517D0F0E<br> &gt; - the script will spend a lot of time downloading kernel archives and
<br> &gt; patches when you run it, do not worry, this will happen only once.<br><br>Ok. The script needed some changes to work anew.<br>New version here:<br><a href="http://sisyphus.hd.free.fr/~gilles/bx.tar.bz2">http://sisyphus.hd.free.fr/~gilles/bx.tar.bz2
</a><br><br>The scripts result, when run with the example configuration can be found<br>here:<br><a href="http://sisyphus.hd.free.fr/~gilles/bx">http://sisyphus.hd.free.fr/~gilles/bx</a><br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.
<br></blockquote></div><br>

------=_Part_31070_1411861.1194339660920--

