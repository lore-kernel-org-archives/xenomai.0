Message-ID: <458936F5.2090006@domain.hid>
Date: Wed, 20 Dec 2006 14:13:25 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [RFC] git workflow
References: <20061219213010.AF2A4352664@domain.hid>	<45890361.7000709@domain.hid>
	<458925AA.6000404@domain.hid>
In-Reply-To: <458925AA.6000404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Wolfgang Denk <wd@domain.hid>

Wolfgang Grandegger wrote:
> A while ago I also played a bit with stgit and I was also not convinced, 
> that it's the right tool for our purpose. Nevertheless, I could reduce 
> the amount of git trees to manage (but I have to spend more time for a 
> better judgment).
> 
> Currently I'm porting IPIPE v1.6 over arch/powerpc rising a few code 
> management issues. I started porting with i386-1.6-01 extracting the 
> common part from that patch and adapting the arch specify code for 
> arch/powerpc. Now IPIPE is at v1.6-02 and I realized various 
> modifications, also of the noarch part including some serious bug fixes 
> (local_irq_disable_head in main.c did hang my system). But now, there is 
> no easy way to update the noarch part as we deal with combined noarch + 
> arch patches. From a new git based code management system, I would 
> appreciate a separation of noarch and arch. This would make it easier to 
> keep the archs in sync with Philippe's reference implementation (for 
> x86). Any comments?

IMHO, having the noarch and arch code separated is a nuisance. If there
was a centralized ipipe branch for 2.6.19, you would simply synchronize
your working copy with the server using the equivalent of "cvs/svn
update" and "cvs/svn commit". On the other hand, if the arch and noarch
code was separated, you would end up with twice as much updates and
commits.

-- 
                                                 Gilles Chanteperdrix

