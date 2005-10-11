Message-ID: <434BC905.7060803@domain.hid>
Date: Tue, 11 Oct 2005 16:15:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] rt_alarm_create
References: <BF71144F.17CA%steve@domain.hid>
In-Reply-To: <BF71144F.17CA%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Steven Seeger <steve@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Why is there a different version of this function for user and kernel space?

Because Xeno cannot fire alarm handlers asynchronously in user-space when the 
alarm elapses at kernel level. We currently need an alarm server in user-space 
to process alarm events synchronously for the app, hence rt_alarm_wait().

> I don't see this reflected in the docs.
> 

Have a look at the "Environment" sections and notes for the alarm-related calls.

> Steven
> 
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
> 


-- 

Philippe.

