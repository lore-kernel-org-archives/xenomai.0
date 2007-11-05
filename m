Message-ID: <2ff1a98a0711051123l1348ed85se7a46ab420276346@domain.hid>
Date: Mon, 5 Nov 2007 20:23:22 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2ff1a98a0711050749n4237a818p5838896f84dc9dc8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <C46506B0-FC87-46CE-9FEE-F6E031CB95C9@domain.hid>
	<2ff1a98a0711050704s51a976cp96257f2712bd15ff@domain.hid>
	<f48df4840711050730t4309e500p715314c77caa28bb@domain.hid>
	<2ff1a98a0711050749n4237a818p5838896f84dc9dc8@domain.hid>
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
To: Bruno Rouchouse <brouchouse@domain.hid>
Cc: xenomai@xenomai.org

On 11/5/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
> On 11/5/07, Bruno Rouchouse <brouchouse@domain.hid> wrote:
> > Hi Gilles,
> >
> > yes please, if you can send me your script, it would be great.
> >
> > TIA.
>
> Here comes a tarball with the script (called bx/bin/bx2.sh) and an
> example configuration which you can untar in your home directory.
> Please be careful, do not mix the directories used by the script with
> other directories of yours since the script routinely removes the
> useless files (in order to avoid using too much space if you use it
> every night).

I am trying to run this script, so a few words of advice:
- the script parse the output of a few commands, so will not work
properly if your linux is non-english. Add export LANG=C at the
beginning of the script to avoid this issue;
- you will need gpg properly installed and configured with kernel.org
signature imported for the script to verify kernel.org archives
signatures. Once gpg is configured, importing kernel.org signature is
easy:
gpg --keyserver wwwkeys.pgp.net --recv-keys 0x517D0F0E
- the script will spend a lot of time downloading kernel archives and
patches when you run it, do not worry, this will happen only once.

-- 
                                               Gilles Chanteperdrix

