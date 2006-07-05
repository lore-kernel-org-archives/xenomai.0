From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-help] Modification of the PSOS skin. [update]
Date: Wed, 5 Jul 2006 21:02:08 +0900
References: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14D@kheops.clb.tcfr.thales>
In-Reply-To: <FB64A9A42E10824EAC3F78D6A2CD596E04DBD14D@kheops.clb.tcfr.thales>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607052102.08369.rlenglet@domain.hid>
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

Jan Kiska wrote:
> Just a hint on the preferred patch format: either generate a
> diff of individual modified files by invoking "diff -up file
> file.orig >> my.patch" or

Just to be picky, the original file is the 1st argument, and the 
modified file the 2nd one:
diff ... file.orig file

And traditionally, people rather use the "normalized" diff 
format. This is the one recommended in the patch(1) manpage. I 
personally like the following diff options:

diff -Naurd file.orig file

Mnemotechnic tip: Naurd == Nerd ;-)

-- 
Romain LENGLET

