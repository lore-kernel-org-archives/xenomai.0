Date: Wed, 14 Apr 2021 14:17:26 +0200
From: Henning Schild <henning.schild@siemens.com>
Subject: Re: Path to xeno-config - packages vs. scripts
Message-ID: <20210414141726.4fc3f4c3@md1za8fc.ad001.siemens.net>
In-Reply-To: <c94b173cb6a3e8453133a98694795346ff5086a0.camel@siemens.com>
References: <c94b173cb6a3e8453133a98694795346ff5086a0.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Kiszka, Jan (T RDA IOT)" <jan.kiszka@siemens.com>

Am Wed, 14 Apr 2021 12:08:13 +0200
schrieb "Bezdeka, Florian (T RDA IOT SES-DE)"
<florian.bezdeka@siemens.com>:

> Hi!
> 
> While porting a simple application to Xenomai I had some problems
> related to the xeno-config tool:
> 
> xeno-config is part of the xenomai-runtime package when installing
> xenomai using the debian packages. I guess that's a packaging bug and
> it should be located in libxenomai-dev. Calling xeno-config having
> xenomai-runtime installed but not libxenomai-dev fails because of
> unmet dependencies.

I guess xeno-config should move into libxenomai-dev.

> While preparing a patch for that I noticed that we have documented
> "/usr/xenomai/bin/xeno-config" as path to xeno-config in the project
> wiki while debian packages install to "/usr/bin/xeno-config"
> 
> "/usr/xenomai/bin" is correct in case someone used scripts/maint/test-
> xeno-test.rb. Which path should be documented in the wiki?

Not sure that is a big issue, probably has to do with configure arg
--prefix which is non-default in the debian package. If that script is
part of any of the packages and contains absolute paths, is should
probably take the prefix into consideration.

Henning

> Best regards,
> Florian
> 
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux


