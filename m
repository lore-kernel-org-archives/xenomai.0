Message-ID: <471C768B.1000100@domain.hid>
Date: Mon, 22 Oct 2007 12:08:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB256@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7A4AB256@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Xenomai v2.4-rc4: freeze with RTAI skin,
 fine with other skins
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org

Fillod Stephane wrote:
> Hi Gilles,
> 
> Thanks for the quick reply.
> 
> Gilles Chanteperdrix wrote:
>> A case of freeze is a system call called in a loop which fails without
> its return value being checked.
> 
> I forget to say that the RTAI application is running in kernel land,
> because
> no port of the RTAI skin has been made yet to user land (in fact, only
> shm access).
> So, can it still be a system call in a loop issue? Besides, the xeno 
> watchdog is not kicking.
> Once freezed, the box does not respond to ping, so this is not a
> SCHED_FIFO task stuck either.
> Still searching..

Stack space overflow issue now biting some real-time kernel thread?
Spurious delay/timeout values computed by the application (specifically:
too short), as a side-effect of the timebase introduction?

-- 
Philippe.


