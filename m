Message-ID: <2ff1a98a0712070630n4eb262b0w88bdc159ae57bb02@domain.hid>
Date: Fri, 7 Dec 2007 15:30:43 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <475957B3.80507@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <475957B3.80507@domain.hid>
Subject: Re: [Xenomai-core] SVN issue
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Steven A. Falco" <sfalco@domain.hid>
Cc: xenomai@xenomai.org

On Dec 7, 2007 3:24 PM, Steven A. Falco <sfalco@domain.hid> wrote:
> I'm trying to checkout a new xenomai tree using svn, but I get:
>
> saf$ svn co svn://svn.gna.org/svn/xenomai/trunk xenomai
> svn: Malformed network data
>
> If instead I do:
>
> saf$ svn co http://svn.gna.org/svn/xenomai/trunk xenomai
>
> then it works.  So something seems broken with the svn protocol.  Has
> something changed on the server, or is the problem on my end?

No, I already observed the same behaviour (in the nightly script which
checkouts Xenomai and copys the documentation on the web site), but
did not look further since the http checkout work.

-- 
                                               Gilles Chanteperdrix

