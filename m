Message-ID: <5076DE61.7040002@xenomai.org>
Date: Thu, 11 Oct 2012 16:57:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <990B36E792F1A4488D3E2B1C46FD62D6943CBA5BD8@corpmail2>
	<5075CEBD.7060709@xenomai.org>
	<990B36E792F1A4488D3E2B1C46FD62D6943CBA5BF8@corpmail2>
In-Reply-To: <990B36E792F1A4488D3E2B1C46FD62D6943CBA5BF8@corpmail2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai does not recognize changed system time
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Pustylnik <MichaelPustylnik@ruggedcom.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/11/2012 04:52 PM, Michael Pustylnik wrote:
> I am trying to follow your instructions and I am confused with the
> following.
> 
> - So far I have only used native skin, never POSIX skin
> 
> - clock_settime() and clock_gettime() reside in POSIX skin and there
> are Linux equivalents in Linux libraries
> 
> - How should I link my application to make sure I invoke the
> Xenmomai's clock_settime() and clock_gettime() rather than the Linux
> native ones?

See:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_for_the_Xenomai_POSIX_skin

-- 
					    Gilles.

