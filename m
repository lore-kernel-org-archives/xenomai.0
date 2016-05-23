References: <20160502192504.GL2055@csclub.uwaterloo.ca>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <b1a516a1-6798-b2d1-ccb6-3197c5eac17d@xenomai.org>
Date: Mon, 23 May 2016 11:12:22 +0200
MIME-Version: 1.0
In-Reply-To: <20160502192504.GL2055@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] arm/ipipe: pinctrl-single: Fix build failure
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, xenomai@xenomai.org

On 05/02/2016 09:25 PM, Lennart Sorensen wrote:
> arm/ipipe: pinctrl-single: Fix build failure
> 
> A ; was lost when adding IPIPE support to the pinctrl-single.c which is
> only seen when building with IPIPE disabled.

Merged, thanks.

-- 
Philippe.

