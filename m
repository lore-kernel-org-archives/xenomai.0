Date: Sun, 10 Apr 2016 16:47:30 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160410144730.GI9538@hermes.click-hack.org>
References: <5708388C.6020004@mperpetuo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5708388C.6020004@mperpetuo.com>
Subject: Re: [Xenomai] arm64: kernel entry/exit tracing status
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Dmitriy Cherkasov <dmitriy@mperpetuo.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Apr 08, 2016 at 04:02:36PM -0700, Dmitriy Cherkasov wrote:
> Hello folks,
> 
> What is the status of kernel entry/exit tracing on arm64? I found two posts 
> on the mailing list with patches to enable this, but the titles seem to 
> imply that the patchset as posted is incomplete (Patch 1/2, patch 1/3).
> 
> Can someone please clarify?

I believe the first patch has been merged, and last time I used the
second, I suspected it to cause random registers corruption, so, I
abandoned it. If you feel like fixing it, then go ahead.

-- 
					    Gilles.
https://click-hack.org

