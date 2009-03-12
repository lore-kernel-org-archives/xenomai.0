Message-ID: <49B8FB5E.1050907@domain.hid>
Date: Thu, 12 Mar 2009 13:09:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E8013A51-96DB-4DF4-A083-C5BA81A3697B@comcast.net>	<49B8EE0A.3050708@domain.hid>
	<E48B6941-3355-4C95-9645-6DF14B5103DA@comcast.net>
	<49B8F602.9090808@domain.hid>
	<8334A175-8F99-499D-9466-5F0B508FF5DD@comcast.net>
In-Reply-To: <8334A175-8F99-499D-9466-5F0B508FF5DD@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] rtdm timer questions
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> I think I see what my problem is with the driver. The flag that is
> holding off the extra starts is stupidly not set to volatile. Oops. I'll
> report back with results later.

Be careful with volatile variables: Unless they refer to hardware-backed
data (MMIO), you may just happen to write racy lock-less code - or the
volatile is useless anyway.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

