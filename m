MIME-Version: 1.0
In-Reply-To: <518A5F0C.50403@xenomai.org>
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>
	<518A5F0C.50403@xenomai.org>
Date: Wed, 8 May 2013 22:34:20 +0200
Message-ID: <CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

>You do not want to work around the problem, you want to fix it. There
>is probably some bit missing somewhere to get the thread control block
>destroyed when a detached thread dies.

Yes, one variable was not freed...

>Yes, I have already done that, and tried and describe it in the
>following text:
>
>http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#I.2FO_>multiplexing_with_select<http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#I.2FO_multiplexing_with_select>
>
>The posix binding for Xenomai real-time pipes has been created in the
>mean-time: it is the xddp sockets.

If I well understand, your reimplemented select calls a function that
communicates with a thread dealing with linux files descriptors through the
XDDP protocol.
At first you have separated linux and rtdm files descriptor of the select
mask. Then you send the linux files descriptor to the linux thread with the
socket.
The linux thread do its select with these files descriptor and the
pseudo-device files /dev/rtp <minor>.
The xenomai thread do its select with the rtdm files descriptor files and the
file descriptor of the socket bounded to the XDDP ports.
When a thread has its select realesed, it informs the other through the pipe
which allows to free its select.

Is that correct?
