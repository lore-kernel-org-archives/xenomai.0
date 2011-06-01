Message-ID: <4DE5D869.9040307@domain.hid>
Date: Wed, 01 Jun 2011 08:12:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <528683.58306.qm@domain.hid>
In-Reply-To: <528683.58306.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] help-IntelAtom
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: sanjay anvekar <sanjayanvekar@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/01/2011 07:35 AM, sanjay anvekar wrote:
> Hi,
>      I am facing problem running Xenomai test programs and it gives me following error.
>> clocktest
>> /usr/xenomai/bin/clocktest: error while loading shared libraries: /usr/xenomai/lib/libpthread_rt.so.1: ELF file OS ABI invalid
> 
> similar error is seen when I try to run latency or any other Xenomai test program.

There is no need to try 100 different things. First try to compile
Xenomai and run the tests it contains. If that does not work, no need to
go further.

The problem you have seems to be a toolchain problem: the toolchain you
use does not seem to correspond to the libraries installed. Where does
the libc you use come from? Where does the toolchain you use come from?

-- 
                                                                Gilles.

