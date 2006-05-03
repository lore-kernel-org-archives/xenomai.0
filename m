From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] xeno-test manpage patch
Date: Wed, 3 May 2006 15:09:48 +0900
References: <200604251502.12312.rlenglet@domain.hid>
	<200605021158.03769.rlenglet@domain.hid>
	<4457DC55.8030503@domain.hid>
In-Reply-To: <4457DC55.8030503@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605031509.48565.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Thomas Lockhart:
> >>I wanted a compact rep.
> >>is there a std format that doesnt have a space ?
> >>its nicer for us xterm double-click cut-pasters.
> >
> > Replace the space with a "T": this is still an ISO 8601
> > format.
>
> Just a detail: it is "ISO 9601" and (fwiw) I can confirm that
> the "T" is defined there.

I am adding some more noise... ;-)

No, it is ISO 8601. There is no ISO 9601 standard (the 9000 
series is about management / quality).
http://www.iso.org/iso/en/CatalogueDetailPage.CatalogueDetail?CSNUMBER=40874&ICS1=1&ICS2=140&ICS3=30

The interesting thing about IETF's RFC 3339 is that they have 
summarized ISO 8601's syntax in ABNF, and defined a 
non-ambiguous subset of it.
The "T" is optional in ISO 8601, but they have made it mandatory 
in RFC 3339's subset to avoid ambiguity:
"ISO 8601 states that the "T" may be omitted under some 
circumstances.  This grammar requires the "T" to avoid 
ambiguity.
[...]
iso-date-time     = date "T" time"


My mistake is, I initially thought that RFC 3339 recommended a 
space instead of "T", but this is only an option for 
readability:
"NOTE: ISO 8601 defines date and time separated by "T". 
Applications using this syntax may choose, for the sake of 
readability, to specify a full-date and full-time separated by 
(say) a space character."


This story about the ambiguity of ISO 8601 is the reason why 
the --iso-8601 option has been dropped from GNU date in favor 
of --rfc-3339. But that option is buggy, since it returns the 
date with a space instead of a "T"... I am filing a bug report!


Conclusion: let's use a "T", to be compatible with everyone! :-)

-- 
Romain LENGLET

