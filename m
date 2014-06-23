Message-ID: <53A8BB25.20107@xenomai.org>
Date: Tue, 24 Jun 2014 01:41:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <006d01cf8a3c$dee76050$9cb620f0$@caustier.com>
 <b9cc483bf98d4ce2a161d788d7d7abc0@EX132MBOX1B.de2.local>,
 <53A4201D.8020507@xenomai.org>
 <39ed57fee9f445d995e8d17a267c2fa0@EX132MBOX1B.de2.local>,
 <53A7F900.4020103@xenomai.org>
 <d54dc4eae894479c9a58f8d173d1c7cb@EX132MBOX1B.de2.local>
In-Reply-To: <d54dc4eae894479c9a58f8d173d1c7cb@EX132MBOX1B.de2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Some Information About compilation Xenomai and RT
	Patches
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/23/2014 12:04 PM, Stoidner, Christoph wrote:
> 
> Original ipipe-3.10.18 without Preempt-RT works without any problem.
> The problem occurs only in combination of my Preempt-RT merge and
> enabled FCSE in guaranteed mode.
> 
> Since unmodified ipipe-3.10 does not show the problem I assume
> unmodified ipipe-3.14 also does not show the problem. Or do you think
> 3.14 brings some more details?

I definitely fixed some FCSE issues in the ipipe-3.14 branch, mostly
when FCSE is enabled without CONFIG_IPIPE. Now if ipipe-3.10.18 has no
issues, whereas mixing Prempt-rt in makes some issues appear, I would
suggest looking carefully at the changes introduced by the preempt-rt
patch with regard to mm handling.

-- 
                                                                Gilles.

