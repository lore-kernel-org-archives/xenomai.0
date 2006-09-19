Message-ID: <45107356.2050306@domain.hid>
Date: Tue, 19 Sep 2006 17:46:46 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rare brokenness in latency output - FPU bug!
References: <450E6745.6050903@domain.hid> <450F061A.6090507@domain.hid>
In-Reply-To: <450F061A.6090507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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

Jeff Webb wrote:
> I get a similar result here with xenomai-2.2.3, 2.6.17.13, x86 SMP (see 
> below).  No seg fault, though.

I get similar results if I compile a UP kernel instead of SMP.  I thought that might be a factor (since it seems most folks don't have this issue), but it seems that is not the case.

-Jeff

