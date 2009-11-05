MIME-Version: 1.0
In-Reply-To: <96eea0c80911042105r19d11a70w1d47de4427c00e58@domain.hid>
References: <96eea0c80911042105r19d11a70w1d47de4427c00e58@domain.hid>
Date: Thu, 5 Nov 2009 08:39:58 +0100
Message-ID: <ddc6e05e0911042339i50e112c9x10e089206c7e9524@domain.hid>
From: Remco den Breeje <remco@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] real-time parallel port communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org

On Thu, Nov 5, 2009 at 6:05 AM, Peter Pastor <peter.pastor@domain.hid> wrote=
:
> Hello there,
>
> I need to get real-time communication over a parallel port working. I got
> the serial port to run in real-time using the drivers provided by xenomai=
.
> However, I haven't found similar drivers for the parallel port yet. Does =
the
> new analogy branch contain real-time drivers for the parallel port ??
>
> I would be happy for any hints. Also, would be cool if somebody could poi=
nt
> me to some example programs.
>
> Thanks,
> =A0peter
>

outb(char, 0x378) works for me. Or do you need something more fancy?

Cheers,

Remco den Breeje

