Date: Thu, 3 Jan 2013 09:53:12 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20130103085312.GA8132@localhost.localdomain>
References: <CAGVaUoFsUJKCSOMrDuq3htrLzScpzjVP8oKs2ARp7k7o8KbRfQ@mail.gmail.com>
	<9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: xenomai@xenomai.org

On Wed, Jan 02, 2013 at 10:40:05AM +0100, Henri Roosen wrote:
> 
> My decision to base the port on the Arago project was also that it looked
> 'most TI official' to me. TI ships an evaluation disk with the AM335x-evm
> board that is based on this project.

The arago thing has gazillions of hacks, must of which are never going
mainline. I would avoid it if at all possible.

I have been pushing to get the beaglebone working "out of the box" in
mainline Linux, and as of v3.8-rc2 it does work with a ramfs and
Ethernet networking. However, I don't know which other drivers are
still not working on that board.

HTH,
Richard

