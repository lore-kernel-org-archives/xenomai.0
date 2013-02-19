Message-ID: <512369BA.60206@xenomai.org>
Date: Tue, 19 Feb 2013 13:02:02 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com> <511D4559.5030505@xenomai.org>
	<51235E42.20607@gmail.com>
In-Reply-To: <51235E42.20607@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: xenomai@xenomai.org

On 02/19/2013 12:13 PM, Manuel Huber wrote:

> Hi!
> 
> Thanks for the suggestions and sorry for the delay. I've applied the 
> patch and attached the output (still fails to boot).


The patch was not supposed to fix the bug, simply print the vector which
causes the bug. So, now we know: the vector is 0x37... I do not know
what to make of this.

-- 
                                                                Gilles.

