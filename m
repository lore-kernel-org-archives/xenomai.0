Message-ID: <fd6a47a90602280908o5bc3edaam@domain.hid>
Date: Tue, 28 Feb 2006 18:08:56 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
Subject: Re: [Xenomai-help] Page faults
In-Reply-To: <44047AC6.907@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14209_6313475.1141146536903"
References: <fd6a47a90602280622o4cfb2b79g@domain.hid>
	<44047AC6.907@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

------=_Part_14209_6313475.1141146536903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Debugging tools also suggested 'normal' pagefaults. Made me look for the
mlockall() call which turns out to be unsuccessful. I made a mistake in
evaluating its (non-zero) return value, which caused the error to go by
unnoticed.

The reason mlockall() fails is that I executed the real-time program as
non-root. (Guess I'll have to figure out that daunting sudoers thing...)

Thanks for your advice, which led me in the right direction.


Jeroen.

------=_Part_14209_6313475.1141146536903
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Debugging tools also suggested 'normal' pagefaults. Made me look for t=
he mlockall() call which turns out to be&nbsp;unsuccessful. I made a mistak=
e in evaluating its (non-zero) return value, which caused the error to go b=
y unnoticed.
</div>
<div>&nbsp;</div>
<div>The reason mlockall() fails is that I executed the real-time program a=
s non-root. (Guess I'll have to figure out that daunting sudoers thing...)<=
/div>
<div>&nbsp;</div>
<div>Thanks for your advice, which led me in the right direction.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Jeroen.</div>
<div>&nbsp;</div>

------=_Part_14209_6313475.1141146536903--

