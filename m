Date: Thu, 16 Apr 2009 19:50:49 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <91569DDB-D66D-41FA-B8C4-7B40FC526EBC@comcast.net>
Message-ID: <Pine.LNX.4.64.0904161943540.1020@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
	<49E0F887.40805@domain.hid>
	<Pine.LNX.4.64.0904111820330.6444@domain.hid>
	<49E1B05A.4040705@domain.hid>
	<Pine.LNX.4.64.0904121206040.23562@domain.hid>
	<49E23FB1.5030505@domain.hid>
	<Pine.LNX.4.64.0904151951500.9694@domain.hid>
	<4F0B1E98-862D-4031-B22E-D7DAEA554EEB@comcast.net>
	<Pine.LNX.4.64.0904161059220.24221@domain.hid>
	<91569DDB-D66D-41FA-B8C4-7B40FC526EBC@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

I have now compiled the 2.6.28.7 kernel without the xenomai patches,
but with the same configuration options that I used to compile the
xenomai-patched version of this kernel. I have thus been able to
verify that the version without the xenomai patches behaves correctly
when I run "dd if=/dev/zero of=/dev/null". The dd job gets around 99%
CPU time, and doesn't hang the computer. So unfortunately, the hangs
that I have been experiencing with the xenomai patched kernel, do
appear to be related to the xenomai patches.

Martin

