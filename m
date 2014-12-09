Message-ID: <54871315.6080802@control.lth.se>
Date: Tue, 09 Dec 2014 16:19:49 +0100
From: Anders Blomdell <anders.blomdell@control.lth.se>
MIME-Version: 1.0
References: <54858FCC.7080600@control.lth.se>
 <20141209124335.GB26366@hermes.click-hack.org>
In-Reply-To: <20141209124335.GB26366@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai-3/next is out of sync with regards to
	automake/autoconf...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2014-12-09 13:43, Gilles Chanteperdrix wrote:
> On Mon, Dec 08, 2014 at 12:47:24PM +0100, Anders Blomdell wrote:
>> ...which leads to rtnet utils not being properly built. I think
>> the following is needed:
>>
>> autoconf
>> automake
>> git add configure utils/Makefile.in utils/net/Makefile.in
>> git commit
> 
> Oops. My fault. I did not commit the changes, because I do not have
> the same versions of the autotools as Philippe, so the commit would
> have changed all files (and at the time, I even had to comment out
> some code in configure.ac to get my autotools to work, but this
> issue has been resolved since then). But I forgot to tell Philippe
> to bootstrap.
> 
> Note that if you do not want to think about what commands you should
> run, you should use autoreconf. autoreconf is the reason why the
> "bootstrap" script was removed.
Figured that out after I sent the mail :-)

> I wonder if as long as Xenomai 3 is in its development stage, it
> would not make sense to remove the autotools file from the
> repository and ask the users who want to use the repository to run
> autoreconf before compiling. I do not know if it will seem
> acceptable to those who work from the repository.
Make total sense to me, would be nice with a command that does 
something like (to simplify packaging):

# XENO=$(git describe --tags | sed -e 's/v/xenomai-/') 
# git archive --prefix $XENO/ HEAD -o $XENO.tar
# tar -rf $XENO.tar all autoreconfed files
# xz $XENO.tar

/Anders
- -- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUhxMTAAoJENZYyvaDG8NcQT8H/REi1/+u9aFcIxoeNyT9a2tm
nPtdGAsUFfEOEUugiedjb7J7knE2PZwptSP7RqOi4jYhScKWDJyyVVb4CCvqOjbe
wcR4e86dtDCV101mkDdS+Fgp5oo6rDTZyM0zR4Io1gp3JHsbvORMo4HmYo3EbNfj
t2w8XzIXlign73lTH1/m9OPU0X/TDOL4dTVEGZHG43pIAl6H6B9D3lMoGTbTWXW2
1YvnDzVRucblCcaX7jXdvbB6DPYH24q9ikaJFJ8/LkGyXjdWGuMfGgKoUmCCUajd
moicW5vcbma76xdbzgZjc1TRMfD8WaJQY/oYEr5WRrvIXJYalebGC9O2kKuX9Ww=
=Y+k4
-----END PGP SIGNATURE-----

