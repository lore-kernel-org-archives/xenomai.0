From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Wed, 7 Oct 2015 15:32:31 -0400
Message-ID: <20151007193231.GC21923@csclub.uwaterloo.ca>
References: <560AB34B.5020300@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4342@USMLVA0EM24MSX.ww017.siemens.net>
 <560AB938.8090905@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E435B@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4474@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221E4503@USMLVA0EM24MSX.ww017.siemens.net>
 <B89CCBE86D4F62448EE4F6367C6D3C89221EA9F2@USMLVA0EM24MSX.ww017.siemens.net>
 <561568AE.30109@xenomai.org> <56156AB4.2080705@xenomai.org>
 <B89CCBE86D4F62448EE4F6367C6D3C89221ECA2A@USMLVA0EM24MSX.ww017.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B89CCBE86D4F62448EE4F6367C6D3C89221ECA2A@USMLVA0EM24MSX.ww017.siemens.net>
Subject: Re: [Xenomai] Interrupt latency close to 1ms on powerpc Xenomai
	2.6.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "PRADHAN, MAKARAND (RC-CA)" <makarand.pradhan@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Oct 07, 2015 at 07:27:15PM +0000, PRADHAN, MAKARAND (RC-CA) wrote:
> Thanks Philippe.
> 
> I understand the rationale and will have to do some more reading to grasp it entirely.
> 
> A quick question though. We have been using Xenomai for quite some time, and only in 2.6.4 did we notice excessive delays in our int handling. Was this behavior enabled in 2.6.4 or was it like this all the time?

Well 2.6.0 on 3.0 kernel we don't think we saw it.

Are we sure if it went "bad" when we moved to 3.12 or 3.14 kernel and
xenomai 2.6.4?

-- 
Len Sorensen

