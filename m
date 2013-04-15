Message-ID: <516BA7C4.1050403@grandegger.com>
Date: Mon, 15 Apr 2013 09:09:56 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>
In-Reply-To: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] patch to src/utils/can/rtcansend.c to support data
 from a file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Cc: xenomai@xenomai.org

Hi Daniel,

thanks for your contribution...

On 03/28/2013 11:00 PM, Daniel M. Drucker, Ph.D. wrote:
> When sending a large number of CAN messages from a script (in our case, to
> initialize a servo), rtcansend can be somewhat slow because every message
> requires a setup and teardown.
> 
> I added a --file flag to rtcansend which allows you to instead read bytes
> from a file (or stdin, using '-' as the filename). The file has one CAN
> message per line, in the same format (space-separated) as it would have
> been in the can-msg on the command line. Blank lines are ignored. Lines
> which start with a ' ' (space) or '#' (hash) character are ignored. If a
> filename is given, any can-msg specified on the command line is ignored.
> 
> I hope this of use to someone, and it'd be really great if this could be
> merged!

Well, I actually see it as a nice extension for a special purpose. I do
not see an general benefit for basic CAN testing. I also prefer to keep
rtcansend short and simple.

Wolfgang.

