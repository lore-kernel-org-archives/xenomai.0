Message-ID: <511D3A9C.3060403@xenomai.org>
Date: Thu, 14 Feb 2013 20:27:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <511B94E4.2070708@mediso.hu>
	<511B9901.7040104@xenomai.org>	<511BB60E.7090900@mediso.hu>
	<511BCA3E.4050705@xenomai.org>	<511C989C.7070700@mediso.hu>
	<511D0297.6030105@mediso.hu>
In-Reply-To: <511D0297.6030105@mediso.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Floating point operations in kernel on powerpc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Norbert Bukuli <norbert.bukuli@mediso.hu>
Cc: xenomai@xenomai.org

On 02/14/2013 04:28 PM, Norbert Bukuli wrote:

> This problem is still not resolved, so any suggestion or idea is
> highly appreciated!
> Thank you in advance!


You have two choices:
- try and spend the time reducing the kernel-space code to the bare
mininimum which produces references to this two functions, and
understand what they are used for, then throw away the result of this
work once you end-up porting your code to user-space
- ignore the uninteresting and obsolete issues you have when using FPU
in kernel-sapce and directly port your code to user-space.

-- 
                                                                Gilles.

