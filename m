Message-ID: <4EAE0A35.6030802@domain.hid>
Date: Sun, 30 Oct 2011 19:38:45 -0700
From: Thomas Lockhart <Thomas.Lockhart@domain.hid>
MIME-Version: 1.0
References: <CAAeYjMmJ_LKimbvRsR5562MaYvrQGJkSx9jeP2RM3FQvewtg5Q@mail.gmail.com>
In-Reply-To: <CAAeYjMmJ_LKimbvRsR5562MaYvrQGJkSx9jeP2RM3FQvewtg5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] which skin to use
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?xYF1a2FzeiBTYWNoYQ==?= <dragilla@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/30/2011 03:47 PM, =C5=81ukasz Sacha wrote:
> Hi,
> I'm working on a device that will process several input signals (2
> analog, about 4 digital and 1 over serial interface) do some
> calculations and control 4 uarts. It will also write some log data to
> a file on an sd card.
> It will probably be a single process working in an infinite loop,
> regularly, say 50 times per second or more.
> I'm a total beginner as it comes to RT and xenomai. I have some
> experience in wrinting programs in C/C++ for linux.
> Which API should do you think will be good for me to start with?
> Which would be better for the application that I want to write?

I'd use the native API (others may have other advice, and I'd listen to=20
them if so). If you write your program using regular Linux threads, then=20
you can just add a few calls to convert the threads you need to be RT in=20
userland.

At 50Hz you might be able to get by with the regular Linux version,=20
unless you have very tight lag and jitter requirements. If you are going=20
for kHz then afaicr Linux will just not be able to schedule your tasks.

You can write your code, do initial testing, then add some #ifdef=20
XENOMAI lines to guard the extra Xenomai calls.

hth

                    - Tom

