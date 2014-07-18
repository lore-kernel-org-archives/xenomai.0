Message-ID: <53C8FFE0.9030502@xenomai.org>
Date: Fri, 18 Jul 2014 13:07:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1546174838.19906925.1405671913876.JavaMail.root@openwide.fr>
In-Reply-To: <1546174838.19906925.1405671913876.JavaMail.root@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai support for DM8148
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Pierre Ficheux <pierre.ficheux@openwide.fr>, xenomai@xenomai.org

On 07/18/2014 10:25 AM, Pierre Ficheux wrote:
> Hi all,
> 
> I'm looking for experiment about using Xenomai with TI DM8148 and "standard" TI kernel (2.6.37).
> 
> It seems standard ADEOS patch does not apply correctly to the TI kernel.

I am afraid there is not much we can do about that, the I-pipe patches
are made for mainline kernels, not for vendor forks. So, you will have
to fix the merge conflicts. Also note that since the DM8148 is an
unsupported processor, you will have to follow the porting guides.

http://www.xenomai.org/index.php/I-pipe:ArmPorting
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting

Unfortunately no porting guide works exactly for 2.6.37, it is a bit in
between the 2 guides.

-- 
                                                                Gilles.

