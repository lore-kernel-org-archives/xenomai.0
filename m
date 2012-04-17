Message-ID: <4F8D5458.6070603@domain.hid>
Date: Tue, 17 Apr 2012 13:30:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ_VhjCVxTBBo9a-6w-2g6xiiGTkuQ6CQ1nJquR0xZCC+g@domain.hid>
In-Reply-To: <CAM1yFZ_VhjCVxTBBo9a-6w-2g6xiiGTkuQ6CQ1nJquR0xZCC+g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Understanding the output of hackbench when run
 together with xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anisha Kaul <born.rebel.83@domain.hid>
Cc: xenomai@xenomai.org

On 04/17/2012 01:11 PM, Anisha Kaul wrote:
> Greetings,
> 
> The hackbench command I issued is as follows: _______________________________
> 
> /usr/xenomai/bin/xeno-test -l "dohell -b ./hackbench -pipe 100 process 100"

You do not use dohell properly. The syntax for running dohell is
detailed below

> /usr/xenomai/bin/dohell [ -b path ] [ -s server ] [ -p port ] [ -m
> mntpoint ] [ -l path | seconds ]
> 
> Generate load, using an assorted set of commands and optionnaly:
> - hackbench if the path to the hackbench binary is specified with -b;
> - nc to send TCP data to "server" port "port" if -s is specified (if -p
> is not specified, the port 9, aka discard is used);
> - dd to write data under "mntpoint" if -m is specified.
> 
> during the runtime of the LTP test if the path to the LTP installation
> directory is specifed with -l or during "seconds" seconds.

-- 
                                                                Gilles.

