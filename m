Message-ID: <50E6E42C.9040300@xenomai.org>
Date: Fri, 04 Jan 2013 15:16:12 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <9480305C-20DF-4DBA-AC23-7E3E59EBCEEB@mah.priv.at>
	<50E1CC06.9050404@xenomai.org>
	<382C7691-29C9-408C-97DE-4A020138B0A4@mah.priv.at>
	<CANKLDmuU254PGkv2+ABiGitZDg1u9A5uq9Po=3gzOo8-KyANVw@mail.gmail.com>
	<20130103085312.GA8132@localhost.localdomain>
	<5C3D95AF-ADF8-4B1E-8FB6-5B9557262EC8@mah.priv.at>
	<20130103141552.GB9656@localhost.localdomain>
	<50E5E7D9.7020605@xenomai.org>
	<20130104085019.GA13416@localhost.localdomain>
	<50E6A5CF.7040501@xenomai.org>
	<20130104100435.GA2309@netboy.at.omicron.at>
In-Reply-To: <20130104100435.GA2309@netboy.at.omicron.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] About the timer interrupt in beaglebone
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Cochran <richardcochran@gmail.com>
Cc: xenomai@xenomai.org

On 01/04/2013 11:04 AM, Richard Cochran wrote:
> FCSE is a special, esoteric case I think. New drivers are not so hard
> to get merged, but you are right about the iterations.

Is it? Still working on that consumer device I have another example of
patch that never made it to mainline. Maybe simply different communities
have different goals?

http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-January/021885.html

https://lkml.org/lkml/2011/2/3/43

for a consumer device, it makes sense to continue working properly even
if a storage device was removed uncleanly, the linux community, on the
other hand, may consider this issue a corner case, just like using the FCSE.

-- 
					    Gilles.

