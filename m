Date: Wed, 19 Nov 2014 10:02:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141119090249.GA24219@sisyphus.hd.free.fr>
References: <CANKLDmv=sSdgO9R6cVj6VoT1MpvswS3h=W8sKpaykFaeiv0-aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANKLDmv=sSdgO9R6cVj6VoT1MpvswS3h=W8sKpaykFaeiv0-aQ@mail.gmail.com>
Subject: Re: [Xenomai] problems with ipipe-3.10 on i.MX6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Nov 19, 2014 at 09:45:26AM +0100, Henri Roosen wrote:
> Hi,
> 
> We are currently transitioning our i.MX6 systems from kernel
> ipipe-3.0-imx6q with Xenomai 2.6.2.1 to kernel ipipe-3.10 with Xenomai
> 2.6.4.
> 
> The application uses interrupts from external hardware, fed into the system
> by a GPIO pin interrupt.
> 
> The system behaves very in-stable with the 3.10 version. I observe kernel
> crashes, kernel null pointer dereferences, timer stalls and lock-ups at
> various different places. The 3.0 version runs fine.
> 
> Are there any known issues like this with the ipipe-3.10 on an i.MX6?
> Any suggestions how to tackle this problem?

Basically, as I explained yesterday, SOCs in the mainline I-pipe
patch for which I have no hardware are only build-tested. The I-pipe
patch for 3.0 is better maintained, because I have feedback from its
users.

Nevertheless, if you report patiently the errors you have reporting
one after we have solved the other, I will help you solve them all.
However, I would recommend using the 3.14 kernel, chances are that
it is not more stable, but when upgrading, there is no reason not to
upgrade to the latest.

-- 
					    Gilles.

