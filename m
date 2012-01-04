MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
In-Reply-To: <CA+fRa6dugu69gLWA4fRTZbbiXr2gyCN8SKb2fQaJhOx8AG+B7w@domain.hid>
References: <CA+fRa6dugu69gLWA4fRTZbbiXr2gyCN8SKb2fQaJhOx8AG+B7w@domain.hid>
Date: Wed, 4 Jan 2012 14:18:16 +0100
Message-ID: <CAAXf6LXPrkrbdnOx88q=4Jo3eDu9zPW1yEdt3cyt5nC_YMq9Qg@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] compilation problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: daniele.gottfried@domain.hid
Cc: xenomai@xenomai.org

On Wed, Jan 4, 2012 at 1:22 PM, Daniele <danielegottfried@domain.hid> wrote:
> I'm=A0trying to compile=A0an example of=A0Xenomai, but=A0gives me=A0this =
error:
>
> /usr/bin/ld : cannot find -lrtdk

You will have to provide more information than this.
The error is clear: it cannot find librtdk.so.

Did you already compile the Xenomai userspace libraries? You can't
compile an example without doing that.

