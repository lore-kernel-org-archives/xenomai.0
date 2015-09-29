Date: Wed, 30 Sep 2015 01:07:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929230717.GG18188@hermes.click-hack.org>
References: <CANccXANz3q6=rOMO=Cbn6D1PNV2Hx4Lfy9dBw3iALYQ-cAxXuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANccXANz3q6=rOMO=Cbn6D1PNV2Hx4Lfy9dBw3iALYQ-cAxXuA@mail.gmail.com>
Subject: Re: [Xenomai] rt_dev_bind returns -ENOTTY (UDP and TCP
 Client-Server communication using RTnet)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Juan Pablo Romero Bermudez <jpromerob@hotmail.com>
Cc: xenomai@xenomai.org

On Mon, Aug 10, 2015 at 06:44:11PM +0200, Juan Pablo Romero Bermudez wrote:
> Hello,
> 
> I'm new to RTnet and I'm having trouble establishing UDP and TCP
> client-server communication using RTnet:
> 
> I'm getting -ENOTTY (-25) when calling rt_dev_bind ...

Well, you do not tell us much. In short, if you really need help,
please see:
http://xenomai.org/asking-for-help/

Just to be sure, I compiled a little udp server on xenomai 3.0-rc7
with RTnet enabled, and bind did not return ENOTTY. But maybe you do
not even be using that version.

-- 
					    Gilles.
https://click-hack.org

