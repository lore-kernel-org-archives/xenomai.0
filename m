From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Sun, 7 Dec 2014 15:05:15 +0000
Message-ID: <08dc5da0a9d94655819f8094c4ac6c7a@EX132MBOX1A.de2.local>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>
 <20141207124041.GS10014@hermes.click-hack.org>
 <76bf78d4e9644f9394558dc10207fb96@EX132MBOX1A.de2.local>,
 <20141207135204.GT10014@hermes.click-hack.org>
In-Reply-To: <20141207135204.GT10014@hermes.click-hack.org>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
> Well, then you need to replace #ifdef CONFIG_PREEMPT_RT with=0A=
> CONFIG_PREEMPT_RT_FULL, and test the kernel version in wrappers.h to=0A=
> define CONFIG_PREEMPT_RT_FULL if CONFIG_PREEMPT_RT is dedined for=0A=
> old kernels.=0A=
=0A=
I have applied both changes and try if this solves the my problem. If it wo=
rks I will publish the patch here.=0A=
=0A=
Thanks,=0A=
Christoph=

