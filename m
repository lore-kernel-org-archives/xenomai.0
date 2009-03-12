Message-Id: <8334A175-8F99-499D-9466-5F0B508FF5DD@comcast.net>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <49B8F602.9090808@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 12 Mar 2009 07:51:36 -0400
References: <E8013A51-96DB-4DF4-A083-C5BA81A3697B@comcast.net>	<49B8EE0A.3050708@domain.hid>
	<E48B6941-3355-4C95-9645-6DF14B5103DA@comcast.net>
	<49B8F602.9090808@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

I think I see what my problem is with the driver. The flag that is  
holding off the extra starts is stupidly not set to volatile. Oops.  
I'll report back with results later.

Thanks,
Steven


