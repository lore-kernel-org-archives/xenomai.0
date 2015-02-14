Date: Sat, 14 Feb 2015 13:37:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150214123718.GK10928@hermes.click-hack.org>
References: <CALe7ZU2dp7C7vVvtUS4co3FZTA+s22uentvWneVEbGPe9HxGwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALe7ZU2dp7C7vVvtUS4co3FZTA+s22uentvWneVEbGPe9HxGwQ@mail.gmail.com>
Subject: Re: [Xenomai] rt_dev_write function not calling back RTDM driver
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

On Sat, Feb 14, 2015 at 03:18:27PM +0530, JAY KOTHARI wrote:
> Hello,
>       What may be problem that my rt_dev_write function is not calling
> back my RTDM driver. rt_dev_open and rt_dev_close are working
> properly. rt_dev_write function is returning size -1.

-1 is -EPERM

This may happen when trying to use an RTDM descriptor from a non
real-time thread.

-- 
					    Gilles.

