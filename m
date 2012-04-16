Message-ID: <4F8BC3FB.1040709@domain.hid>
Date: Mon, 16 Apr 2012 09:02:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAOiXNkC0xXveRSBe-YR1OV_2ZF7qZ-xPzWLjKa5b2PP5MaufLg@domain.hid>	<4F8B4B4E.7000202@domain.hid>	<CAOiXNkDXL94Y17EghAZAOLh4PFSFfFoJNnEbguLxFY054reUhA@mail.gmail.com>	<4F8B5DFD.8050502@domain.hid>	<4F8B5F57.9040608@domain.hid>
	<CAOiXNkC1_rrtmTSit4XYjXqj1RxQFbb9yEko-Mw9-5KRDqw1WQ@mail.gmail.com>
In-Reply-To: <CAOiXNkC1_rrtmTSit4XYjXqj1RxQFbb9yEko-Mw9-5KRDqw1WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] RTDM or native Xenomai API
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andrey Nechypurenko <andreynech@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 04/16/2012 08:55 AM, Andrey Nechypurenko wrote:
> Thank you very much Gilles for the explanations!
> I think I understand the overall picture better now.
> 
> Thank you,
> Andrey.

To summarize again:
- the native API and posix API were made available in kernel-space at
the beginning of the xenomai project as a mean to help porting
applications from rtai and rtlinux to xenomai, they could also be used
to write drivers, but it started to no longer make sense as soon as the
RTDM API appeared;
- they will both be gone in xenomai 3.0, only the RTDM API will be
available in kernel-space. native and posix will still be available in
user-space of course.

-- 
                                                                Gilles.

