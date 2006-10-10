Subject: Re: [Xenomai-help] Former Xenomai
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <54b161f50610100346w5654f87btaf85f33b326d5628@domain.hid>
References: <54b161f50610100346w5654f87btaf85f33b326d5628@domain.hid>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 20:25:56 +0200
Message-Id: <1160504756.4967.92.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Frits de Klark <mailing.xenomai@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2006-10-10 at 12:46 +0200, Frits de Klark wrote:
> Hi everybody,
> 
> I've run into the following text on several places,
> 
> "The Xenomai project has been launched in August 2001. It has merged
> in 2003 with the RTAI project to produce an industrial-grade real-time
> Free Software platform for GNU/Linux called RTAI/fusion, on top of
> Xenomai's abstract RTOS core. Eventually, the RTAI/fusion effort
> became independent from RTAI in 2005 as the Xenomai project"
> 
> but I don't understand it completely. WHAT was Xenomai BEFORE it
> merged with RTAI in 2003?

It was a RTOS project on its own, aimed at providing an abstract kernel,
for eventually building any kind of real-time API over it. Xenomai is
and has always primarily been about allowing traditional RTOS apps to
move to Linux by providing accurate API emulation. The last version
released during the Xenomai 1 era is this one:
http://download.gna.org/xenomai/attic/xenomai-1.1.1.tar.gz

Then came the merger with the RTAI project which hosted the work on
RTAI/fusion based on the original Xenomai code, and eventually the
refoundation of the Xenomai project as an independent effort, as Xenomai
2, based on the last RTAI/fusion release 0.9.1.

-- 
Philippe.



