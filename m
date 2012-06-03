Message-ID: <4FCB9651.90003@xenomai.org>
Date: Sun, 03 Jun 2012 18:52:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACPB503JOt6DV1GP_gt0xcR_fz2owgiQow1O2uYKRpn_udDghA@mail.gmail.com>
In-Reply-To: <CACPB503JOt6DV1GP_gt0xcR_fz2owgiQow1O2uYKRpn_udDghA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] error while compiling trivial-periodic.c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Parthasarathy S <ask.partha@gmail.com>
Cc: xenomai@xenomai.org

On 06/03/2012 06:49 PM, Parthasarathy S wrote:
> Hello,
> 
> Recently I installed xenomai on a board with Intel Atom D525 processor.
> After completing the installation, as suggested by the Quick Install Guide,
> I ran 'make' from the xenomai-2.6.0/examples/native folder. I see the
> following error message. Can any one help.

Yes, Xenomai 2.6.0 examples do not compile. This has been fixed with 
the following patch:
http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=689e0433ab907958f162181d9b8c3b49012dd67a

-- 
                                                                Gilles.

