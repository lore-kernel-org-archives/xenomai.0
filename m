Message-ID: <53335E2F.4040608@xenomai.org>
Date: Thu, 27 Mar 2014 00:09:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5072ab06.2340b.144fe2d11ed.Coremail.ericvic@163.com>
 <5332BF1F.3000504@xenomai.org>
 <76a8b1fe.2477d.144fe96fb16.Coremail.ericvic@163.com>
 <5332D759.7010806@xenomai.org>
 <23d0b1ec.250da.144fecc28e4.Coremail.ericvic@163.com>
In-Reply-To: <23d0b1ec.250da.144fecc28e4.Coremail.ericvic@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] imx6q xenomai  ipipe-3.0-imx6q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/26/2014 03:29 PM, 嵌入式工程师 wrote:
> i use ipipe-gch-ipipe-3.0-imx6q.tar.bz2 with xenomai-2.6.3 /mxc/ipip-3.0.43* patch ,it is not right?

No, you should use git to checkout the ipipe-3.0-imx6q from the
ipipe-gch git, and run prepare-kernel.sh from xenomai sources, you do
not need to apply the pre- and post- patches, the ipipe-3.0-imx6q is the
branch from which the pre- and post- patches are made.


-- 
                                                                Gilles.

