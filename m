From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] xeno-test manpage patch
Date: Tue, 2 May 2006 11:58:03 +0900
References: <200604251502.12312.rlenglet@domain.hid>
	<200604291803.47373.rlenglet@domain.hid>
	<44565710.1070002@domain.hid>
In-Reply-To: <44565710.1070002@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605021158.03769.rlenglet@domain.hid>
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

Jim Cromie wrote:
> > By the way, I suggest that you use a timestamp in the RFC
> > 3339 format (a subset of ISO 8601):
> > date "+%Y-%m-%d %H:%M:%S%:z"
> > or, assuming date is GNU date:
> > date --rfc-3339=seconds
>
> I wanted a compact rep.
> is there a std format that doesnt have a space ?
> its nicer for us xterm double-click cut-pasters.

Replace the space with a "T": this is still an ISO 8601 format.

-- 
Romain LENGLET

