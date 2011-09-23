Message-ID: <4E7C46C7.4050203@domain.hid>
Date: Fri, 23 Sep 2011 10:43:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL8zT=g-Mo1VDk2X9zE1d=j-k2wVRFVeNVHEuX50p7Bee5rKaQ@mail.gmail.com>
In-Reply-To: <CAL8zT=g-Mo1VDk2X9zE1d=j-k2wVRFVeNVHEuX50p7Bee5rKaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] P2020 support for ftrace with ipipe 2.12-01 and
 xeno	2.5.5.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jean-Michel Hautbois <jhautbois@domain.hid>
Cc: Xenomai-core@domain.hid

On 09/23/2011 09:58 AM, Jean-Michel Hautbois wrote:
> Hi List,
> 
> I am trying to use ftrace on a P2020 board, using the following :
> - Linux 2.6.35-11
> - Xenomai 2.5.5.1 (or 2.5.6, same problem)
> - ipipe 2.12-01
> 
> I launch it using :
> $> mkdir /tmp/debug
> $> mount -t debugfs nodev /tmp/debug
> $> cd /tmp/debug/tracing
> $> echo function_graph > current_tracer
> 
> The last one fails (it hangs the CPU, I cannot do anything than hard reset).
> Do you know what could cause that ?
> As I can't have any trace, I don't really know how to go further, and before
> using a BDI I would like to know if it is a known issue, as I could not find
> anything related to this in the recent changes...
> 
> Thanks in advance for your help,
> Regards,
> JM

Does the I-pipe tracer work?
See:
http://www.xenomai.org/index.php/I-pipe:Tracer


-- 
					    Gilles.

