Message-ID: <5240C6D0.9030706@xenomai.org>
Date: Tue, 24 Sep 2013 00:55:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52404A46.3050801@siemens.com>
In-Reply-To: <52404A46.3050801@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] missing branches in ipipe.git when fetching via http
 from xenomai.org
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gernot Hillier <gernot.hillier@siemens.com>
Cc: xenomai@xenomai.org

On 09/23/2013 04:03 PM, Gernot Hillier wrote:
> Hi there!
> 
> Sorry if this is the wrong place to report server problems. Please let 
> me know whom to contact if this is the case...
> 
> When fetching ipipe via http://, I miss the ipipe-3.8 branch:
> 
>  > git remote add ipipe http://git.xenomai.org/ipipe.git
>  > git remote update ipipe
> [...]
>  > git branch -a | grep 3.8
>    remotes/ipipe/ipipe-3.8.0
>  > git remote rm ipipe
> 
> When using git://, everything works as expected:
> 
>  > git remote add ipipe git://git.xenomai.org/ipipe.git
>  > git remote update ipipe
> [...]
>  > git branch -a | grep 3.8
>    remotes/ipipe/ipipe-3.8
>    remotes/ipipe/ipipe-3.8.0
> 
> Unfortunately, our Siemens firewall forces us to http in most cases - so 
> it would be great if you could fix it... TIA!
> 


This is the right place. Some hooks were missing in the ipipe
repository,  this should be fixed now.

-- 
                                                                Gilles.

