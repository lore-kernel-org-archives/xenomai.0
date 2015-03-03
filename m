Date: Tue, 3 Mar 2015 16:08:01 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150303150801.GB30672@hermes.click-hack.org>
References: <CAL92PvW2wtJ6xg3D=viNgeC7b3=Fdd_T5FoK4CsHiWnBqQGTFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL92PvW2wtJ6xg3D=viNgeC7b3=Fdd_T5FoK4CsHiWnBqQGTFg@mail.gmail.com>
Subject: Re: [Xenomai] booting problems
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: cristian ramos <cristian0084@gmail.com>
Cc: xenomai@xenomai.org

On Tue, Mar 03, 2015 at 11:02:38AM +0000, cristian ramos wrote:
>    I'm new using Xenomai and would appreciate any help / advice for solving
> the problem that I have in the booting.
> 
>    In the kernel log, I have get the following message, where I can see the
> problems with: SMI and C1E.

The notice about C1E is not a problem. Xenomai disables C1E state to
get better latency, that is all.

For the SMI problem, see the troubleshooting guide.

-- 
					    Gilles.

