Message-ID: <2ff1a98a0711230653v2b9de755n9308cb0593fe92b3@domain.hid>
Date: Fri, 23 Nov 2007 15:53:28 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2F8EE677D406514ABE53EF9C0934A666042ABDF8@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2F8EE677D406514ABE53EF9C0934A666042ABDF8@domain.hid>
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

On Nov 23, 2007 3:45 PM,  <Laurent.POYART@fr.thalesgroup.com> wrote:
> Hi,
>
>
> <<It is possible to use a standard posix message queue within a
> real-time thread, but your real-time thread will then switch to
> secondary mode, which means it would no longer be real-time.>>
>
> Does the thread keep a higher priority compared to a standard linux thread?
> I don't really feel the effect of the switch from the primary mode to the
> secondary mode.

No, the thread has the priority you chose and is scheduled by Linux
scheduler as any Linux task. But are you sure you are not using
Xenomai posix message queues ?

-- 
                                               Gilles Chanteperdrix

