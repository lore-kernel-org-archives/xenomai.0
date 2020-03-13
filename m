From: Wolfgang Denk <wd@denx.de>
Subject: Re: Namespace pollution due to compiler.h in Xenomai 3.1
MIME-Version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
In-reply-to: <20200313141229.7C87C24003E@gemini.denx.de>
References: <CAFLxGvw70Rm88zfFXRqLv2_qJkd=k_C-mYxLCX0qnFwCYyGZyg@mail.gmail.com>
 <b5fe4180-4d04-3031-6d12-b7c9ccfa22ad@siemens.com>
 <20200313141229.7C87C24003E@gemini.denx.de>
Date: Fri, 13 Mar 2020 15:22:48 +0100
Message-Id: <20200313142248.2B7CE24003E@gemini.denx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Denk via Xenomai <xenomai@xenomai.org>

Hi,

In message <20200313141229.7C87C24003E@gemini.denx.de> I wrote:
>
> > > We noticed because out application also defines __packed...
> >
> > That's indeed bad style which I didn't realize so far. All those 
> > short-hands should be prefixed, e.g. like qt does (Q_NORETURN, Q_LIKELY 
> > etc.).
>
> Was there not a rule in ANSI C that the use of double underscores in
> identifiers is reserved compiler internal definitions?  I would expect
> that it's ok in compiler.h but incorrect in any application headers.

For example C99 section 7.1.3 (see [1]):

        All identifiers that begin with an underscore and either an
        uppercase letter or another underscore are always reserved
        for any use.

[1] https://busybox.net/~landley/c99-draft.html#7.1.3


So IMHO any definition of __packed... in application code is not
standard conforming.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If a train station is a place where a train stops,
                                           then what's a workstation?

