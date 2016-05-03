Date: Tue, 3 May 2016 07:55:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160503055503.GF1761@hermes.click-hack.org>
References: <47132d04b76942d8bd15c82a5a460f7b@EDB3.wapice.localdomain>
 <20160403190948.GC20399@hermes.click-hack.org>
 <20160430064939.GC1781@hermes.click-hack.org>
 <4b738c3a791c4b80af77c3ae52f304bd@EDB3.wapice.localdomain>
 <20160502071034.GD1761@hermes.click-hack.org>
 <6d4ae5c06596495ea87d8c57f468c4a4@EDB3.wapice.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4ae5c06596495ea87d8c57f468c4a4@EDB3.wapice.localdomain>
Subject: Re: [Xenomai] A fix to few generic issues in rttcp stack
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matti Suominen <matti.suominen@wapice.com>
Cc: Lassi =?iso-8859-1?Q?Niemist=F6?= <lassi.niemisto@wapice.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, May 03, 2016 at 04:54:30AM +0000, Matti Suominen wrote:
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org] 
> Sent: 2. toukokuuta 2016 10:11
> Subject: Re: [Xenomai] A fix to few generic issues in rttcp stack
> 
> >You do not need to call rt_ip_fallback_handler, it will be called by
> >ip_input.c when dest_socket returns NULL. However, you need to
> >return, otherwise the RST|ACK is sent, which is what you wanted to
> >avoid.
> 
> Okay, there was a little misunderstanding. We tried now replacing (in 
> our latest code snippet) the fallback_handler call with just retun NULL 
> and it works as well. We agree that this is the correct solution.

Will merge, thanks.

-- 
					    Gilles.
https://click-hack.org

