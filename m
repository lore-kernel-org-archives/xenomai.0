Message-ID: <2ff1a98a0805290654w33623528yf34c610f11015220@domain.hid>
Date: Thu, 29 May 2008 15:54:24 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <51B669A8A7D2914E9AB2B3F40AC6553E646FC5@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <51B669A8A7D2914E9AB2B3F40AC6553E646FC3@domain.hid>
	<2ff1a98a0805290621r361ceb3dh601e41768983fb27@domain.hid>
	<51B669A8A7D2914E9AB2B3F40AC6553E646FC5@domain.hid>
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

On Thu, May 29, 2008 at 3:49 PM, Karch, Joshua <jkarch@domain.hid> wrote:
>
> Gilles,
>
> good thing-- I just got gdb installed and I ended up getting a Segmentation
> fault
> 0xb7e38f0d in SDLNet_CheckSockets () from /usr/lib/libSDL_net-1.2.so.0
>
> In my makefile, how would I compile for the posix skin for Xenomai?  I
> haven't explicitly specified a skin.
> I'm using rt_tasks and timers, synchronous messaging, as well as message
> queues considerably throughout my application now and don't want to lose any
> of that functionality.

I thought that the problem could be due to your application using
Xenomai posix skin services instead of using plain Linux services. But
if you do not compile for xenomai posix skin, this can not happen. So,
the problem is elsewhere.


-- 
 Gilles

