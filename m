Message-ID: <4DC82CD1.4030605@domain.hid>
Date: Mon, 09 May 2011 20:05:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=qj7YfrFvQJPPZQbLjx=QSJqWzng@domain.hid>	<4DC430AE.20206@domain.hid>
	<BANLkTik9LH8WO8uTvWz+msGt=L61ZagJyg@domain.hid>
In-Reply-To: <BANLkTik9LH8WO8uTvWz+msGt=L61ZagJyg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] user-space support : Inconsistency detected by
 ld.so
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Aurele Traynard <aurele.traynard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 05/09/2011 08:57 AM, Aurele Traynard wrote:
> Hello
> 
> it is activate... is it bad or is there a workaround
> CONFIG_IWMMXT=y

I am unable to find the exact post, but at some point in the past around
august 2009, we commented out the code in Xenomai context switch, which
takes care of IWMMXT. This means that real-time tasks should run without
using iwmmxt. And that Xenomai should be compiled with
CONFIG_XENO_HW_FPU off.


-- 
                                                                Gilles.

