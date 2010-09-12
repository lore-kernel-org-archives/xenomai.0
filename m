Message-ID: <8de5c8d165627c406b8f847b7239a0c1.squirrel@domain.hid>
In-Reply-To: <4C8CDA1D.3070703@domain.hid>
References: <7301cc886b22b37fcbc8cda61c515d07.squirrel@domain.hid>
	<4C8C9525.1060101@domain.hid>
	<aab9b54738103bc69a5b95bab1eb1627.squirrel@domain.hid>
	<4C8CDA1D.3070703@domain.hid>
Date: Sun, 12 Sep 2010 09:13:42 -0500 (CDT)
From: "Travis Stratman" <tstratman@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Bottom half task scheduling
Reply-To: tstratman@domain.hid
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

>
> The latter is the pattern you are looking for. Just loop over
> rtdm_event_event and the work it has to perform on wakeup.
>
> Jan
>
>

Thanks Jan.

TAS


