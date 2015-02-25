Date: Wed, 25 Feb 2015 13:34:47 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150225123447.GO14148@hermes.click-hack.org>
References: <CAB6vvj=9Mt0tq-=kNhv+Agr6WTH3j0+3F3kPNcMKspNzXr0NKg@mail.gmail.com>
 <20150225103604.GN14148@hermes.click-hack.org>
 <CAB6vvjmiyCr55EUfTgKW3P5WaZsUZ-5ptAN_C2CGqon5N6cWUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB6vvjmiyCr55EUfTgKW3P5WaZsUZ-5ptAN_C2CGqon5N6cWUA@mail.gmail.com>
Subject: Re: [Xenomai] rtnet issue with xenomai-3.git next branch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Antoine Hoarau <hoarau.robotics@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On Wed, Feb 25, 2015 at 10:47:58AM +0000, Antoine Hoarau wrote:
> Attached the strace for rtping.

You are missing
CONFIG_XENO_DRIVERS_NET_RTIPV4_ICMP in your kernel configuration.
ping uses icmp packets, so, if you do not enable icmp, ping is not
going to work.

> 
> >You need to load rtcap.ko (after the interface) to have the capture
> >interface.
> 
> I get :
> [  458.000857] RTcap: real-time capturing interface
> [  458.000860] RTcap: rteth0 busy, skipping device!
> [  458.000861] RTcap: no real-time devices found!

Probably because you need to load rtcap before setting up the
interface. 


-- 
					    Gilles.

