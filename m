From: Wolfgang Denk <wd@domain.hid>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Wed, 26 Mar 2008 21:55:29 +0800."
	<20080326135529.GA11244@domain.hid>
Date: Wed, 26 Mar 2008 15:08:42 +0100
Sender: wd@domain.hid
Message-Id: <20080326140842.542BB243A7@domain.hid>
Subject: Re: [Xenomai-core] [SOLO] Build fail due to lack file(s)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: jserv@domain.hid
Cc: xenomai@xenomai.org

In message <20080326135529.GA11244@domain.hid> you wrote:
> 
> After git pull, I found that pSOS(*) emulation interface on top of the
> Xenomai/SOLO framework was checked in.  However, it fails to build due
> to lack file(s) in repository.  Here are the compilation results:

That is to be expected. The README  file  has  a  section  "Available
emulators/APIs"  which  only  lists VxWorks so far - nothing else has
been ported yet.

Patches are welcome, of course :-)

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@domain.hid
Just because your doctor has a name for your condition  doesn't  mean
he knows what it is.

