Date: Mon, 21 Aug 2017 11:09:34 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20170821110934.284eb26c@md1em3qc>
In-Reply-To: <CAAaH=QErp8b3dQJp-dEOL9zHS0FDriCfH3amRpbx0Lh+RQX_ag@mail.gmail.com>
References: <CAAaH=QErp8b3dQJp-dEOL9zHS0FDriCfH3amRpbx0Lh+RQX_ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adopting the i-pipe patch to another kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mohamed atef <mohamedatefmohamed95@gmail.com>
Cc: xenomai@xenomai.org

Am Thu, 10 Aug 2017 15:39:36 +0200
schrieb mohamed atef <mohamedatefmohamed95@gmail.com>:

> Hi everyone,
> 
> I want to adopt an i-pipe patch to kernel 3.14.56. I have been
> searching for one, but I didn't find anything. I think I may use
> anyone of ipipe-core-3.14.44- patches as a reference.
> 
> Any help, please?

Just use the git version of ipipe and merge tag 'v3.14.56' into
ipipe-3.14. Git did not complain about conflicts so that might just
work. For a patch against another tree run "git diff v3.14.65".

But the real advise is to use a more recent kernel and complain with
the SoC vendor if they do not have one. And stop buying from them if
they do not care.

Henning

> Thnx in advance.
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai


