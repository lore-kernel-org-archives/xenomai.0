Message-ID: <4FF44389.3030209@xenomai.org>
Date: Wed, 04 Jul 2012 15:22:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL7_A_WEXhEBQr+LFb_mfaqLxBh=hsHJg6WiY08cmkgb=Y2TNA@mail.gmail.com>	<4FF369E5.5040007@xenomai.org>	<CAL7_A_WYVjFhh9RuxAm1jtVp7HqakB5gEzkSt8i7XsWJNJrh=Q@mail.gmail.com>	<4FF402AD.3020601@xenomai.org>	<4FF415AB.2030503@xenomai.org>	<CAL7_A_Xr432pEEEiG4D5xsD-2yqWdgSd0tD26aEi4q0FzeWD_w@mail.gmail.com>
	<CAL7_A_XMD_KY9nryEyb3xzHpCb1PFYTG6qJupLWqRZhJXjkYRw@mail.gmail.com>
In-Reply-To: <CAL7_A_XMD_KY9nryEyb3xzHpCb1PFYTG6qJupLWqRZhJXjkYRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Xenomai and normal linux application - Wait time with
 select() not reliable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SmVucyBLw7ZobGVy?= <jenskxxx@googlemail.com>
Cc: xenomai@xenomai.org

On 07/04/2012 03:10 PM, Jens Köhler wrote:
> Linux: 2.6.26.
> Xenomai:        2.4.10
> adeos-i-pipe: 2.6.26.7

This is not the first time you ask this question, last time Jan asked
you to try a more recent version, this is still true.

But before you do that, I suggest you try to reduce the problem to its
simplest expression. For instance trying to run the latency test
concurrently with the select loop, measuring the select loop latency. If
the bug happens to trigger in these conditions, then you do not need to
port all the needed drivers on xenomai latest release to test it.

-- 
					    Gilles.

