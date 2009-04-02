Message-ID: <49D4B4F9.6050009@domain.hid>
Date: Thu, 02 Apr 2009 14:52:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8DE810EC-5B18-4163-8793-0551C65DAAFB@comcast.net>
In-Reply-To: <8DE810EC-5B18-4163-8793-0551C65DAAFB@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] alarms
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
> Can alarms be used in userspace? I ask because the docs still say RTDM  
> timers can be used in userspace but Gilles told me they can not be.  
> Also, does the alarm run at the priority of the thread that created it  
> or does it run at a priority higher than anything else?

In case of doubts, the best documentation is the header: check in
include/native/alarm.h if the function you want to use is available in
user-space.

RTDM is special, because it only exists in kernel-space.

-- 
                                                 Gilles.

