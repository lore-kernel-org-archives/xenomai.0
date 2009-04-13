Date: Sun, 12 Apr 2009 17:42:40 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49E24045.4060204@domain.hid>
Message-ID: <Pine.LNX.4.64.0904121730060.23562@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<49E1C43A.6060009@domain.hid>
	<Pine.LNX.4.64.0904121117380.23562@domain.hid>
	<49E24045.4060204@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Xeno-test bug
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
Cc: xenomai@xenomai.org


On Sun, 12 Apr 2009, Gilles Chanteperdrix wrote:
> Ok. Thanks for taking the time to debug this. If you made modifications
> (other than replacing #!/bin/sh with #!/bin/bash) which make xeno-test
> run in your case, send a patch which we will be happy to merge.

Will do. There is also another bug in the handling of alternate loads
that needs to be fixed. For some reason it xeno-test exec's the
alternate load, instead of just running it, and this clobbers the
generate_load() sub-process that invokes it, preventing more than one
alternate load from being run, and preventing the subsequent cleanup
of the one load that is started.

By the way, I now understand why loudly() invokes commands as follows:

  eval $* &
  wait $!

The reason is that the shell postpones signal delivery while it is
awaiting the completion of any command except the wait command. So
spawning a blocking command in the background and then waiting for it
to end with the wait command, is what makes it possible for somebody
to abort xeno-test with Control-C.

Martin

