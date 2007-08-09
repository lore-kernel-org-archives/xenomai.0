Message-ID: <10262.194.114.62.34.1186669406.squirrel@domain.hid>
In-Reply-To: <46BB14C7.5030903@domain.hid>
References: <54803.194.114.62.34.1186665301.squirrel@domain.hid>
	<46BB14C7.5030903@domain.hid>
Date: Thu, 9 Aug 2007 16:23:26 +0200 (CEST)
From: "Nadym Salem" <Kaiman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai kernel panic
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

On Thu, August 9, 2007 15:21, Jan Kiszka wrote:

>> as I wanted to get the new patch for Xenomai (as discussed in rtnet
>> mailing list for the rt_dev_close() issue) I had to install Xenomai 2.=
4.
>> Xenomai 2.3.2 with Rtnet 0.9.9 didn't make any trouble.
>> Since I installed 2.4 with Kernel 2.6.20 the Kernel doesn't start
>> anymore.
>> We used the same config and the same kernel but now the kernel doesn't
>> find the hard-disc anymore (waiting f=FCr /sys/block/sda/dev: no such =
file
>> or directory).
>> Any idea  ?
> Rebuild issue? Try "make clean" before building the new kernel, or buil=
d
> from a virgin kernel tree.

It is already built from a virgin tree...

> Otherwise, try to run the new kernel first without Xenomai being
> activated to check if it is a plain I-pipe issue.

Just as you said, so much to do, so little time :-)
But I will try

Greets, Nadym


