Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <455B8016.2020605@domain.hid>
References: <200611151121.51836.s.zimmermann@domain.hid>
	<b647ffbd0611150519w1a510582n40782bdccaa7562d@domain.hid>
	<200611151544.00429.s.zimmermann@domain.hid>
	<455B8016.2020605@domain.hid>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 23:22:21 +0100
Message-Id: <1163629342.4974.36.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-11-15 at 22:01 +0100, Jan Kiszka wrote:

> /me unfortunately failed to reproduce your problem here. Instead, I
> found a regression in SVN head - different story for a different thread.
> 

It's reproducible here. This bug triggers if you leave enough time
between queue creation and deletion for Linux to deal with its usual
business, like running workqueues... Additionally, this bug would not
trigger with different queue names passed to the creation routines. It
seems to be caused by out-of-sequence create/delete requests of /proc
entries relayed to the proc_fs subsystem, which does not perform any
sanity checks on the data it is submitted.

-- 
Philippe.



