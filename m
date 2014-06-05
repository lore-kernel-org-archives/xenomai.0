Message-ID: <53905120.2040902@xenomai.org>
Date: Thu, 05 Jun 2014 13:14:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAC66z96GX9uNm_cgzV_RSPQbep4RnwMaTwUW7qLsvfofweBkMw@mail.gmail.com>
In-Reply-To: <CAC66z96GX9uNm_cgzV_RSPQbep4RnwMaTwUW7qLsvfofweBkMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] System hangs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: yogesh garg <yogesh.garg1983@gmail.com>, xenomai@xenomai.org

On 06/05/2014 10:42 AM, yogesh garg wrote:
> Hi Everyone,
> I am using rt_heap_create() in my init_module(). rt_heap_create is
> returning 0(success).
> But after this API my system gets hang.

What version of Xenomai, what architecture ?

> 
> something like

We do not need "something like", we need a self contained example that
we can run to reproduce the issue you have.

Also note that using skins in kernel-space has been deprecated for a
long time now.

-- 
                                                                Gilles.

