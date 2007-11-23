Message-ID: <2ff1a98a0711230723w7294a9cdvdffc583ed34ea7b6@domain.hid>
Date: Fri, 23 Nov 2007 16:23:25 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666042ABDF9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2F8EE677D406514ABE53EF9C0934A666042ABDF9@domain.hid>
Subject: Re: [Xenomai-help] Communications between Threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Laurent.POYART@fr.thalesgroup.com
Cc: xenomai@xenomai.org

On Nov 23, 2007 4:17 PM,  <Laurent.POYART@fr.thalesgroup.com> wrote:
>
> <<No, the thread has the priority you chose and is scheduled by Linux
> scheduler as any Linux task. But are you sure you are not using
> Xenomai posix message queues ?>>
>
> For the moment I don't use anything (I have no source code). I just plans to use xenomai and I try understand the communication features between heterogeneous threads. I still don't understand how the real-time thread properties (priority, scheduling policy) are used by the linux scheduler when switching from the primary mode to the secondary mode.

When in secondary mode, a Xenomai thread is not different from any Linux thread.

-- 
                                               Gilles Chanteperdrix

