Message-ID: <2ff1a98a0805290621r361ceb3dh601e41768983fb27@domain.hid>
Date: Thu, 29 May 2008 15:21:48 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and SDL NET sockets 1.2
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Karch, Joshua" <jkarch@domain.hid>
Cc: xenomai@xenomai.org

On Thu, May 29, 2008 at 5:44 AM, Karch, Joshua <jkarch@domain.hid> wrote:
>
> To whom it may concern::
> we are interested in merging our real-time tasks with Xenomai with a
> low-priority RT_TASK that uses SDL-NET to communicate from real-time tasks
> over ethernet. Unfortunately, running an RT_TASK with SDL-NET seems to have
> caused a tough-to-identify segmentation fault.

What does gdb say ?

>  The problem I am having is
> that I have been asked to add another team-member's non-realtime work which
> uses networking sockets within a low-priority RT Task.  That code uses SDL
> NET 1.2
>
> Is it possible to use SDL NET for TCP/IP communication within an RT-Task, or
> is it typically difficult to adapt a program communicating over TCP/IP into
> RTnet?

First you have to make sure that your program use the services it
think it uses. Do you compile your application for the posix skin ?
Does this SDL NET (library I assume) come as a dynamic shared object ?
or as a static archive ?

-- 
 Gilles

