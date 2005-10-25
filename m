Message-ID: <435EA49C.3090402@domain.hid>
Date: Tue, 25 Oct 2005 23:33:16 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] How to implement a GUI for RT apps?
References: <435D7D8C.1010004@domain.hid> <435E079F.4030108@domain.hid>
	<435E0921.20001@domain.hid> <435E5044.8090600@domain.hid>
	<435E5647.70406@domain.hid>
	<435EC897.3020601@domain.hid>
In-Reply-To: <435EC897.3020601@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD64361E760FF9A5479257128"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vincent Levesque <vleves@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD64361E760FF9A5479257128
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Vincent Levesque wrote:
> Hi Jan and Ignacio,
>
>>>> Not true. That thread must be mapped to Xenomai in order to use
>>>> rt-mutexes. Otherwise, one has to use rt-pipes.
>>>>
>
> That's the impression I had. Is there anything I should do in the GUI
> task to make it closer to a non-RT thread? Is there any way, for
> example, to make it remain in secondary mode? I already set the task to
> a low priority.

You can explicitly switch the mode (rt_task_set_mode), but this is
generally not needed.

>> Ok, an option that does not require context migrations is lock-less
>> synchronisation. For example, one may maintain revision counters of data
>> structures which get updated on changes by the RT part. The non-RT part
>> can then spin on reading a consistent version until the revision on
>> entry equals the one on exit. And double-buffering can be used to write
>> data structures into the RT domain. But this can be more complex and is
>> not feasible in each and every scenario.
>>
>>
> That's very interesting. I'm not 100% clear on what you mean though. If
> I understand correctly, I could have a single RT task and a normal
> thread (or the main thread) for the GUI. I could then use the fact that
> the RT task cannot be interupted by the GUI thread (?) to make sure data
> structures do not get corrupted. Do I get this right?

Partially. On a single-CPU system, you can make use of the fact that
RT-tasks can always complete their modifications before a non-RT-task
gets the CPU again. But this is a fragile approach if you think of
upcoming dual-core systems.

For common systems it is safer to track modifications based on some
revision counter the changing instance increments when it touches data.
The interrupted reader can than check if things changed by 1. saving the
counter, 2. reading the data, 3. comparing the counter against the
original value. If both value are the same, the read data is consistent.
Otherwise the reader has to retry. Note that this approach implies that
the read data is never in a state which can break the reader
(inconsistent pointers e.g.).

But I must confess we also once made use of the UP characteristic for
some real-time application...

Jan

--------------enigD64361E760FF9A5479257128
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDXqS8ncNeS9Q0k+IRAq0tAJ9906oAcceu/ewSR2rI+Q1g8oWMlACaA2yf
FguJ34728jb2f1+bkJyGMsU=
=uaw7
-----END PGP SIGNATURE-----

--------------enigD64361E760FF9A5479257128--

