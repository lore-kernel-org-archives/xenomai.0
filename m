Message-ID: <4D2CE658.7060002@domain.hid>
Date: Wed, 12 Jan 2011 00:23:04 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <566288.27144.qm@domain.hid>
In-Reply-To: <566288.27144.qm@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] about rtnet usage for real time networking
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ramon Rusli <mon_nie@domain.hid>
Cc: xenomai@xenomai.org

Ramon Rusli wrote:
> Dear,
> 
> Hi, I am Ramon.I am new with xenomai and rtnet. I want to ask about
> this question: Why is Xenomai need to use RTnet as network protocol
> stack to build a real time networking? Is it crucial? Can't Xenomai
> build real-time network without RTnet (or other network protocol
> stack, if it is there)? Or is it because Xenomai didn't have service
> to build real-time networking? Or is there some kind of problem with
> Xenomai's real time network, so for solution, it use RTnet?

Xenomai is a real-time extension to the Linux kernel offering
deteministic services.
RTnet is a network stack, containing several drivers, offering
deterministic TCP/IP services. As such, it requires something providing
deterministic services. This something may be Xenomai or RTAI.

We could build another deterministic TCP/IP stack over Xenomai, but what
 for? Since RTnet does that.

The fact that RTnet is not integrated into Xenomai is just the result of
history. And maybe the fact that we always had other things to do than
to integrate it into Xenomai codebase.

-- 
                                                                Gilles.

