Date: Tue, 3 Mar 2015 16:11:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150303151134.GC30672@hermes.click-hack.org>
References: <CA+C+_XRjP-YeDZgOmumU+AMbuUOJEtiuJ7v5U-ijRrTQWv-qrw@mail.gmail.com>
 <20150303004406.GA30672@hermes.click-hack.org>
 <CA+C+_XTpLYq94Vxvcz3snmx7hCPbz41FajCQm3Vc=DHvYXue0A@mail.gmail.com>
 <CA+C+_XQZVy=ryVnWCzXyFCOS+SMfAC8p66-PLWMQuZNOn+hG0w@mail.gmail.com>
 <CA+C+_XR=BrBzNX4EJpLob1Bmn6uhM6rAfUxS7acPPCUpBM2TVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+C+_XR=BrBzNX4EJpLob1Bmn6uhM6rAfUxS7acPPCUpBM2TVg@mail.gmail.com>
Subject: Re: [Xenomai] gdbserver hangs on rt_task_create()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Mar 03, 2015 at 08:14:52AM -0600, Mathew Benson wrote:
> Slide 13 of a presentation I found at
> http://www.denx.de/en/pub/News/Xum2009AbstractsAndPresentations/About_the_Challenges_and_Successes_with_Xenomai_in_an_Industrial_Environment.pdf,
> states:
> 
> ">=Linux-2.6.30:  gdbserver freezes when debugging code where a thread is
> created inside of another thread."
> 
> This is exactly what I'm seeing now.  It looks like this presentation was
> written in 2009.  Is this still a known problem?

Not that I know of. Again: we fix issues with gdb when we are told
about ones. But if you are using an I-pipe patch from 2009, then
maybe yes, you have an issue that has been fixed. So, again, please
tell us the version the I-pipe patch you are using. An I-pipe patch
has a name like: ipipe-core-3.14.17-arm-4.patch

-- 
					    Gilles.

