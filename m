Date: Thu, 21 Feb 2008 21:45:31 -0500
References: <200802202358.25792.ngustavson@domain.hid>
	<200802210944.56033.ngustavson@domain.hid>
	<47BD9763.1040304@domain.hid>
In-Reply-To: <47BD9763.1040304@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200802212145.31122.ngustavson@domain.hid>
From: NZG <metalninjadragon@domain.hid>
Subject: Re: [Xenomai-help] writing from user space through fifo problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thursday 21 February 2008 10:23:15 am Jan Kiszka wrote:
> That's good. This test will also allow you to check it against
> =A0- more recent Xenomai (please check the Changelog for pipe-related
> =A0 =A0changes since 2.3.1, I bet there are a few)
> =A0- some other arch, specifically x86 (IIRC, there is still some Linux
> =A0 =A0scheduling artifact left in the I-pipe patch for blackfin, but it
> =A0 =A0shouldn't make a difference here - well, who knows...)
Well, in the process of writing a simple test I kindof found the problem.
My user space program is writing and then immediatly closing, which appears=
 to=20
destroy the data if it hasn't been read by then. Inserting a sleep between=
=20
write and close causes it to work.

I noticed this because my test program was working because it just so happe=
ned=20
to pause until the real time task ended before closing the fd.

I remember doing this before, now that it's figured out, but it's still kin=
d=20
of problematic because it doesn't appear to be possible to block on user=20
space writes.

Opening with O_SYNC does not cause it to block, and fsync(fd) doesn't seem =
to=20
do anything. anybody have any suggestions on how to know data has been=20
received before closing a pipe after a write? Surely somebody's done this=20
before.

thanks,
NZG




