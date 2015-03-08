Date: Sun, 8 Mar 2015 17:32:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150308163239.GB17373@hermes.click-hack.org>
References: <CALe7ZU3FGXS+_LKmdtjSttNE+QnszDtKX4zpxOb2z+Q5JdtTgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALe7ZU3FGXS+_LKmdtjSttNE+QnszDtKX4zpxOb2z+Q5JdtTgQ@mail.gmail.com>
Subject: Re: [Xenomai] Xenomai: RTDM: closing file descriptor 0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: JAY KOTHARI <jaikothari10@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On Sun, Mar 08, 2015 at 07:14:44PM +0530, JAY KOTHARI wrote:
> Hi,
>      Even when I am calling rt_dev_close and when I dmesg I get such
> warning. What is reason for such warning?
> 
> Xenomai: RTDM: closing file descriptor 0
> 
> Can anyone give me reason for it?

You receive this message because the file descriptor 0 is still
opened when you exit your application and because you have enabled a
kernel configuration option (CONFIG_XENO_OPT_DEBUG_RTDM_APPL) to be
notified about such situations.

-- 
					    Gilles.

