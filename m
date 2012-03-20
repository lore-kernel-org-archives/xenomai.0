Message-ID: <4F683900.5030201@domain.hid>
Date: Tue, 20 Mar 2012 09:00:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAM1yFZ9Dc6d_tzBfuho+ZHx8EDjAs1TbXOjM5EMU_wwhgFWFBg@domain.hid>
In-Reply-To: <CAM1yFZ9Dc6d_tzBfuho+ZHx8EDjAs1TbXOjM5EMU_wwhgFWFBg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] How to view the latency of my hello world
	program?
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

On 03/20/2012 08:49 AM, Anisha Kaul wrote:
> Greetings,
> 
> Distribution: OpenSuse 11.2
> Kernel: 2.6.35
> 64bit
> 
> I have compiled the hello world program shown at the bottom of this
> link: http://www.cs.ru.nl/lab/xenomai/exercises/ex01/Exercise-1.html
> It has compiled successfully.
> 
> I want to see its latency.

Then you have to modify that program in order for it to measure the
latency and print it. You can look at the "latency" test sources to see
how it can be done.

> 
> I am aware of the program "/usr/xenomai/bin/xeno-test" but I can't
> understand its output.

There is nothing magic, you have all the sources, you can look at them
to understand what happens.

-- 
                                                                Gilles.

