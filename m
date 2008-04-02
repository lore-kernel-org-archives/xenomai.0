Message-Id: <47F3917E020000010019309D@nwque-vm-gwia.criq.qc.ca>
Date: Wed, 02 Apr 2008 14:00:30 -0400
From: "Hubert Talbot" <Hubert.Talbot@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Xenomai-help] interrupt reception precision - OK
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

The problem was the trace. In fact, the trace was done by writing into a =
file.

It's not a good idea to write into a file from an rt_task...

Now, I have something like [-22609..12485] nanoseconds. Better!


Hubert



