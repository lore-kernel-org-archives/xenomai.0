From: Paul <paul_c@tuxcnc.org>
Date: Fri, 19 Apr 2013 10:44:59 +0100
References: <CAG5EsAGn8oNQkH-OkEpS6NHjW7y1vZfp5HjV3+FTGi-eh667pg@mail.gmail.com>
	<CAG5EsAEfX-sseaJE6u+1mhDk_MqmEr-m4Xx8sx2_c_redLNWkQ@mail.gmail.com>
	<5170432B.3030108@xenomai.org>
In-Reply-To: <5170432B.3030108@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201304191044.59794.paul_c@tuxcnc.org>
Subject: Re: [Xenomai] rtdm and rasberry-pi GPIO
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

On Thursday 18 April 2013, Gilles Chanteperdrix wrote:
> On 04/18/2013 06:38 PM, Ross Williamson wrote:
> > Is this a bad idea from a RTlinux point of view or a style point of
> > view?
>
> It is a bad idea from a very general point of view. gpiolib does two
> things: - it ensures that no two drivers try and request the same
> gpio - if toggling a gpio state implies a read-modify-write
> operation, it protects it with a spinlock, so that no two drivers can
> interrupt each other and cause issues in the operation.

 - Code portability. As the underlying hardware evolves or you switch to 
a different board, your code requires little, if any modification.

> By accessing the registers directly, you do not get these
> protections.

