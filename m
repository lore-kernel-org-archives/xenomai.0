Message-ID: <7111.62.39.72.60.1205935226.squirrel@domain.hid>
In-Reply-To: <2ff1a98a0803190613r7572d87eibef16aecf39ef71a@domain.hid>
References: <16201.81.252.86.91.1205764989.squirrel@domain.hid> 
	<18400.53752.538963.384358@domain.hid> 
	<6621.81.252.86.91.1205927700.squirrel@domain.hid>
	<2ff1a98a0803190613r7572d87eibef16aecf39ef71a@domain.hid>
Date: Wed, 19 Mar 2008 15:00:26 +0100 (CET)
From: "Fabien MAHOT" <fabien.mahot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Application crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Fabien MAHOT <fabien.mahot@domain.hid>

> Are you sure this is the right .config ? I see that priority coupling
> is enabled.

I want the priority coupling be enabled. (I have a problem when it was
disabled : I have a main thread with highest priority which creates other
threads. When all the threads are created, the main thread reduces its
priority at the minimum, broadcats a condition and unlock the associated
mutex to start the other threads . But, after that main thread unlocks th=
e
mutex, it stays a short while in execution in spite of its priority)

With my first configuration (linux 2.6.20 with xenomai-2.3.4), the
priority coupling option was called "disable priority coupling", so in
.config, there was : # CONFIG_XENO_OPT_RPIDISABLE is not set. So, the
priority coupling was enabled.

Now, with linux 2.6.23 and xenomai-2.4.2, the priority coupling option is
called "Priority coupling support". To activate it, you must put mark. In
.config, there is : CONFIG_XENO_OPT_PRIOCPL=3Dy


