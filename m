Message-ID: <51B79153.9020906@xenomai.org>
Date: Tue, 11 Jun 2013 23:06:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAGqv1CgCsZbpe668VG7_+p1BT1Gs43HmH=uLe_GYZ92OXrZqgQ@mail.gmail.com>
	<51B22F1B.9090806@xenomai.org>
	<C5BABC77-A48A-4841-8CBE-1D0EAF9A8097@utexas.edu>
In-Reply-To: <C5BABC77-A48A-4841-8CBE-1D0EAF9A8097@utexas.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Conflict with Ubuntu 13.04
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Travis Llado <travisllado@utexas.edu>
Cc: Xenomai <xenomai@xenomai.org>

On 06/11/2013 04:16 PM, Travis Llado wrote:

> I will check on that. It looks like the problem is caused by the
> combination of xenomai/compiz/nvidia graphics chip. When we took the
> nvidia card out of the desktop and used onboard graphics, xeno and
> unity ran together with no problems.


If you are using nvidia drivers, not nouveau, what is missing is
probably simply to recompile them for the Xenomai-patched kernel. But in
that case I suppose your X server would not work at all.

-- 
                                                                Gilles.

