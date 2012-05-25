Message-ID: <4FBF4782.4080600@xenomai.org>
Date: Fri, 25 May 2012 10:49:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.12.1337871081.15349.xenomai@xenomai.org>
	<COL115-W475E9F301660B2C796E3CFE2000@phx.gbl>
	<4FBE4F70.6030708@xenomai.org>
	<COL115-DS1128C9C89BA5F4218A6BEE2000@phx.gbl>
In-Reply-To: <COL115-DS1128C9C89BA5F4218A6BEE2000@phx.gbl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] help: Latency of xenomai on Portwell NANO 8044 with
 Atom Z530
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5a2Z5Lyv5p2w?= <sun.bojie@hotmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/25/2012 12:10 AM, 孙伯杰 wrote:
> Hi Gilles,
> 
> thanks for your advise.
> 
> Still one question about the threads in Linux:
> 
> Because the Java VM will map its own threads to the threads in Linux Kernel. 
> I don't know whether xenomai also have a skin to wrap the thread in Linux 
> into wrapped thread or not (just like the things have been done in POSIX 
> skin, in the link you sent me before).
> 
> However, even if the answer is yes, it seems that the provider of the VM may 
> have to make some effort in modifing its products to use the skin of xenomai 
> smoothly. Otherwise the VM still uses the Linux service and the java program 
> in it can get no benefit from the xenomai skin upon the Linux kernel.
> 
> Anyway, thanks a lot.

Yes, maybe my answer was not clear: you need to recompile the java VM to
have it use the xenomai posix skin services. In fact, everything in the
porting guide should be done to get the VM to use xenomai posix skin.

Please no private mails.

-- 
					    Gilles.

